import 'package:gql/ast.dart';
import 'package:graphql/client.dart';

import '../config/env.dart';

/// Errore restituito dall'API con un codice stabile (vedi apps/api/src/common/errors.ts).
class ApiException implements Exception {
  ApiException(this.code, [this.message]);
  final String code;
  final String? message;

  @override
  String toString() => 'ApiException($code${message == null ? '' : ': $message'})';
}

/// Fornisce access token e società correnti; rinnova la sessione quando il token è scaduto.
abstract class SessionCredentials {
  String? get accessToken;
  String? get clubId;
  Future<bool> refresh();
}

/// Client GraphQL senza cache: i dati di società diverse non devono mai mescolarsi.
class ApiClient {
  ApiClient({String? url, Link? link}) : _link = link ?? HttpLink(url ?? Env.apiUrl);

  final Link _link;
  SessionCredentials? credentials;

  late final GraphQLClient _client = GraphQLClient(
    link: _HeadersLink(() => credentials).concat(_link),
    cache: GraphQLCache(store: null),
    defaultPolicies: DefaultPolicies(
      query: Policies(fetch: FetchPolicy.noCache),
      mutate: Policies(fetch: FetchPolicy.noCache),
    ),
  );

  /// I documenti sono quelli generati da lib/graphql/*.graphql (`documentNode…`); le variabili
  /// arrivano da `Variables$…().toJson()` e il risultato si legge con `Query$…/Mutation$….fromJson`.
  Future<Map<String, dynamic>> query(DocumentNode document, {Map<String, dynamic> variables = const {}}) =>
      _run(() => _client.query(QueryOptions(document: document, variables: variables)));

  Future<Map<String, dynamic>> mutate(DocumentNode document, {Map<String, dynamic> variables = const {}}) =>
      _run(() => _client.mutate(MutationOptions(document: document, variables: variables)));

  /// Esegue senza tentare il rinnovo della sessione (usato dal rinnovo stesso).
  Future<Map<String, dynamic>> mutateRaw(DocumentNode document, {Map<String, dynamic> variables = const {}}) async =>
      _unwrap(await _client.mutate(MutationOptions(document: document, variables: variables)));

  Future<Map<String, dynamic>> _run(Future<QueryResult> Function() send) async {
    try {
      return _unwrap(await send());
    } on ApiException catch (e) {
      final creds = credentials;
      if (e.code == 'UNAUTHENTICATED' && creds != null && creds.accessToken != null && await creds.refresh()) {
        return _unwrap(await send());
      }
      rethrow;
    }
  }

  static Map<String, dynamic> _unwrap(QueryResult result) {
    final exception = result.exception;
    if (exception != null) {
      if (exception.graphqlErrors.isNotEmpty) {
        final error = exception.graphqlErrors.first;
        throw ApiException(error.extensions?['code'] as String? ?? 'UNKNOWN', error.message);
      }
      throw ApiException('NETWORK', exception.linkException?.toString());
    }
    return result.data ?? const {};
  }
}

/// Aggiunge Authorization e X-Tenant-Id a ogni richiesta.
class _HeadersLink extends Link {
  _HeadersLink(this._credentials);
  final SessionCredentials? Function() _credentials;

  @override
  Stream<Response> request(Request request, [NextLink? forward]) {
    final creds = _credentials();
    final headers = <String, String>{
      if (creds?.accessToken != null) 'authorization': 'Bearer ${creds!.accessToken}',
      if (creds?.clubId != null) 'x-tenant-id': creds!.clubId!,
    };
    final updated = request.updateContextEntry<HttpLinkHeaders>(
      (current) => HttpLinkHeaders(headers: {...?current?.headers, ...headers}),
    );
    return forward!(updated);
  }
}
