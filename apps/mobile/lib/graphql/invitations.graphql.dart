import 'fragments.graphql.dart';

import 'package:gql/ast.dart';

import 'schema.graphql.dart';

class Variables$Query$InvitationPreview {
  factory Variables$Query$InvitationPreview({required String token}) =>
      Variables$Query$InvitationPreview._({r'token': token});

  Variables$Query$InvitationPreview._(this._$data);

  factory Variables$Query$InvitationPreview.fromJson(
    Map<String, dynamic> data,
  ) {
    final result$data = <String, dynamic>{};
    final l$token = data['token'];
    result$data['token'] = (l$token as String);
    return Variables$Query$InvitationPreview._(result$data);
  }

  Map<String, dynamic> _$data;

  String get token => (_$data['token'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$token = token;
    result$data['token'] = l$token;
    return result$data;
  }

  CopyWith$Variables$Query$InvitationPreview<Variables$Query$InvitationPreview>
  get copyWith => CopyWith$Variables$Query$InvitationPreview(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Query$InvitationPreview ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$token = token;
    final lOther$token = other.token;
    if (l$token != lOther$token) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$token = token;
    return Object.hashAll([l$token]);
  }
}

abstract class CopyWith$Variables$Query$InvitationPreview<TRes> {
  factory CopyWith$Variables$Query$InvitationPreview(
    Variables$Query$InvitationPreview instance,
    TRes Function(Variables$Query$InvitationPreview) then,
  ) = _CopyWithImpl$Variables$Query$InvitationPreview;

  factory CopyWith$Variables$Query$InvitationPreview.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$InvitationPreview;

  TRes call({String? token});
}

class _CopyWithImpl$Variables$Query$InvitationPreview<TRes>
    implements CopyWith$Variables$Query$InvitationPreview<TRes> {
  _CopyWithImpl$Variables$Query$InvitationPreview(this._instance, this._then);

  final Variables$Query$InvitationPreview _instance;

  final TRes Function(Variables$Query$InvitationPreview) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? token = _undefined}) => _then(
    Variables$Query$InvitationPreview._({
      ..._instance._$data,
      if (token != _undefined && token != null) 'token': (token as String),
    }),
  );
}

class _CopyWithStubImpl$Variables$Query$InvitationPreview<TRes>
    implements CopyWith$Variables$Query$InvitationPreview<TRes> {
  _CopyWithStubImpl$Variables$Query$InvitationPreview(this._res);

  TRes _res;

  call({String? token}) => _res;
}

class Query$InvitationPreview {
  Query$InvitationPreview({
    required this.invitationPreview,
    this.$__typename = 'Query',
  });

  factory Query$InvitationPreview.fromJson(Map<String, dynamic> json) {
    final l$invitationPreview = json['invitationPreview'];
    final l$$__typename = json['__typename'];
    return Query$InvitationPreview(
      invitationPreview: Query$InvitationPreview$invitationPreview.fromJson(
        (l$invitationPreview as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$InvitationPreview$invitationPreview invitationPreview;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$invitationPreview = invitationPreview;
    _resultData['invitationPreview'] = l$invitationPreview.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$invitationPreview = invitationPreview;
    final l$$__typename = $__typename;
    return Object.hashAll([l$invitationPreview, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$InvitationPreview || runtimeType != other.runtimeType) {
      return false;
    }
    final l$invitationPreview = invitationPreview;
    final lOther$invitationPreview = other.invitationPreview;
    if (l$invitationPreview != lOther$invitationPreview) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$InvitationPreview on Query$InvitationPreview {
  CopyWith$Query$InvitationPreview<Query$InvitationPreview> get copyWith =>
      CopyWith$Query$InvitationPreview(this, (i) => i);
}

abstract class CopyWith$Query$InvitationPreview<TRes> {
  factory CopyWith$Query$InvitationPreview(
    Query$InvitationPreview instance,
    TRes Function(Query$InvitationPreview) then,
  ) = _CopyWithImpl$Query$InvitationPreview;

  factory CopyWith$Query$InvitationPreview.stub(TRes res) =
      _CopyWithStubImpl$Query$InvitationPreview;

  TRes call({
    Query$InvitationPreview$invitationPreview? invitationPreview,
    String? $__typename,
  });
  CopyWith$Query$InvitationPreview$invitationPreview<TRes>
  get invitationPreview;
}

class _CopyWithImpl$Query$InvitationPreview<TRes>
    implements CopyWith$Query$InvitationPreview<TRes> {
  _CopyWithImpl$Query$InvitationPreview(this._instance, this._then);

  final Query$InvitationPreview _instance;

  final TRes Function(Query$InvitationPreview) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? invitationPreview = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$InvitationPreview(
      invitationPreview:
          invitationPreview == _undefined || invitationPreview == null
          ? _instance.invitationPreview
          : (invitationPreview as Query$InvitationPreview$invitationPreview),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  CopyWith$Query$InvitationPreview$invitationPreview<TRes>
  get invitationPreview {
    final local$invitationPreview = _instance.invitationPreview;
    return CopyWith$Query$InvitationPreview$invitationPreview(
      local$invitationPreview,
      (e) => call(invitationPreview: e),
    );
  }
}

class _CopyWithStubImpl$Query$InvitationPreview<TRes>
    implements CopyWith$Query$InvitationPreview<TRes> {
  _CopyWithStubImpl$Query$InvitationPreview(this._res);

  TRes _res;

  call({
    Query$InvitationPreview$invitationPreview? invitationPreview,
    String? $__typename,
  }) => _res;

  CopyWith$Query$InvitationPreview$invitationPreview<TRes>
  get invitationPreview =>
      CopyWith$Query$InvitationPreview$invitationPreview.stub(_res);
}

const documentNodeQueryInvitationPreview = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'InvitationPreview'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'token')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'invitationPreview'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'token'),
                value: VariableNode(name: NameNode(value: 'token')),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'clubId'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'clubName'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'email'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'role'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'expiresAt'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'accountExists'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
              ],
            ),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ],
      ),
    ),
  ],
);

