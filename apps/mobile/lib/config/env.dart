/// Configurazione per ambiente, passata in build con `--dart-define-from-file=env/<ambiente>.json`.
class Env {
  static const apiUrl = String.fromEnvironment('API_URL', defaultValue: 'http://localhost:4000/graphql');
  static const environment = String.fromEnvironment('ENVIRONMENT', defaultValue: 'dev');
  static const deepLinkScheme = 'huddle';
}
