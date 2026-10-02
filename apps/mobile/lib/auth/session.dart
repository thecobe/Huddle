import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/api_client.dart';
import '../api/models.dart';
import '../graphql/auth.graphql.dart';
import '../graphql/invitations.graphql.dart';
import '../graphql/schema.graphql.dart';
import 'token_storage.dart';

final tokenStorageProvider = Provider<TokenStorage>((_) => SecureTokenStorage());
final apiClientProvider = Provider<ApiClient>((_) => ApiClient());

class SessionState {
  const SessionState({this.user, this.clubId, this.ready = false, this.pendingChallenge});

  final Me? user;
  final String? clubId;
  final bool ready;

  /// Sfida 2FA in attesa del codice.
  final String? pendingChallenge;

  bool get isAuthenticated => user != null;
  ClubAccess? get currentClub {
    for (final c in user?.clubs ?? const <ClubAccess>[]) {
      if (c.id == clubId) return c;
    }
    return null;
  }

  SessionState copyWith({Me? user, String? clubId, bool? ready, String? pendingChallenge, bool clearUser = false, bool clearClub = false, bool clearChallenge = false}) =>
      SessionState(
        user: clearUser ? null : (user ?? this.user),
        clubId: clearClub ? null : (clubId ?? this.clubId),
        ready: ready ?? this.ready,
        pendingChallenge: clearChallenge ? null : (pendingChallenge ?? this.pendingChallenge),
      );
}

final sessionProvider = NotifierProvider<SessionController, SessionState>(SessionController.new);

/// Sessione utente. Access token solo in memoria, refresh token in archivio sicuro.
class SessionController extends Notifier<SessionState> implements SessionCredentials {
  String? _accessToken;
  Future<bool>? _refreshing;

  ApiClient get _api => ref.read(apiClientProvider);
  TokenStorage get _storage => ref.read(tokenStorageProvider);

  @override
  SessionState build() {
    ref.read(apiClientProvider).credentials = this;
    return const SessionState();
  }

  @override
  String? get accessToken => _accessToken;

  @override
  String? get clubId => state.clubId;

  /// All'avvio: ripristina la sessione dal refresh token salvato.
  Future<void> bootstrap() async {
    if (state.ready) return;
    final clubId = await _storage.readClubId();
    state = state.copyWith(clubId: clubId);
    await refresh();
    state = state.copyWith(ready: true);
  }

  @override
  Future<bool> refresh() => _refreshing ??= _doRefresh().whenComplete(() => _refreshing = null);

  Future<bool> _doRefresh() async {
    final token = await _storage.readRefreshToken();
    if (token == null) return false;
    try {
      final data = await _api.mutateRaw(
        documentNodeMutationRefreshSession,
        variables: Variables$Mutation$RefreshSession(refreshToken: token).toJson(),
      );
      await _apply(AuthPayload.fromFragment(Mutation$RefreshSession.fromJson(data).refreshSession));
      return true;
    } on ApiException catch (e) {
      // Solo un token rifiutato chiude la sessione; un errore di rete la conserva per il prossimo tentativo.
      if (e.code != 'NETWORK') await _clear();
      return false;
    }
  }

  Future<AuthStatus> login(String email, String password) async {
    final data = await _api.mutate(
      documentNodeMutationLogin,
      variables: Variables$Mutation$Login(input: Input$LoginInput(email: email.trim(), password: password)).toJson(),
    );
    return _apply(AuthPayload.fromFragment(Mutation$Login.fromJson(data).login));
  }

  Future<AuthStatus> verifyTwoFactor(String code) async {
    final data = await _api.mutate(
      documentNodeMutationVerifyTwoFactor,
      variables: Variables$Mutation$VerifyTwoFactor(challengeToken: state.pendingChallenge ?? '', code: code.trim())
          .toJson(),
    );
    return _apply(AuthPayload.fromFragment(Mutation$VerifyTwoFactor.fromJson(data).verifyTwoFactor));
  }

  Future<void> requestMagicLink(String email) => _api.mutate(
        documentNodeMutationRequestMagicLink,
        variables: Variables$Mutation$RequestMagicLink(email: email.trim()).toJson(),
      );

  Future<AuthStatus> consumeMagicLink(String token) async {
    final data = await _api.mutate(
      documentNodeMutationConsumeMagicLink,
      variables: Variables$Mutation$ConsumeMagicLink(token: token).toJson(),
    );
    return _apply(AuthPayload.fromFragment(Mutation$ConsumeMagicLink.fromJson(data).consumeMagicLink));
  }

  Future<InvitationPreview> invitationPreview(String token) async {
    final data = await _api.query(
      documentNodeQueryInvitationPreview,
      variables: Variables$Query$InvitationPreview(token: token).toJson(),
    );
    return InvitationPreview.fromQuery(Query$InvitationPreview.fromJson(data).invitationPreview);
  }

  Future<AuthStatus> acceptInvitation({required String token, required String clubId, String? fullName}) async {
    final data = await _api.mutate(
      documentNodeMutationAcceptInvitation,
      variables: Variables$Mutation$AcceptInvitation(
        input: Input$AcceptInvitationInput(token: token, acceptTerms: true, fullName: fullName),
      ).toJson(),
    );
    await selectClub(clubId);
    return _apply(AuthPayload.fromFragment(Mutation$AcceptInvitation.fromJson(data).acceptInvitation));
  }

  Future<void> reloadUser() async {
    final data = await _api.query(documentNodeQueryMe);
    _setUser(Me.fromFragment(Query$Me.fromJson(data).me));
  }

  Future<void> selectClub(String? clubId) async {
    await _storage.writeClubId(clubId);
    state = clubId == null ? state.copyWith(clearClub: true) : state.copyWith(clubId: clubId);
  }

  Future<void> logout() async {
    final token = await _storage.readRefreshToken();
    try {
      await _api.mutateRaw(
        documentNodeMutationLogout,
        variables: Variables$Mutation$Logout(refreshToken: token).toJson(),
      );
    } on ApiException {
      // La sessione locale si chiude comunque.
    }
    await _clear();
  }

  Future<AuthStatus> _apply(AuthPayload payload) async {
    if (payload.status == AuthStatus.twoFactorRequired) {
      state = state.copyWith(pendingChallenge: payload.challengeToken);
      return payload.status;
    }
    _accessToken = payload.accessToken;
    if (payload.refreshToken != null) await _storage.writeRefreshToken(payload.refreshToken);
    _setUser(payload.user!);
    state = state.copyWith(clearChallenge: true);
    return payload.status;
  }

  void _setUser(Me user) {
    final ids = user.clubs.map((c) => c.id).toSet();
    var clubId = state.clubId;
    if (clubId != null && !ids.contains(clubId)) clubId = null;
    if (clubId == null && ids.length == 1) clubId = ids.first;
    if (clubId != state.clubId) _storage.writeClubId(clubId);
    state = SessionState(user: user, clubId: clubId, ready: state.ready, pendingChallenge: state.pendingChallenge);
  }

  Future<void> _clear() async {
    _accessToken = null;
    await _storage.writeRefreshToken(null);
    state = SessionState(clubId: state.clubId, ready: state.ready);
  }
}
