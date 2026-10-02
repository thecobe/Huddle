import 'fragments.graphql.dart';

import 'package:gql/ast.dart';

import 'schema.graphql.dart';

class Variables$Mutation$Login {
  factory Variables$Mutation$Login({required Input$LoginInput input}) =>
      Variables$Mutation$Login._({r'input': input});

  Variables$Mutation$Login._(this._$data);

  factory Variables$Mutation$Login.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$input = data['input'];
    result$data['input'] = Input$LoginInput.fromJson(
      (l$input as Map<String, dynamic>),
    );
    return Variables$Mutation$Login._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$LoginInput get input => (_$data['input'] as Input$LoginInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$input = input;
    result$data['input'] = l$input.toJson();
    return result$data;
  }

  CopyWith$Variables$Mutation$Login<Variables$Mutation$Login> get copyWith =>
      CopyWith$Variables$Mutation$Login(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$Login ||
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

abstract class CopyWith$Variables$Mutation$Login<TRes> {
  factory CopyWith$Variables$Mutation$Login(
    Variables$Mutation$Login instance,
    TRes Function(Variables$Mutation$Login) then,
  ) = _CopyWithImpl$Variables$Mutation$Login;

  factory CopyWith$Variables$Mutation$Login.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$Login;

  TRes call({Input$LoginInput? input});
}

class _CopyWithImpl$Variables$Mutation$Login<TRes>
    implements CopyWith$Variables$Mutation$Login<TRes> {
  _CopyWithImpl$Variables$Mutation$Login(this._instance, this._then);

  final Variables$Mutation$Login _instance;

  final TRes Function(Variables$Mutation$Login) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? input = _undefined}) => _then(
    Variables$Mutation$Login._({
      ..._instance._$data,
      if (input != _undefined && input != null)
        'input': (input as Input$LoginInput),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$Login<TRes>
    implements CopyWith$Variables$Mutation$Login<TRes> {
  _CopyWithStubImpl$Variables$Mutation$Login(this._res);

  TRes _res;

  call({Input$LoginInput? input}) => _res;
}

class Mutation$Login {
  Mutation$Login({required this.login, this.$__typename = 'Mutation'});

  factory Mutation$Login.fromJson(Map<String, dynamic> json) {
    final l$login = json['login'];
    final l$$__typename = json['__typename'];
    return Mutation$Login(
      login: Fragment$AuthFields.fromJson((l$login as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$AuthFields login;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$login = login;
    _resultData['login'] = l$login.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$login = login;
    final l$$__typename = $__typename;
    return Object.hashAll([l$login, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$Login || runtimeType != other.runtimeType) {
      return false;
    }
    final l$login = login;
    final lOther$login = other.login;
    if (l$login != lOther$login) {
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

extension UtilityExtension$Mutation$Login on Mutation$Login {
  CopyWith$Mutation$Login<Mutation$Login> get copyWith =>
      CopyWith$Mutation$Login(this, (i) => i);
}

abstract class CopyWith$Mutation$Login<TRes> {
  factory CopyWith$Mutation$Login(
    Mutation$Login instance,
    TRes Function(Mutation$Login) then,
  ) = _CopyWithImpl$Mutation$Login;

  factory CopyWith$Mutation$Login.stub(TRes res) =
      _CopyWithStubImpl$Mutation$Login;

  TRes call({Fragment$AuthFields? login, String? $__typename});
  CopyWith$Fragment$AuthFields<TRes> get login;
}

class _CopyWithImpl$Mutation$Login<TRes>
    implements CopyWith$Mutation$Login<TRes> {
  _CopyWithImpl$Mutation$Login(this._instance, this._then);

  final Mutation$Login _instance;

  final TRes Function(Mutation$Login) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? login = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Mutation$Login(
          login: login == _undefined || login == null
              ? _instance.login
              : (login as Fragment$AuthFields),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
        ),
      );

  CopyWith$Fragment$AuthFields<TRes> get login {
    final local$login = _instance.login;
    return CopyWith$Fragment$AuthFields(local$login, (e) => call(login: e));
  }
}

class _CopyWithStubImpl$Mutation$Login<TRes>
    implements CopyWith$Mutation$Login<TRes> {
  _CopyWithStubImpl$Mutation$Login(this._res);

  TRes _res;

  call({Fragment$AuthFields? login, String? $__typename}) => _res;

  CopyWith$Fragment$AuthFields<TRes> get login =>
      CopyWith$Fragment$AuthFields.stub(_res);
}

const documentNodeMutationLogin = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'Login'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'input')),
          type: NamedTypeNode(
            name: NameNode(value: 'LoginInput'),
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
            name: NameNode(value: 'login'),
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

class Variables$Mutation$VerifyTwoFactor {
  factory Variables$Mutation$VerifyTwoFactor({
    required String challengeToken,
    required String code,
  }) => Variables$Mutation$VerifyTwoFactor._({
    r'challengeToken': challengeToken,
    r'code': code,
  });

  Variables$Mutation$VerifyTwoFactor._(this._$data);

  factory Variables$Mutation$VerifyTwoFactor.fromJson(
    Map<String, dynamic> data,
  ) {
    final result$data = <String, dynamic>{};
    final l$challengeToken = data['challengeToken'];
    result$data['challengeToken'] = (l$challengeToken as String);
    final l$code = data['code'];
    result$data['code'] = (l$code as String);
    return Variables$Mutation$VerifyTwoFactor._(result$data);
  }

  Map<String, dynamic> _$data;

  String get challengeToken => (_$data['challengeToken'] as String);

  String get code => (_$data['code'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$challengeToken = challengeToken;
    result$data['challengeToken'] = l$challengeToken;
    final l$code = code;
    result$data['code'] = l$code;
    return result$data;
  }

  CopyWith$Variables$Mutation$VerifyTwoFactor<
    Variables$Mutation$VerifyTwoFactor
  >
  get copyWith => CopyWith$Variables$Mutation$VerifyTwoFactor(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$VerifyTwoFactor ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$challengeToken = challengeToken;
    final lOther$challengeToken = other.challengeToken;
    if (l$challengeToken != lOther$challengeToken) {
      return false;
    }
    final l$code = code;
    final lOther$code = other.code;
    if (l$code != lOther$code) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$challengeToken = challengeToken;
    final l$code = code;
    return Object.hashAll([l$challengeToken, l$code]);
  }
}

abstract class CopyWith$Variables$Mutation$VerifyTwoFactor<TRes> {
  factory CopyWith$Variables$Mutation$VerifyTwoFactor(
    Variables$Mutation$VerifyTwoFactor instance,
    TRes Function(Variables$Mutation$VerifyTwoFactor) then,
  ) = _CopyWithImpl$Variables$Mutation$VerifyTwoFactor;

  factory CopyWith$Variables$Mutation$VerifyTwoFactor.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$VerifyTwoFactor;

  TRes call({String? challengeToken, String? code});
}

class _CopyWithImpl$Variables$Mutation$VerifyTwoFactor<TRes>
    implements CopyWith$Variables$Mutation$VerifyTwoFactor<TRes> {
  _CopyWithImpl$Variables$Mutation$VerifyTwoFactor(this._instance, this._then);

  final Variables$Mutation$VerifyTwoFactor _instance;

  final TRes Function(Variables$Mutation$VerifyTwoFactor) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? challengeToken = _undefined, Object? code = _undefined}) =>
      _then(
        Variables$Mutation$VerifyTwoFactor._({
          ..._instance._$data,
          if (challengeToken != _undefined && challengeToken != null)
            'challengeToken': (challengeToken as String),
          if (code != _undefined && code != null) 'code': (code as String),
        }),
      );
}

class _CopyWithStubImpl$Variables$Mutation$VerifyTwoFactor<TRes>
    implements CopyWith$Variables$Mutation$VerifyTwoFactor<TRes> {
  _CopyWithStubImpl$Variables$Mutation$VerifyTwoFactor(this._res);

  TRes _res;

  call({String? challengeToken, String? code}) => _res;
}

class Mutation$VerifyTwoFactor {
  Mutation$VerifyTwoFactor({
    required this.verifyTwoFactor,
    this.$__typename = 'Mutation',
  });

  factory Mutation$VerifyTwoFactor.fromJson(Map<String, dynamic> json) {
    final l$verifyTwoFactor = json['verifyTwoFactor'];
    final l$$__typename = json['__typename'];
    return Mutation$VerifyTwoFactor(
      verifyTwoFactor: Fragment$AuthFields.fromJson(
        (l$verifyTwoFactor as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$AuthFields verifyTwoFactor;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$verifyTwoFactor = verifyTwoFactor;
    _resultData['verifyTwoFactor'] = l$verifyTwoFactor.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$verifyTwoFactor = verifyTwoFactor;
    final l$$__typename = $__typename;
    return Object.hashAll([l$verifyTwoFactor, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$VerifyTwoFactor ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$verifyTwoFactor = verifyTwoFactor;
    final lOther$verifyTwoFactor = other.verifyTwoFactor;
    if (l$verifyTwoFactor != lOther$verifyTwoFactor) {
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

extension UtilityExtension$Mutation$VerifyTwoFactor
    on Mutation$VerifyTwoFactor {
  CopyWith$Mutation$VerifyTwoFactor<Mutation$VerifyTwoFactor> get copyWith =>
      CopyWith$Mutation$VerifyTwoFactor(this, (i) => i);
}

abstract class CopyWith$Mutation$VerifyTwoFactor<TRes> {
  factory CopyWith$Mutation$VerifyTwoFactor(
    Mutation$VerifyTwoFactor instance,
    TRes Function(Mutation$VerifyTwoFactor) then,
  ) = _CopyWithImpl$Mutation$VerifyTwoFactor;

  factory CopyWith$Mutation$VerifyTwoFactor.stub(TRes res) =
      _CopyWithStubImpl$Mutation$VerifyTwoFactor;

  TRes call({Fragment$AuthFields? verifyTwoFactor, String? $__typename});
  CopyWith$Fragment$AuthFields<TRes> get verifyTwoFactor;
}

class _CopyWithImpl$Mutation$VerifyTwoFactor<TRes>
    implements CopyWith$Mutation$VerifyTwoFactor<TRes> {
  _CopyWithImpl$Mutation$VerifyTwoFactor(this._instance, this._then);

  final Mutation$VerifyTwoFactor _instance;

  final TRes Function(Mutation$VerifyTwoFactor) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? verifyTwoFactor = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$VerifyTwoFactor(
      verifyTwoFactor: verifyTwoFactor == _undefined || verifyTwoFactor == null
          ? _instance.verifyTwoFactor
          : (verifyTwoFactor as Fragment$AuthFields),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  CopyWith$Fragment$AuthFields<TRes> get verifyTwoFactor {
    final local$verifyTwoFactor = _instance.verifyTwoFactor;
    return CopyWith$Fragment$AuthFields(
      local$verifyTwoFactor,
      (e) => call(verifyTwoFactor: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$VerifyTwoFactor<TRes>
    implements CopyWith$Mutation$VerifyTwoFactor<TRes> {
  _CopyWithStubImpl$Mutation$VerifyTwoFactor(this._res);

  TRes _res;

  call({Fragment$AuthFields? verifyTwoFactor, String? $__typename}) => _res;

  CopyWith$Fragment$AuthFields<TRes> get verifyTwoFactor =>
      CopyWith$Fragment$AuthFields.stub(_res);
}

const documentNodeMutationVerifyTwoFactor = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'VerifyTwoFactor'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'challengeToken')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'code')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'verifyTwoFactor'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'challengeToken'),
                value: VariableNode(name: NameNode(value: 'challengeToken')),
              ),
              ArgumentNode(
                name: NameNode(value: 'code'),
                value: VariableNode(name: NameNode(value: 'code')),
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

class Variables$Mutation$RequestMagicLink {
  factory Variables$Mutation$RequestMagicLink({required String email}) =>
      Variables$Mutation$RequestMagicLink._({r'email': email});

  Variables$Mutation$RequestMagicLink._(this._$data);

  factory Variables$Mutation$RequestMagicLink.fromJson(
    Map<String, dynamic> data,
  ) {
    final result$data = <String, dynamic>{};
    final l$email = data['email'];
    result$data['email'] = (l$email as String);
    return Variables$Mutation$RequestMagicLink._(result$data);
  }

  Map<String, dynamic> _$data;

  String get email => (_$data['email'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$email = email;
    result$data['email'] = l$email;
    return result$data;
  }

  CopyWith$Variables$Mutation$RequestMagicLink<
    Variables$Mutation$RequestMagicLink
  >
  get copyWith => CopyWith$Variables$Mutation$RequestMagicLink(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$RequestMagicLink ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$email = email;
    final lOther$email = other.email;
    if (l$email != lOther$email) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$email = email;
    return Object.hashAll([l$email]);
  }
}

abstract class CopyWith$Variables$Mutation$RequestMagicLink<TRes> {
  factory CopyWith$Variables$Mutation$RequestMagicLink(
    Variables$Mutation$RequestMagicLink instance,
    TRes Function(Variables$Mutation$RequestMagicLink) then,
  ) = _CopyWithImpl$Variables$Mutation$RequestMagicLink;

  factory CopyWith$Variables$Mutation$RequestMagicLink.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$RequestMagicLink;

  TRes call({String? email});
}

class _CopyWithImpl$Variables$Mutation$RequestMagicLink<TRes>
    implements CopyWith$Variables$Mutation$RequestMagicLink<TRes> {
  _CopyWithImpl$Variables$Mutation$RequestMagicLink(this._instance, this._then);

  final Variables$Mutation$RequestMagicLink _instance;

  final TRes Function(Variables$Mutation$RequestMagicLink) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? email = _undefined}) => _then(
    Variables$Mutation$RequestMagicLink._({
      ..._instance._$data,
      if (email != _undefined && email != null) 'email': (email as String),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$RequestMagicLink<TRes>
    implements CopyWith$Variables$Mutation$RequestMagicLink<TRes> {
  _CopyWithStubImpl$Variables$Mutation$RequestMagicLink(this._res);

  TRes _res;

  call({String? email}) => _res;
}

class Mutation$RequestMagicLink {
  Mutation$RequestMagicLink({
    required this.requestMagicLink,
    this.$__typename = 'Mutation',
  });

  factory Mutation$RequestMagicLink.fromJson(Map<String, dynamic> json) {
    final l$requestMagicLink = json['requestMagicLink'];
    final l$$__typename = json['__typename'];
    return Mutation$RequestMagicLink(
      requestMagicLink: (l$requestMagicLink as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final bool requestMagicLink;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$requestMagicLink = requestMagicLink;
    _resultData['requestMagicLink'] = l$requestMagicLink;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$requestMagicLink = requestMagicLink;
    final l$$__typename = $__typename;
    return Object.hashAll([l$requestMagicLink, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$RequestMagicLink ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$requestMagicLink = requestMagicLink;
    final lOther$requestMagicLink = other.requestMagicLink;
    if (l$requestMagicLink != lOther$requestMagicLink) {
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

extension UtilityExtension$Mutation$RequestMagicLink
    on Mutation$RequestMagicLink {
  CopyWith$Mutation$RequestMagicLink<Mutation$RequestMagicLink> get copyWith =>
      CopyWith$Mutation$RequestMagicLink(this, (i) => i);
}

abstract class CopyWith$Mutation$RequestMagicLink<TRes> {
  factory CopyWith$Mutation$RequestMagicLink(
    Mutation$RequestMagicLink instance,
    TRes Function(Mutation$RequestMagicLink) then,
  ) = _CopyWithImpl$Mutation$RequestMagicLink;

  factory CopyWith$Mutation$RequestMagicLink.stub(TRes res) =
      _CopyWithStubImpl$Mutation$RequestMagicLink;

  TRes call({bool? requestMagicLink, String? $__typename});
}

class _CopyWithImpl$Mutation$RequestMagicLink<TRes>
    implements CopyWith$Mutation$RequestMagicLink<TRes> {
  _CopyWithImpl$Mutation$RequestMagicLink(this._instance, this._then);

  final Mutation$RequestMagicLink _instance;

  final TRes Function(Mutation$RequestMagicLink) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? requestMagicLink = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$RequestMagicLink(
      requestMagicLink:
          requestMagicLink == _undefined || requestMagicLink == null
          ? _instance.requestMagicLink
          : (requestMagicLink as bool),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Mutation$RequestMagicLink<TRes>
    implements CopyWith$Mutation$RequestMagicLink<TRes> {
  _CopyWithStubImpl$Mutation$RequestMagicLink(this._res);

  TRes _res;

  call({bool? requestMagicLink, String? $__typename}) => _res;
}

const documentNodeMutationRequestMagicLink = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'RequestMagicLink'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'email')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'requestMagicLink'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'email'),
                value: VariableNode(name: NameNode(value: 'email')),
              ),
            ],
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
  ],
);

class Variables$Mutation$ConsumeMagicLink {
  factory Variables$Mutation$ConsumeMagicLink({required String token}) =>
      Variables$Mutation$ConsumeMagicLink._({r'token': token});

  Variables$Mutation$ConsumeMagicLink._(this._$data);

  factory Variables$Mutation$ConsumeMagicLink.fromJson(
    Map<String, dynamic> data,
  ) {
    final result$data = <String, dynamic>{};
    final l$token = data['token'];
    result$data['token'] = (l$token as String);
    return Variables$Mutation$ConsumeMagicLink._(result$data);
  }

  Map<String, dynamic> _$data;

  String get token => (_$data['token'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$token = token;
    result$data['token'] = l$token;
    return result$data;
  }

  CopyWith$Variables$Mutation$ConsumeMagicLink<
    Variables$Mutation$ConsumeMagicLink
  >
  get copyWith => CopyWith$Variables$Mutation$ConsumeMagicLink(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$ConsumeMagicLink ||
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

abstract class CopyWith$Variables$Mutation$ConsumeMagicLink<TRes> {
  factory CopyWith$Variables$Mutation$ConsumeMagicLink(
    Variables$Mutation$ConsumeMagicLink instance,
    TRes Function(Variables$Mutation$ConsumeMagicLink) then,
  ) = _CopyWithImpl$Variables$Mutation$ConsumeMagicLink;

  factory CopyWith$Variables$Mutation$ConsumeMagicLink.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$ConsumeMagicLink;

  TRes call({String? token});
}

class _CopyWithImpl$Variables$Mutation$ConsumeMagicLink<TRes>
    implements CopyWith$Variables$Mutation$ConsumeMagicLink<TRes> {
  _CopyWithImpl$Variables$Mutation$ConsumeMagicLink(this._instance, this._then);

  final Variables$Mutation$ConsumeMagicLink _instance;

  final TRes Function(Variables$Mutation$ConsumeMagicLink) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? token = _undefined}) => _then(
    Variables$Mutation$ConsumeMagicLink._({
      ..._instance._$data,
      if (token != _undefined && token != null) 'token': (token as String),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$ConsumeMagicLink<TRes>
    implements CopyWith$Variables$Mutation$ConsumeMagicLink<TRes> {
  _CopyWithStubImpl$Variables$Mutation$ConsumeMagicLink(this._res);

  TRes _res;

  call({String? token}) => _res;
}

class Mutation$ConsumeMagicLink {
  Mutation$ConsumeMagicLink({
    required this.consumeMagicLink,
    this.$__typename = 'Mutation',
  });

  factory Mutation$ConsumeMagicLink.fromJson(Map<String, dynamic> json) {
    final l$consumeMagicLink = json['consumeMagicLink'];
    final l$$__typename = json['__typename'];
    return Mutation$ConsumeMagicLink(
      consumeMagicLink: Fragment$AuthFields.fromJson(
        (l$consumeMagicLink as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$AuthFields consumeMagicLink;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$consumeMagicLink = consumeMagicLink;
    _resultData['consumeMagicLink'] = l$consumeMagicLink.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$consumeMagicLink = consumeMagicLink;
    final l$$__typename = $__typename;
    return Object.hashAll([l$consumeMagicLink, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$ConsumeMagicLink ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$consumeMagicLink = consumeMagicLink;
    final lOther$consumeMagicLink = other.consumeMagicLink;
    if (l$consumeMagicLink != lOther$consumeMagicLink) {
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

extension UtilityExtension$Mutation$ConsumeMagicLink
    on Mutation$ConsumeMagicLink {
  CopyWith$Mutation$ConsumeMagicLink<Mutation$ConsumeMagicLink> get copyWith =>
      CopyWith$Mutation$ConsumeMagicLink(this, (i) => i);
}

abstract class CopyWith$Mutation$ConsumeMagicLink<TRes> {
  factory CopyWith$Mutation$ConsumeMagicLink(
    Mutation$ConsumeMagicLink instance,
    TRes Function(Mutation$ConsumeMagicLink) then,
  ) = _CopyWithImpl$Mutation$ConsumeMagicLink;

  factory CopyWith$Mutation$ConsumeMagicLink.stub(TRes res) =
      _CopyWithStubImpl$Mutation$ConsumeMagicLink;

  TRes call({Fragment$AuthFields? consumeMagicLink, String? $__typename});
  CopyWith$Fragment$AuthFields<TRes> get consumeMagicLink;
}

class _CopyWithImpl$Mutation$ConsumeMagicLink<TRes>
    implements CopyWith$Mutation$ConsumeMagicLink<TRes> {
  _CopyWithImpl$Mutation$ConsumeMagicLink(this._instance, this._then);

  final Mutation$ConsumeMagicLink _instance;

  final TRes Function(Mutation$ConsumeMagicLink) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? consumeMagicLink = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$ConsumeMagicLink(
      consumeMagicLink:
          consumeMagicLink == _undefined || consumeMagicLink == null
          ? _instance.consumeMagicLink
          : (consumeMagicLink as Fragment$AuthFields),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  CopyWith$Fragment$AuthFields<TRes> get consumeMagicLink {
    final local$consumeMagicLink = _instance.consumeMagicLink;
    return CopyWith$Fragment$AuthFields(
      local$consumeMagicLink,
      (e) => call(consumeMagicLink: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$ConsumeMagicLink<TRes>
    implements CopyWith$Mutation$ConsumeMagicLink<TRes> {
  _CopyWithStubImpl$Mutation$ConsumeMagicLink(this._res);

  TRes _res;

  call({Fragment$AuthFields? consumeMagicLink, String? $__typename}) => _res;

  CopyWith$Fragment$AuthFields<TRes> get consumeMagicLink =>
      CopyWith$Fragment$AuthFields.stub(_res);
}

const documentNodeMutationConsumeMagicLink = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'ConsumeMagicLink'),
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
            name: NameNode(value: 'consumeMagicLink'),
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

class Variables$Mutation$RefreshSession {
  factory Variables$Mutation$RefreshSession({required String refreshToken}) =>
      Variables$Mutation$RefreshSession._({r'refreshToken': refreshToken});

  Variables$Mutation$RefreshSession._(this._$data);

  factory Variables$Mutation$RefreshSession.fromJson(
    Map<String, dynamic> data,
  ) {
    final result$data = <String, dynamic>{};
    final l$refreshToken = data['refreshToken'];
    result$data['refreshToken'] = (l$refreshToken as String);
    return Variables$Mutation$RefreshSession._(result$data);
  }

  Map<String, dynamic> _$data;

  String get refreshToken => (_$data['refreshToken'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$refreshToken = refreshToken;
    result$data['refreshToken'] = l$refreshToken;
    return result$data;
  }

  CopyWith$Variables$Mutation$RefreshSession<Variables$Mutation$RefreshSession>
  get copyWith => CopyWith$Variables$Mutation$RefreshSession(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$RefreshSession ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$refreshToken = refreshToken;
    final lOther$refreshToken = other.refreshToken;
    if (l$refreshToken != lOther$refreshToken) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$refreshToken = refreshToken;
    return Object.hashAll([l$refreshToken]);
  }
}

abstract class CopyWith$Variables$Mutation$RefreshSession<TRes> {
  factory CopyWith$Variables$Mutation$RefreshSession(
    Variables$Mutation$RefreshSession instance,
    TRes Function(Variables$Mutation$RefreshSession) then,
  ) = _CopyWithImpl$Variables$Mutation$RefreshSession;

  factory CopyWith$Variables$Mutation$RefreshSession.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$RefreshSession;

  TRes call({String? refreshToken});
}

class _CopyWithImpl$Variables$Mutation$RefreshSession<TRes>
    implements CopyWith$Variables$Mutation$RefreshSession<TRes> {
  _CopyWithImpl$Variables$Mutation$RefreshSession(this._instance, this._then);

  final Variables$Mutation$RefreshSession _instance;

  final TRes Function(Variables$Mutation$RefreshSession) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? refreshToken = _undefined}) => _then(
    Variables$Mutation$RefreshSession._({
      ..._instance._$data,
      if (refreshToken != _undefined && refreshToken != null)
        'refreshToken': (refreshToken as String),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$RefreshSession<TRes>
    implements CopyWith$Variables$Mutation$RefreshSession<TRes> {
  _CopyWithStubImpl$Variables$Mutation$RefreshSession(this._res);

  TRes _res;

  call({String? refreshToken}) => _res;
}

class Mutation$RefreshSession {
  Mutation$RefreshSession({
    required this.refreshSession,
    this.$__typename = 'Mutation',
  });

  factory Mutation$RefreshSession.fromJson(Map<String, dynamic> json) {
    final l$refreshSession = json['refreshSession'];
    final l$$__typename = json['__typename'];
    return Mutation$RefreshSession(
      refreshSession: Fragment$AuthFields.fromJson(
        (l$refreshSession as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$AuthFields refreshSession;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$refreshSession = refreshSession;
    _resultData['refreshSession'] = l$refreshSession.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$refreshSession = refreshSession;
    final l$$__typename = $__typename;
    return Object.hashAll([l$refreshSession, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$RefreshSession || runtimeType != other.runtimeType) {
      return false;
    }
    final l$refreshSession = refreshSession;
    final lOther$refreshSession = other.refreshSession;
    if (l$refreshSession != lOther$refreshSession) {
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

extension UtilityExtension$Mutation$RefreshSession on Mutation$RefreshSession {
  CopyWith$Mutation$RefreshSession<Mutation$RefreshSession> get copyWith =>
      CopyWith$Mutation$RefreshSession(this, (i) => i);
}

abstract class CopyWith$Mutation$RefreshSession<TRes> {
  factory CopyWith$Mutation$RefreshSession(
    Mutation$RefreshSession instance,
    TRes Function(Mutation$RefreshSession) then,
  ) = _CopyWithImpl$Mutation$RefreshSession;

  factory CopyWith$Mutation$RefreshSession.stub(TRes res) =
      _CopyWithStubImpl$Mutation$RefreshSession;

  TRes call({Fragment$AuthFields? refreshSession, String? $__typename});
  CopyWith$Fragment$AuthFields<TRes> get refreshSession;
}

class _CopyWithImpl$Mutation$RefreshSession<TRes>
    implements CopyWith$Mutation$RefreshSession<TRes> {
  _CopyWithImpl$Mutation$RefreshSession(this._instance, this._then);

  final Mutation$RefreshSession _instance;

  final TRes Function(Mutation$RefreshSession) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? refreshSession = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$RefreshSession(
      refreshSession: refreshSession == _undefined || refreshSession == null
          ? _instance.refreshSession
          : (refreshSession as Fragment$AuthFields),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  CopyWith$Fragment$AuthFields<TRes> get refreshSession {
    final local$refreshSession = _instance.refreshSession;
    return CopyWith$Fragment$AuthFields(
      local$refreshSession,
      (e) => call(refreshSession: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$RefreshSession<TRes>
    implements CopyWith$Mutation$RefreshSession<TRes> {
  _CopyWithStubImpl$Mutation$RefreshSession(this._res);

  TRes _res;

  call({Fragment$AuthFields? refreshSession, String? $__typename}) => _res;

  CopyWith$Fragment$AuthFields<TRes> get refreshSession =>
      CopyWith$Fragment$AuthFields.stub(_res);
}

const documentNodeMutationRefreshSession = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'RefreshSession'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'refreshToken')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'refreshSession'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'refreshToken'),
                value: VariableNode(name: NameNode(value: 'refreshToken')),
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

class Variables$Mutation$Logout {
  factory Variables$Mutation$Logout({String? refreshToken}) =>
      Variables$Mutation$Logout._({
        if (refreshToken != null) r'refreshToken': refreshToken,
      });

  Variables$Mutation$Logout._(this._$data);

  factory Variables$Mutation$Logout.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('refreshToken')) {
      final l$refreshToken = data['refreshToken'];
      result$data['refreshToken'] = (l$refreshToken as String?);
    }
    return Variables$Mutation$Logout._(result$data);
  }

  Map<String, dynamic> _$data;

  String? get refreshToken => (_$data['refreshToken'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('refreshToken')) {
      final l$refreshToken = refreshToken;
      result$data['refreshToken'] = l$refreshToken;
    }
    return result$data;
  }

  CopyWith$Variables$Mutation$Logout<Variables$Mutation$Logout> get copyWith =>
      CopyWith$Variables$Mutation$Logout(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$Logout ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$refreshToken = refreshToken;
    final lOther$refreshToken = other.refreshToken;
    if (_$data.containsKey('refreshToken') !=
        other._$data.containsKey('refreshToken')) {
      return false;
    }
    if (l$refreshToken != lOther$refreshToken) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$refreshToken = refreshToken;
    return Object.hashAll([
      _$data.containsKey('refreshToken') ? l$refreshToken : const {},
    ]);
  }
}

abstract class CopyWith$Variables$Mutation$Logout<TRes> {
  factory CopyWith$Variables$Mutation$Logout(
    Variables$Mutation$Logout instance,
    TRes Function(Variables$Mutation$Logout) then,
  ) = _CopyWithImpl$Variables$Mutation$Logout;

  factory CopyWith$Variables$Mutation$Logout.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$Logout;

  TRes call({String? refreshToken});
}

class _CopyWithImpl$Variables$Mutation$Logout<TRes>
    implements CopyWith$Variables$Mutation$Logout<TRes> {
  _CopyWithImpl$Variables$Mutation$Logout(this._instance, this._then);

  final Variables$Mutation$Logout _instance;

  final TRes Function(Variables$Mutation$Logout) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? refreshToken = _undefined}) => _then(
    Variables$Mutation$Logout._({
      ..._instance._$data,
      if (refreshToken != _undefined) 'refreshToken': (refreshToken as String?),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$Logout<TRes>
    implements CopyWith$Variables$Mutation$Logout<TRes> {
  _CopyWithStubImpl$Variables$Mutation$Logout(this._res);

  TRes _res;

  call({String? refreshToken}) => _res;
}

class Mutation$Logout {
  Mutation$Logout({required this.logout, this.$__typename = 'Mutation'});

  factory Mutation$Logout.fromJson(Map<String, dynamic> json) {
    final l$logout = json['logout'];
    final l$$__typename = json['__typename'];
    return Mutation$Logout(
      logout: (l$logout as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final bool logout;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$logout = logout;
    _resultData['logout'] = l$logout;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$logout = logout;
    final l$$__typename = $__typename;
    return Object.hashAll([l$logout, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$Logout || runtimeType != other.runtimeType) {
      return false;
    }
    final l$logout = logout;
    final lOther$logout = other.logout;
    if (l$logout != lOther$logout) {
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

extension UtilityExtension$Mutation$Logout on Mutation$Logout {
  CopyWith$Mutation$Logout<Mutation$Logout> get copyWith =>
      CopyWith$Mutation$Logout(this, (i) => i);
}

abstract class CopyWith$Mutation$Logout<TRes> {
  factory CopyWith$Mutation$Logout(
    Mutation$Logout instance,
    TRes Function(Mutation$Logout) then,
  ) = _CopyWithImpl$Mutation$Logout;

  factory CopyWith$Mutation$Logout.stub(TRes res) =
      _CopyWithStubImpl$Mutation$Logout;

  TRes call({bool? logout, String? $__typename});
}

class _CopyWithImpl$Mutation$Logout<TRes>
    implements CopyWith$Mutation$Logout<TRes> {
  _CopyWithImpl$Mutation$Logout(this._instance, this._then);

  final Mutation$Logout _instance;

  final TRes Function(Mutation$Logout) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? logout = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Mutation$Logout(
          logout: logout == _undefined || logout == null
              ? _instance.logout
              : (logout as bool),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
        ),
      );
}

class _CopyWithStubImpl$Mutation$Logout<TRes>
    implements CopyWith$Mutation$Logout<TRes> {
  _CopyWithStubImpl$Mutation$Logout(this._res);

  TRes _res;

  call({bool? logout, String? $__typename}) => _res;
}

const documentNodeMutationLogout = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'Logout'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'refreshToken')),
          type: NamedTypeNode(
            name: NameNode(value: 'String'),
            isNonNull: false,
          ),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'logout'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'refreshToken'),
                value: VariableNode(name: NameNode(value: 'refreshToken')),
              ),
            ],
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
  ],
);

class Query$Me {
  Query$Me({required this.me, this.$__typename = 'Query'});

  factory Query$Me.fromJson(Map<String, dynamic> json) {
    final l$me = json['me'];
    final l$$__typename = json['__typename'];
    return Query$Me(
      me: Fragment$MeFields.fromJson((l$me as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$MeFields me;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$me = me;
    _resultData['me'] = l$me.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$me = me;
    final l$$__typename = $__typename;
    return Object.hashAll([l$me, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$Me || runtimeType != other.runtimeType) {
      return false;
    }
    final l$me = me;
    final lOther$me = other.me;
    if (l$me != lOther$me) {
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

extension UtilityExtension$Query$Me on Query$Me {
  CopyWith$Query$Me<Query$Me> get copyWith => CopyWith$Query$Me(this, (i) => i);
}

abstract class CopyWith$Query$Me<TRes> {
  factory CopyWith$Query$Me(Query$Me instance, TRes Function(Query$Me) then) =
      _CopyWithImpl$Query$Me;

  factory CopyWith$Query$Me.stub(TRes res) = _CopyWithStubImpl$Query$Me;

  TRes call({Fragment$MeFields? me, String? $__typename});
  CopyWith$Fragment$MeFields<TRes> get me;
}

class _CopyWithImpl$Query$Me<TRes> implements CopyWith$Query$Me<TRes> {
  _CopyWithImpl$Query$Me(this._instance, this._then);

  final Query$Me _instance;

  final TRes Function(Query$Me) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? me = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Query$Me(
          me: me == _undefined || me == null
              ? _instance.me
              : (me as Fragment$MeFields),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
        ),
      );

  CopyWith$Fragment$MeFields<TRes> get me {
    final local$me = _instance.me;
    return CopyWith$Fragment$MeFields(local$me, (e) => call(me: e));
  }
}

class _CopyWithStubImpl$Query$Me<TRes> implements CopyWith$Query$Me<TRes> {
  _CopyWithStubImpl$Query$Me(this._res);

  TRes _res;

  call({Fragment$MeFields? me, String? $__typename}) => _res;

  CopyWith$Fragment$MeFields<TRes> get me =>
      CopyWith$Fragment$MeFields.stub(_res);
}

const documentNodeQueryMe = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'Me'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'me'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FragmentSpreadNode(
                  name: NameNode(value: 'MeFields'),
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
    fragmentDefinitionMeFields,
  ],
);
