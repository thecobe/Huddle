import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:huddle/api/api_client.dart';
import 'package:huddle/api/models.dart';
import 'package:huddle/auth/session.dart';
import 'package:huddle/auth/token_storage.dart';

import 'fake_api.dart';

ProviderContainer containerWith(FakeLink link, MemoryTokenStorage storage) {
  final container = ProviderContainer(overrides: [
    apiClientProvider.overrideWithValue(ApiClient(link: link)),
    tokenStorageProvider.overrideWithValue(storage),
  ]);
  addTearDown(container.dispose);
  return container;
}

void main() {
  test('login salva il refresh token e seleziona l’unica società', () async {
    final storage = MemoryTokenStorage();
    final link = FakeLink({
      'Login': (_) => {
            'data': {
              'login': authenticated(meJson(memberships: [membershipJson('c1', 'ASD Aurora', 'COACH')])),
            },
          },
    });
    final container = containerWith(link, storage);
    final session = container.read(sessionProvider.notifier);

    final status = await session.login('luca@example.test', 'password-sicura-123');

    expect(status, AuthStatus.authenticated);
    expect(storage.refreshToken, 'refresh-1');
    expect(storage.clubId, 'c1');
    expect(container.read(sessionProvider).currentClub?.roles, [MembershipRole.coach]);
    expect(session.accessToken, 'access-1');
  });

  test('2FA: la sfida resta in attesa finché il codice non è valido', () async {
    final storage = MemoryTokenStorage();
    var attempts = 0;
    final link = FakeLink({
      'Login': (_) => {
            'data': {
              'login': {
                '__typename': 'AuthPayload',
                'status': 'TWO_FACTOR_REQUIRED',
                'accessToken': null,
                'accessTokenExpiresAt': null,
                'refreshToken': null,
                'challengeToken': 'challenge-1',
                'user': null,
              },
            },
          },
      'VerifyTwoFactor': (vars) {
        attempts++;
        expect(vars['challengeToken'], 'challenge-1');
        return vars['code'] == '123456'
            ? {'data': {'verifyTwoFactor': authenticated(meJson())}}
            : error('INVALID_TWO_FACTOR_CODE');
      },
    });
    final container = containerWith(link, storage);
    final session = container.read(sessionProvider.notifier);

    expect(await session.login('a@example.test', 'x'), AuthStatus.twoFactorRequired);
    expect(container.read(sessionProvider).pendingChallenge, 'challenge-1');

    await expectLater(session.verifyTwoFactor('000000'), throwsA(isA<ApiException>()));
    expect(container.read(sessionProvider).pendingChallenge, 'challenge-1');

    await session.verifyTwoFactor('123456');
    expect(attempts, 2);
    expect(container.read(sessionProvider).isAuthenticated, isTrue);
    expect(container.read(sessionProvider).pendingChallenge, isNull);
  });

  test('bootstrap ripristina la sessione dal refresh token salvato', () async {
    final storage = MemoryTokenStorage()..refreshToken = 'saved';
    final link = FakeLink({
      'RefreshSession': (vars) {
        expect(vars['refreshToken'], 'saved');
        return {'data': {'refreshSession': authenticated(meJson())}};
      },
    });
    final container = containerWith(link, storage);
    await container.read(sessionProvider.notifier).bootstrap();
    final state = container.read(sessionProvider);
    expect(state.ready, isTrue);
    expect(state.isAuthenticated, isTrue);
    expect(storage.refreshToken, 'refresh-1');
  });

  test('refresh token rifiutato: sessione chiusa, errore di rete: token conservato', () async {
    final storage = MemoryTokenStorage()..refreshToken = 'revoked';
    final rejected = containerWith(FakeLink({'RefreshSession': (_) => error('INVALID_TOKEN')}), storage);
    await rejected.read(sessionProvider.notifier).bootstrap();
    expect(storage.refreshToken, isNull);

    final offlineStorage = MemoryTokenStorage()..refreshToken = 'valid';
    final offline = containerWith(FakeLink({'RefreshSession': (_) => error('NETWORK')}), offlineStorage);
    await offline.read(sessionProvider.notifier).bootstrap();
    expect(offlineStorage.refreshToken, 'valid');
  });

  test('token scaduto: rinnova la sessione e ripete la richiesta', () async {
    final storage = MemoryTokenStorage()..refreshToken = 'saved';
    var meCalls = 0;
    final link = FakeLink({
      'RefreshSession': (_) => {'data': {'refreshSession': authenticated(meJson())}},
      'Me': (_) => ++meCalls == 1 ? error('UNAUTHENTICATED') : {'data': {'me': meJson()}},
    });
    final container = containerWith(link, storage);
    final session = container.read(sessionProvider.notifier);
    await session.bootstrap();
    await session.reloadUser();
    expect(meCalls, 2);
    expect(link.calls.where((c) => c == 'RefreshSession').length, 2);
  });
}