class Query$InvitationPreview$invitationPreview {
  Query$InvitationPreview$invitationPreview({
    required this.clubId,
    required this.clubName,
    required this.email,
    required this.role,
    required this.expiresAt,
    required this.accountExists,
    this.$__typename = 'InvitationPreview',
  });

  factory Query$InvitationPreview$invitationPreview.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$clubId = json['clubId'];
    final l$clubName = json['clubName'];
    final l$email = json['email'];
    final l$role = json['role'];
    final l$expiresAt = json['expiresAt'];
    final l$accountExists = json['accountExists'];
    final l$$__typename = json['__typename'];
    return Query$InvitationPreview$invitationPreview(
      clubId: (l$clubId as String),
      clubName: (l$clubName as String),
      email: (l$email as String),
      role: fromJson$Enum$MembershipRole((l$role as String)),
      expiresAt: (l$expiresAt as String),
      accountExists: (l$accountExists as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final String clubId;

  final String clubName;

  final String email;

  final Enum$MembershipRole role;

  final String expiresAt;

  final bool accountExists;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$clubId = clubId;
    _resultData['clubId'] = l$clubId;
    final l$clubName = clubName;
    _resultData['clubName'] = l$clubName;
    final l$email = email;
    _resultData['email'] = l$email;
    final l$role = role;
    _resultData['role'] = toJson$Enum$MembershipRole(l$role);
    final l$expiresAt = expiresAt;
    _resultData['expiresAt'] = l$expiresAt;
    final l$accountExists = accountExists;
    _resultData['accountExists'] = l$accountExists;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$clubId = clubId;
    final l$clubName = clubName;
    final l$email = email;
    final l$role = role;
    final l$expiresAt = expiresAt;
    final l$accountExists = accountExists;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$clubId,
      l$clubName,
      l$email,
      l$role,
      l$expiresAt,
      l$accountExists,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$InvitationPreview$invitationPreview ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$clubId = clubId;
    final lOther$clubId = other.clubId;
    if (l$clubId != lOther$clubId) {
      return false;
    }
    final l$clubName = clubName;
    final lOther$clubName = other.clubName;
    if (l$clubName != lOther$clubName) {
      return false;
    }
    final l$email = email;
    final lOther$email = other.email;
    if (l$email != lOther$email) {
      return false;
    }
    final l$role = role;
    final lOther$role = other.role;
    if (l$role != lOther$role) {
      return false;
    }
    final l$expiresAt = expiresAt;
    final lOther$expiresAt = other.expiresAt;
    if (l$expiresAt != lOther$expiresAt) {
      return false;
    }
    final l$accountExists = accountExists;
    final lOther$accountExists = other.accountExists;
    if (l$accountExists != lOther$accountExists) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$InvitationPreview$invitationPreview
    on Query$InvitationPreview$invitationPreview {
  CopyWith$Query$InvitationPreview$invitationPreview<
    Query$InvitationPreview$invitationPreview
  >
  get copyWith =>
      CopyWith$Query$InvitationPreview$invitationPreview(this, (i) => i);
}

abstract class CopyWith$Query$InvitationPreview$invitationPreview<TRes> {
  factory CopyWith$Query$InvitationPreview$invitationPreview(
    Query$InvitationPreview$invitationPreview instance,
    TRes Function(Query$InvitationPreview$invitationPreview) then,
  ) = _CopyWithImpl$Query$InvitationPreview$invitationPreview;

  factory CopyWith$Query$InvitationPreview$invitationPreview.stub(TRes res) =
      _CopyWithStubImpl$Query$InvitationPreview$invitationPreview;

  TRes call({
    String? clubId,
    String? clubName,
    String? email,
    Enum$MembershipRole? role,
    String? expiresAt,
    bool? accountExists,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$InvitationPreview$invitationPreview<TRes>
    implements CopyWith$Query$InvitationPreview$invitationPreview<TRes> {
  _CopyWithImpl$Query$InvitationPreview$invitationPreview(
    this._instance,
    this._then,
  );

  final Query$InvitationPreview$invitationPreview _instance;

  final TRes Function(Query$InvitationPreview$invitationPreview) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? clubId = _undefined,
    Object? clubName = _undefined,
    Object? email = _undefined,
    Object? role = _undefined,
    Object? expiresAt = _undefined,
    Object? accountExists = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$InvitationPreview$invitationPreview(
      clubId: clubId == _undefined || clubId == null
          ? _instance.clubId
          : (clubId as String),
      clubName: clubName == _undefined || clubName == null
          ? _instance.clubName
          : (clubName as String),
      email: email == _undefined || email == null
          ? _instance.email
          : (email as String),
      role: role == _undefined || role == null
          ? _instance.role
          : (role as Enum$MembershipRole),
      expiresAt: expiresAt == _undefined || expiresAt == null
          ? _instance.expiresAt
          : (expiresAt as String),
      accountExists: accountExists == _undefined || accountExists == null
          ? _instance.accountExists
          : (accountExists as bool),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$InvitationPreview$invitationPreview<TRes>
    implements CopyWith$Query$InvitationPreview$invitationPreview<TRes> {
  _CopyWithStubImpl$Query$InvitationPreview$invitationPreview(this._res);

  TRes _res;

  call({
    String? clubId,
    String? clubName,
    String? email,
    Enum$MembershipRole? role,
    String? expiresAt,
    bool? accountExists,
    String? $__typename,
  }) => _res;
}

class Variables$Mutation$AcceptInvitation {
  factory Variables$Mutation$AcceptInvitation({
    required Input$AcceptInvitationInput input,
  }) => Variables$Mutation$AcceptInvitation._({r'input': input});

  Variables$Mutation$AcceptInvitation._(this._$data);

  factory Variables$Mutation$AcceptInvitation.fromJson(
    Map<String, dynamic> data,
  ) {
    final result$data = <String, dynamic>{};
    final l$input = data['input'];
    result$data['input'] = Input$AcceptInvitationInput.fromJson(
      (l$input as Map<String, dynamic>),
    );
    return Variables$Mutation$AcceptInvitation._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$AcceptInvitationInput get input =>
      (_$data['input'] as Input$AcceptInvitationInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$input = input;
    result$data['input'] = l$input.toJson();
    return result$data;
  }

  CopyWith$Variables$Mutation$AcceptInvitation<
    Variables$Mutation$AcceptInvitation
  >
  get copyWith => CopyWith$Variables$Mutation$AcceptInvitation(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$AcceptInvitation ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$input = input;
    final lOther$input = other.input;
    if (l$input != lOther$input) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$input = input;
    return Object.hashAll([l$input]);
  }
}

abstract class CopyWith$Variables$Mutation$AcceptInvitation<TRes> {
  factory CopyWith$Variables$Mutation$AcceptInvitation(
    Variables$Mutation$AcceptInvitation instance,
    TRes Function(Variables$Mutation$AcceptInvitation) then,
  ) = _CopyWithImpl$Variables$Mutation$AcceptInvitation;

  factory CopyWith$Variables$Mutation$AcceptInvitation.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$AcceptInvitation;

  TRes call({Input$AcceptInvitationInput? input});
}

class _CopyWithImpl$Variables$Mutation$AcceptInvitation<TRes>
    implements CopyWith$Variables$Mutation$AcceptInvitation<TRes> {
  _CopyWithImpl$Variables$Mutation$AcceptInvitation(this._instance, this._then);

  final Variables$Mutation$AcceptInvitation _instance;

  final TRes Function(Variables$Mutation$AcceptInvitation) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? input = _undefined}) => _then(
    Variables$Mutation$AcceptInvitation._({
      ..._instance._$data,
      if (input != _undefined && input != null)
        'input': (input as Input$AcceptInvitationInput),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$AcceptInvitation<TRes>
    implements CopyWith$Variables$Mutation$AcceptInvitation<TRes> {
  _CopyWithStubImpl$Variables$Mutation$AcceptInvitation(this._res);

  TRes _res;

  call({Input$AcceptInvitationInput? input}) => _res;
}

class Mutation$AcceptInvitation {
  Mutation$AcceptInvitation({
    required this.acceptInvitation,
    this.$__typename = 'Mutation',
  });

  factory Mutation$AcceptInvitation.fromJson(Map<String, dynamic> json) {
    final l$acceptInvitation = json['acceptInvitation'];
    final l$$__typename = json['__typename'];
    return Mutation$AcceptInvitation(
      acceptInvitation: Fragment$AuthFields.fromJson(
        (l$acceptInvitation as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$AuthFields acceptInvitation;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$acceptInvitation = acceptInvitation;
    _resultData['acceptInvitation'] = l$acceptInvitation.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$acceptInvitation = acceptInvitation;
    final l$$__typename = $__typename;
    return Object.hashAll([l$acceptInvitation, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$AcceptInvitation ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$acceptInvitation = acceptInvitation;
    final lOther$acceptInvitation = other.acceptInvitation;
    if (l$acceptInvitation != lOther$acceptInvitation) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$AcceptInvitation
    on Mutation$AcceptInvitation {
  CopyWith$Mutation$AcceptInvitation<Mutation$AcceptInvitation> get copyWith =>
      CopyWith$Mutation$AcceptInvitation(this, (i) => i);
}

abstract class CopyWith$Mutation$AcceptInvitation<TRes> {
  factory CopyWith$Mutation$AcceptInvitation(
    Mutation$AcceptInvitation instance,
    TRes Function(Mutation$AcceptInvitation) then,
  ) = _CopyWithImpl$Mutation$AcceptInvitation;

  factory CopyWith$Mutation$AcceptInvitation.stub(TRes res) =
      _CopyWithStubImpl$Mutation$AcceptInvitation;

  TRes call({Fragment$AuthFields? acceptInvitation, String? $__typename});
  CopyWith$Fragment$AuthFields<TRes> get acceptInvitation;
}

class _CopyWithImpl$Mutation$AcceptInvitation<TRes>
    implements CopyWith$Mutation$AcceptInvitation<TRes> {
  _CopyWithImpl$Mutation$AcceptInvitation(this._instance, this._then);

  final Mutation$AcceptInvitation _instance;

  final TRes Function(Mutation$AcceptInvitation) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? acceptInvitation = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$AcceptInvitation(
      acceptInvitation:
          acceptInvitation == _undefined || acceptInvitation == null
          ? _instance.acceptInvitation
          : (acceptInvitation as Fragment$AuthFields),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  CopyWith$Fragment$AuthFields<TRes> get acceptInvitation {
    final local$acceptInvitation = _instance.acceptInvitation;
    return CopyWith$Fragment$AuthFields(
      local$acceptInvitation,
      (e) => call(acceptInvitation: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$AcceptInvitation<TRes>
    implements CopyWith$Mutation$AcceptInvitation<TRes> {
  _CopyWithStubImpl$Mutation$AcceptInvitation(this._res);

  TRes _res;

  call({Fragment$AuthFields? acceptInvitation, String? $__typename}) => _res;

  CopyWith$Fragment$AuthFields<TRes> get acceptInvitation =>
      CopyWith$Fragment$AuthFields.stub(_res);
}

const documentNodeMutationAcceptInvitation = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'AcceptInvitation'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'input')),
          type: NamedTypeNode(
            name: NameNode(value: 'AcceptInvitationInput'),
            isNonNull: true,
          ),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'acceptInvitation'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'input'),
                value: VariableNode(name: NameNode(value: 'input')),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FragmentSpreadNode(
                  name: NameNode(value: 'AuthFields'),
                  directives: [],
                ),
                FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
              ],
            ),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ],
      ),
    ),
    fragmentDefinitionAuthFields,
    fragmentDefinitionMeFields,
  ],
);
