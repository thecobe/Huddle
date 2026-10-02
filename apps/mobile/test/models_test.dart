import 'package:flutter_test/flutter_test.dart';
import 'package:huddle/api/models.dart';
import 'package:huddle/graphql/fragments.graphql.dart';

import 'fake_api.dart';

void main() {
  test('un ruolo introdotto dopo questa versione dell’app non concede accesso', () {
    final me = Me.fromFragment(Fragment$MeFields.fromJson(meJson(memberships: [
      membershipJson('c1', 'ASD Aurora', 'COACH'),
      membershipJson('c2', 'ASD Futura', 'RUOLO_FUTURO'),
    ])));
    expect(me.clubs.map((c) => c.id), ['c1']);
    expect(me.clubs.single.roles, [MembershipRole.coach]);
  });
}
