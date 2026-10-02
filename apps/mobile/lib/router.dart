import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'auth/session.dart';
import 'screens/accept_invitation_screen.dart';
import 'screens/club/event_screen.dart';
import 'screens/club/person_screen.dart';
import 'screens/club/roster_screen.dart';
import 'screens/clubs_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/magic_link_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/two_factor_screen.dart';

const _publicRoutes = {'/login', '/auth/2fa', '/auth/magic', '/invitations/accept'};

/// Decide la destinazione in base allo stato della sessione. Separata per i test.
String? redirectFor(SessionState session, String location) {
  if (!session.ready) return location == '/splash' ? null : '/splash';
  final isPublic = _publicRoutes.contains(location);
  if (!session.isAuthenticated) {
    if (session.pendingChallenge != null && location != '/auth/2fa') return '/auth/2fa';
    return isPublic ? null : '/login';
  }
  final landing = session.currentClub == null ? '/clubs' : '/home';
  // Un magic link aperto quando l'accesso è già fatto non deve lasciare l'utente su quella schermata.
  if (location == '/splash' || location == '/login' || location == '/auth/2fa' || location == '/auth/magic') {
    return landing;
  }
  if (location == '/home' && session.currentClub == null) return '/clubs';
  return null;
}

final routerProvider = Provider<GoRouter>((ref) {
  final refresh = ValueNotifier(0);
  ref.listen(sessionProvider, (_, _) => refresh.value++);
  ref.onDispose(refresh.dispose);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: refresh,
    redirect: (_, state) => redirectFor(ref.read(sessionProvider), state.uri.path),
    routes: [
      GoRoute(path: '/splash', builder: (_, _) => const SplashScreen()),
      GoRoute(path: '/login', builder: (_, _) => const LoginScreen()),
      GoRoute(path: '/auth/2fa', builder: (_, _) => const TwoFactorScreen()),
      GoRoute(
        path: '/auth/magic',
        builder: (_, state) => MagicLinkScreen(token: state.uri.queryParameters['token'] ?? ''),
      ),
      GoRoute(
        path: '/invitations/accept',
        builder: (_, state) => AcceptInvitationScreen(token: state.uri.queryParameters['token'] ?? ''),
      ),
      GoRoute(path: '/clubs', builder: (_, _) => const ClubsScreen()),
      GoRoute(
        path: '/home',
        builder: (_, _) => const HomeScreen(),
        routes: [
          GoRoute(path: 'person/:id', builder: (_, state) => PersonScreen(personId: state.pathParameters['id']!)),
          GoRoute(path: 'team/:id', builder: (_, state) => RosterScreen(teamId: state.pathParameters['id']!)),
          GoRoute(path: 'event/:id', builder: (_, state) => EventScreen(eventId: state.pathParameters['id']!)),
        ],
      ),
    ],
    debugLogDiagnostics: kDebugMode,
  );
});
