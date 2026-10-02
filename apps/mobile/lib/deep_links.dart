import 'package:app_links/app_links.dart';
import 'package:go_router/go_router.dart';

/// Traduce i link ricevuti via e-mail (huddle://auth/magic, huddle://invitations/accept)
/// nelle rotte dell'app. Restituisce null per link non riconosciuti.
String? routeForDeepLink(Uri uri) {
  final token = uri.queryParameters['token'];
  if (token == null || token.isEmpty) return null;
  final path = '/${uri.host}${uri.path}';
  return switch (path) {
    '/auth/magic' => Uri(path: '/auth/magic', queryParameters: {'token': token}).toString(),
    '/invitations/accept' => Uri(path: '/invitations/accept', queryParameters: {'token': token}).toString(),
    _ => null,
  };
}

void listenToDeepLinks(GoRouter router) {
  AppLinks().uriLinkStream.listen((uri) {
    final route = routeForDeepLink(uri);
    if (route != null) router.go(route);
  });
}
