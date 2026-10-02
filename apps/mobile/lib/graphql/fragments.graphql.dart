import 'package:gql/ast.dart';

import 'schema.graphql.dart';

class Fragment$MeFields {
  Fragment$MeFields({
    required this.id,
    required this.email,
    required this.fullName,
    required this.locale,
    required this.twoFactorEnabled,
    required this.memberships,
    this.$__typename = 'Me',
  });

  factory Fragment$MeFields.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$email = json['email'];
    final l$fullName = json['fullName'];
    final l$locale = json['locale'];
    final l$twoFactorEnabled = json['twoFactorEnabled'];
    final l$memberships = json['memberships'];
    final l$$__typename = json['__typename'];
    return Fragment$MeFields(
      id: (l$id as String),
      email: (l$email as String),
      fullName: (l$fullName as String),
      locale: (l$locale as String),
      twoFactorEnabled: (l$twoFactorEnabled as bool),
      memberships: (l$memberships as List<dynamic>)
          .map(
            (e) => Fragment$MeFields$memberships.fromJson(
              (e as Map<String, dynamic>),
            ),
          )
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String email;

  final String fullName;

  final String locale;

  final bool twoFactorEnabled;

  final List<Fragment$MeFields$memberships> memberships;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$email = email;
    _resultData['email'] = l$email;
    final l$fullName = fullName;
    _resultData['fullName'] = l$fullName;
    final l$locale = locale;
    _resultData['locale'] = l$locale;
    final l$twoFactorEnabled = twoFactorEnabled;
    _resultData['twoFactorEnabled'] = l$twoFactorEnabled;
    final l$memberships = memberships;
    _resultData['memberships'] = l$memberships.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$email = email;
    final l$fullName = fullName;
    final l$locale = locale;
    final l$twoFactorEnabled = twoFactorEnabled;
    final l$memberships = memberships;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$email,
      l$fullName,
      l$locale,
      l$twoFactorEnabled,
      Object.hashAll(l$memberships.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$MeFields || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$email = email;
    final lOther$email = other.email;
    if (l$email != lOther$email) {
      return false;
    }
    final l$fullName = fullName;
    final lOther$fullName = other.fullName;
    if (l$fullName != lOther$fullName) {
      return false;
    }
    final l$locale = locale;
    final lOther$locale = other.locale;
    if (l$locale != lOther$locale) {
      return false;
    }
    final l$twoFactorEnabled = twoFactorEnabled;
    final lOther$twoFactorEnabled = other.twoFactorEnabled;
    if (l$twoFactorEnabled != lOther$twoFactorEnabled) {
      return false;
    }
    final l$memberships = memberships;
    final lOther$memberships = other.memberships;
    if (l$memberships.length != lOther$memberships.length) {
      return false;
    }
    for (int i = 0; i < l$memberships.length; i++) {
      final l$memberships$entry = l$memberships[i];
      final lOther$memberships$entry = lOther$memberships[i];
      if (l$memberships$entry != lOther$memberships$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Fragment$MeFields on Fragment$MeFields {
  CopyWith$Fragment$MeFields<Fragment$MeFields> get copyWith =>
      CopyWith$Fragment$MeFields(this, (i) => i);
}

abstract class CopyWith$Fragment$MeFields<TRes> {
  factory CopyWith$Fragment$MeFields(
    Fragment$MeFields instance,
    TRes Function(Fragment$MeFields) then,
  ) = _CopyWithImpl$Fragment$MeFields;

  factory CopyWith$Fragment$MeFields.stub(TRes res) =
      _CopyWithStubImpl$Fragment$MeFields;

  TRes call({
    String? id,
    String? email,
    String? fullName,
    String? locale,
    bool? twoFactorEnabled,
    List<Fragment$MeFields$memberships>? memberships,
    String? $__typename,
  });
  TRes memberships(
    Iterable<Fragment$MeFields$memberships> Function(
      Iterable<
        CopyWith$Fragment$MeFields$memberships<Fragment$MeFields$memberships>
      >,
    )
    _fn,
  );
}

class _CopyWithImpl$Fragment$MeFields<TRes>
    implements CopyWith$Fragment$MeFields<TRes> {
  _CopyWithImpl$Fragment$MeFields(this._instance, this._then);

  final Fragment$MeFields _instance;

  final TRes Function(Fragment$MeFields) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? email = _undefined,
    Object? fullName = _undefined,
    Object? locale = _undefined,
    Object? twoFactorEnabled = _undefined,
    Object? memberships = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$MeFields(
      id: id == _undefined || id == null ? _instance.id : (id as String),
      email: email == _undefined || email == null
          ? _instance.email
          : (email as String),
      fullName: fullName == _undefined || fullName == null
          ? _instance.fullName
          : (fullName as String),
      locale: locale == _undefined || locale == null
          ? _instance.locale
          : (locale as String),
      twoFactorEnabled:
          twoFactorEnabled == _undefined || twoFactorEnabled == null
          ? _instance.twoFactorEnabled
          : (twoFactorEnabled as bool),
      memberships: memberships == _undefined || memberships == null
          ? _instance.memberships
          : (memberships as List<Fragment$MeFields$memberships>),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  TRes memberships(
    Iterable<Fragment$MeFields$memberships> Function(
      Iterable<
        CopyWith$Fragment$MeFields$memberships<Fragment$MeFields$memberships>
      >,
    )
    _fn,
  ) => call(
    memberships: _fn(
      _instance.memberships.map(
        (e) => CopyWith$Fragment$MeFields$memberships(e, (i) => i),
      ),
    ).toList(),
  );
}

class _CopyWithStubImpl$Fragment$MeFields<TRes>
    implements CopyWith$Fragment$MeFields<TRes> {
  _CopyWithStubImpl$Fragment$MeFields(this._res);

  TRes _res;

  call({
    String? id,
    String? email,
    String? fullName,
    String? locale,
    bool? twoFactorEnabled,
    List<Fragment$MeFields$memberships>? memberships,
    String? $__typename,
  }) => _res;

  memberships(_fn) => _res;
}

const fragmentDefinitionMeFields = FragmentDefinitionNode(
  name: NameNode(value: 'MeFields'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'Me'), isNonNull: false),
  ),
  directives: [],
  selectionSet: SelectionSetNode(
    selections: [
      FieldNode(
        name: NameNode(value: 'id'),
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
        name: NameNode(value: 'fullName'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'locale'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'twoFactorEnabled'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'memberships'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(
          selections: [
            FieldNode(
              name: NameNode(value: 'id'),
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
              name: NameNode(value: 'teamId'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
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
);
const documentNodeFragmentMeFields = DocumentNode(
  definitions: [fragmentDefinitionMeFields],
);

class Fragment$MeFields$memberships {
  Fragment$MeFields$memberships({
    required this.id,
    required this.role,
    this.teamId,
    required this.clubId,
    required this.clubName,
    this.$__typename = 'MembershipSummary',
  });

  factory Fragment$MeFields$memberships.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$role = json['role'];
    final l$teamId = json['teamId'];
    final l$clubId = json['clubId'];
    final l$clubName = json['clubName'];
    final l$$__typename = json['__typename'];
    return Fragment$MeFields$memberships(
      id: (l$id as String),
      role: fromJson$Enum$MembershipRole((l$role as String)),
      teamId: (l$teamId as String?),
      clubId: (l$clubId as String),
      clubName: (l$clubName as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final Enum$MembershipRole role;

  final String? teamId;

  final String clubId;

  final String clubName;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$role = role;
    _resultData['role'] = toJson$Enum$MembershipRole(l$role);
    final l$teamId = teamId;
    _resultData['teamId'] = l$teamId;
    final l$clubId = clubId;
    _resultData['clubId'] = l$clubId;
    final l$clubName = clubName;
    _resultData['clubName'] = l$clubName;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$role = role;
    final l$teamId = teamId;
    final l$clubId = clubId;
    final l$clubName = clubName;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$role,
      l$teamId,
      l$clubId,
      l$clubName,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$MeFields$memberships ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$role = role;
    final lOther$role = other.role;
    if (l$role != lOther$role) {
      return false;
    }
    final l$teamId = teamId;
    final lOther$teamId = other.teamId;
    if (l$teamId != lOther$teamId) {
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
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Fragment$MeFields$memberships
    on Fragment$MeFields$memberships {
  CopyWith$Fragment$MeFields$memberships<Fragment$MeFields$memberships>
  get copyWith => CopyWith$Fragment$MeFields$memberships(this, (i) => i);
}

abstract class CopyWith$Fragment$MeFields$memberships<TRes> {
  factory CopyWith$Fragment$MeFields$memberships(
    Fragment$MeFields$memberships instance,
    TRes Function(Fragment$MeFields$memberships) then,
  ) = _CopyWithImpl$Fragment$MeFields$memberships;

  factory CopyWith$Fragment$MeFields$memberships.stub(TRes res) =
      _CopyWithStubImpl$Fragment$MeFields$memberships;

  TRes call({
    String? id,
    Enum$MembershipRole? role,
    String? teamId,
    String? clubId,
    String? clubName,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$MeFields$memberships<TRes>
    implements CopyWith$Fragment$MeFields$memberships<TRes> {
  _CopyWithImpl$Fragment$MeFields$memberships(this._instance, this._then);

  final Fragment$MeFields$memberships _instance;

  final TRes Function(Fragment$MeFields$memberships) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? role = _undefined,
    Object? teamId = _undefined,
    Object? clubId = _undefined,
    Object? clubName = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$MeFields$memberships(
      id: id == _undefined || id == null ? _instance.id : (id as String),
      role: role == _undefined || role == null
          ? _instance.role
          : (role as Enum$MembershipRole),
      teamId: teamId == _undefined ? _instance.teamId : (teamId as String?),
      clubId: clubId == _undefined || clubId == null
          ? _instance.clubId
          : (clubId as String),
      clubName: clubName == _undefined || clubName == null
          ? _instance.clubName
          : (clubName as String),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Fragment$MeFields$memberships<TRes>
    implements CopyWith$Fragment$MeFields$memberships<TRes> {
  _CopyWithStubImpl$Fragment$MeFields$memberships(this._res);

  TRes _res;

  call({
    String? id,
    Enum$MembershipRole? role,
    String? teamId,
    String? clubId,
    String? clubName,
    String? $__typename,
  }) => _res;
}

class Fragment$AuthFields {
  Fragment$AuthFields({
    required this.status,
    this.accessToken,
    this.accessTokenExpiresAt,
    this.refreshToken,
    this.challengeToken,
    this.user,
    this.$__typename = 'AuthPayload',
  });

  factory Fragment$AuthFields.fromJson(Map<String, dynamic> json) {
    final l$status = json['status'];
    final l$accessToken = json['accessToken'];
    final l$accessTokenExpiresAt = json['accessTokenExpiresAt'];
    final l$refreshToken = json['refreshToken'];
    final l$challengeToken = json['challengeToken'];
    final l$user = json['user'];
    final l$$__typename = json['__typename'];
    return Fragment$AuthFields(
      status: fromJson$Enum$AuthStatus((l$status as String)),
      accessToken: (l$accessToken as String?),
      accessTokenExpiresAt: (l$accessTokenExpiresAt as String?),
      refreshToken: (l$refreshToken as String?),
      challengeToken: (l$challengeToken as String?),
      user: l$user == null
          ? null
          : Fragment$MeFields.fromJson((l$user as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Enum$AuthStatus status;

  final String? accessToken;

  final String? accessTokenExpiresAt;

  final String? refreshToken;

  final String? challengeToken;

  final Fragment$MeFields? user;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$status = status;
    _resultData['status'] = toJson$Enum$AuthStatus(l$status);
    final l$accessToken = accessToken;
    _resultData['accessToken'] = l$accessToken;
    final l$accessTokenExpiresAt = accessTokenExpiresAt;
    _resultData['accessTokenExpiresAt'] = l$accessTokenExpiresAt;
    final l$refreshToken = refreshToken;
    _resultData['refreshToken'] = l$refreshToken;
    final l$challengeToken = challengeToken;
    _resultData['challengeToken'] = l$challengeToken;
    final l$user = user;
    _resultData['user'] = l$user?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$status = status;
    final l$accessToken = accessToken;
    final l$accessTokenExpiresAt = accessTokenExpiresAt;
    final l$refreshToken = refreshToken;
    final l$challengeToken = challengeToken;
    final l$user = user;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$status,
      l$accessToken,
      l$accessTokenExpiresAt,
      l$refreshToken,
      l$challengeToken,
      l$user,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$AuthFields || runtimeType != other.runtimeType) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) {
      return false;
    }
    final l$accessToken = accessToken;
    final lOther$accessToken = other.accessToken;
    if (l$accessToken != lOther$accessToken) {
      return false;
    }
    final l$accessTokenExpiresAt = accessTokenExpiresAt;
    final lOther$accessTokenExpiresAt = other.accessTokenExpiresAt;
    if (l$accessTokenExpiresAt != lOther$accessTokenExpiresAt) {
      return false;
    }
    final l$refreshToken = refreshToken;
    final lOther$refreshToken = other.refreshToken;
    if (l$refreshToken != lOther$refreshToken) {
      return false;
    }
    final l$challengeToken = challengeToken;
    final lOther$challengeToken = other.challengeToken;
    if (l$challengeToken != lOther$challengeToken) {
      return false;
    }
    final l$user = user;
    final lOther$user = other.user;
    if (l$user != lOther$user) {
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

extension UtilityExtension$Fragment$AuthFields on Fragment$AuthFields {
  CopyWith$Fragment$AuthFields<Fragment$AuthFields> get copyWith =>
      CopyWith$Fragment$AuthFields(this, (i) => i);
}

abstract class CopyWith$Fragment$AuthFields<TRes> {
  factory CopyWith$Fragment$AuthFields(
    Fragment$AuthFields instance,
    TRes Function(Fragment$AuthFields) then,
  ) = _CopyWithImpl$Fragment$AuthFields;

  factory CopyWith$Fragment$AuthFields.stub(TRes res) =
      _CopyWithStubImpl$Fragment$AuthFields;

  TRes call({
    Enum$AuthStatus? status,
    String? accessToken,
    String? accessTokenExpiresAt,
    String? refreshToken,
    String? challengeToken,
    Fragment$MeFields? user,
    String? $__typename,
  });
  CopyWith$Fragment$MeFields<TRes> get user;
}

class _CopyWithImpl$Fragment$AuthFields<TRes>
    implements CopyWith$Fragment$AuthFields<TRes> {
  _CopyWithImpl$Fragment$AuthFields(this._instance, this._then);

  final Fragment$AuthFields _instance;

  final TRes Function(Fragment$AuthFields) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? status = _undefined,
    Object? accessToken = _undefined,
    Object? accessTokenExpiresAt = _undefined,
    Object? refreshToken = _undefined,
    Object? challengeToken = _undefined,
    Object? user = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$AuthFields(
      status: status == _undefined || status == null
          ? _instance.status
          : (status as Enum$AuthStatus),
      accessToken: accessToken == _undefined
          ? _instance.accessToken
          : (accessToken as String?),
      accessTokenExpiresAt: accessTokenExpiresAt == _undefined
          ? _instance.accessTokenExpiresAt
          : (accessTokenExpiresAt as String?),
      refreshToken: refreshToken == _undefined
          ? _instance.refreshToken
          : (refreshToken as String?),
      challengeToken: challengeToken == _undefined
          ? _instance.challengeToken
          : (challengeToken as String?),
      user: user == _undefined ? _instance.user : (user as Fragment$MeFields?),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  CopyWith$Fragment$MeFields<TRes> get user {
    final local$user = _instance.user;
    return local$user == null
        ? CopyWith$Fragment$MeFields.stub(_then(_instance))
        : CopyWith$Fragment$MeFields(local$user, (e) => call(user: e));
  }
}

class _CopyWithStubImpl$Fragment$AuthFields<TRes>
    implements CopyWith$Fragment$AuthFields<TRes> {
  _CopyWithStubImpl$Fragment$AuthFields(this._res);

  TRes _res;

  call({
    Enum$AuthStatus? status,
    String? accessToken,
    String? accessTokenExpiresAt,
    String? refreshToken,
    String? challengeToken,
    Fragment$MeFields? user,
    String? $__typename,
  }) => _res;

  CopyWith$Fragment$MeFields<TRes> get user =>
      CopyWith$Fragment$MeFields.stub(_res);
}

const fragmentDefinitionAuthFields = FragmentDefinitionNode(
  name: NameNode(value: 'AuthFields'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'AuthPayload'), isNonNull: false),
  ),
  directives: [],
  selectionSet: SelectionSetNode(
    selections: [
      FieldNode(
        name: NameNode(value: 'status'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'accessToken'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'accessTokenExpiresAt'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'refreshToken'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'challengeToken'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'user'),
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
);
const documentNodeFragmentAuthFields = DocumentNode(
  definitions: [fragmentDefinitionAuthFields, fragmentDefinitionMeFields],
);
