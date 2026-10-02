import 'package:graphql/client.dart';

/// Link GraphQL finto: risponde in base al nome dell'operazione.
class FakeLink extends Link {
  FakeLink(this.handlers);

  final Map<String, Map<String, dynamic> Function(Map<String, dynamic> variables)> handlers;
  final calls = <String>[];

  @override
  Stream<Response> request(Request request, [NextLink? forward]) async* {
    // La prima definizione del documento è l'operazione (i frammenti seguono).
    final operation = request.operation.document.definitions.first as dynamic;
    final name = request.operation.operationName ?? (operation.name.value as String);
    // Come il server reale: i documenti generati chiedono __typename anche sulla radice.
    final rootType = operation.type.toString().endsWith('mutation') ? 'Mutation' : 'Query';
    calls.add(name);
    final handler = handlers[name];
    if (handler == null) throw StateError('Operazione non prevista: $name');
    final body = handler(request.variables);
    final errors = (body['errors'] as List?)
        ?.map((e) => GraphQLError(message: e['message'] as String, extensions: e['extensions'] as Map<String, dynamic>?))
        .toList();
    final data = body['data'] as Map<String, dynamic>?;
    yield Response(
      data: data == null ? null : {'__typename': rootType, ...data},
      errors: errors,
      response: body,
    );
  }
}

Map<String, dynamic> meJson({List<Map<String, dynamic>> memberships = const []}) => {
      '__typename': 'Me',
      'id': 'u1',
      'email': 'luca@example.test',
      'fullName': 'Luca Verdi',
      'locale': 'it',
      'twoFactorEnabled': false,
      'memberships': memberships,
    };

Map<String, dynamic> membershipJson(String clubId, String clubName, String role) => {
      '__typename': 'MembershipSummary',
      'id': 'm-$clubId-$role',
      'role': role,
      'teamId': null,
      'clubId': clubId,
      'clubName': clubName,
    };

Map<String, dynamic> authenticated(Map<String, dynamic> user) => {
      '__typename': 'AuthPayload',
      'status': 'AUTHENTICATED',
      'accessToken': 'access-1',
      'accessTokenExpiresAt': '2026-10-02T10:00:00.000Z',
      'refreshToken': 'refresh-1',
      'challengeToken': null,
      'user': user,
    };

Map<String, dynamic> error(String code) => {
      'data': null,
      'errors': [
        {'message': code, 'extensions': {'code': code}},
      ],
    };
