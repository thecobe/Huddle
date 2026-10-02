import 'package:flutter_test/flutter_test.dart';
import 'package:huddle/api/models.dart';
import 'package:huddle/auth/session.dart';
import 'package:huddle/deep_links.dart';
import 'package:huddle/router.dart';

Me me(List<Membership> memberships) => Me(
      id: 'u1',
      email: 'a@example.test',
      fullName: 'Anna Neri',
      locale: 'it',
      twoFactorEnabled: false,
      memberships: memberships,
    );

void main() {
  group('redirectFor', () {
    test('mostra lo splash finché la sessione non è pronta', () {
      expect(redirectFor(const SessionState(), '/home'), '/splash');
    });

    test('senza login consente solo le pagine pubbliche', () {
      const s = SessionState(ready: true);
      expect(redirectFor(s, '/home'), '/login');
      expect(redirectFor(s, '/invitations/accept'), isNull);
      expect(redirectFor(s, '/auth/magic'), isNull);
    });

    test('sfida 2FA in corso porta alla verifica', () {
      expect(redirectFor(const SessionState(ready: true, pendingChallenge: 'c'), '/login'), '/auth/2fa');
    });

    test('dopo il login: scelta società o home', () {
      final user = me([Membership(id: 'm', role: MembershipRole.parent, clubId: 'c1', clubName: 'ASD')]);
      expect(redirectFor(SessionState(ready: true, user: user), '/login'), '/clubs');
      expect(redirectFor(SessionState(ready: true, user: user, clubId: 'c1'), '/login'), '/home');
      expect(redirectFor(SessionState(ready: true, user: user, clubId: 'altro'), '/home'), '/clubs');
    });

    test('con accesso già fatto il magic link porta alla home, l’invito resta apribile', () {
      final user = me([Membership(id: 'm', role: MembershipRole.coach, clubId: 'c1', clubName: 'ASD')]);
      final s = SessionState(ready: true, user: user, clubId: 'c1');
      expect(redirectFor(s, '/auth/magic'), '/home');
      expect(redirectFor(s, '/invitations/accept'), isNull);
    });
  });

  test('raggruppa i ruoli per società', () {
    final user = me([
      Membership(id: '1', role: MembershipRole.coach, clubId: 'c1', clubName: 'Beta'),
      Membership(id: '2', role: MembershipRole.parent, clubId: 'c1', clubName: 'Beta'),
      Membership(id: '3', role: MembershipRole.athlete, clubId: 'c2', clubName: 'Alfa'),
    ]);
    expect(user.clubs.map((c) => c.name), ['Alfa', 'Beta']);
    expect(user.clubs.last.roles, [MembershipRole.coach, MembershipRole.parent]);
  });

  group('deep link', () {
    test('magic link e invito', () {
      expect(routeForDeepLink(Uri.parse('huddle://auth/magic?token=abc')), '/auth/magic?token=abc');
      expect(routeForDeepLink(Uri.parse('huddle://invitations/accept?token=x-y_z')), '/invitations/accept?token=x-y_z');
    });

    test('ignora link sconosciuti o senza token', () {
      expect(routeForDeepLink(Uri.parse('huddle://auth/magic')), isNull);
      expect(routeForDeepLink(Uri.parse('huddle://altro/percorso?token=a')), isNull);
    });
  });
}
