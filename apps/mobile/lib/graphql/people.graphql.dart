import 'package:gql/ast.dart';

import 'schema.graphql.dart';

class Fragment$MyPersonFields {
  Fragment$MyPersonFields({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.birthDate,
    this.age,
    required this.isMinor,
    required this.hasAccount,
    this.email,
    this.phone,
    this.addressLine,
    this.city,
    this.province,
    this.postalCode,
    required this.teams,
    required this.guardians,
    this.$__typename = 'Person',
  });

  factory Fragment$MyPersonFields.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$firstName = json['firstName'];
    final l$lastName = json['lastName'];
    final l$birthDate = json['birthDate'];
    final l$age = json['age'];
    final l$isMinor = json['isMinor'];
    final l$hasAccount = json['hasAccount'];
    final l$email = json['email'];
    final l$phone = json['phone'];
    final l$addressLine = json['addressLine'];
    final l$city = json['city'];
    final l$province = json['province'];
    final l$postalCode = json['postalCode'];
    final l$teams = json['teams'];
    final l$guardians = json['guardians'];
    final l$$__typename = json['__typename'];
    return Fragment$MyPersonFields(
      id: (l$id as String),
      firstName: (l$firstName as String),
      lastName: (l$lastName as String),
      birthDate: (l$birthDate as String?),
      age: (l$age as int?),
      isMinor: (l$isMinor as bool),
      hasAccount: (l$hasAccount as bool),
      email: (l$email as String?),
      phone: (l$phone as String?),
      addressLine: (l$addressLine as String?),
      city: (l$city as String?),
      province: (l$province as String?),
      postalCode: (l$postalCode as String?),
      teams: (l$teams as List<dynamic>)
          .map(
            (e) => Fragment$MyPersonFields$teams.fromJson(
              (e as Map<String, dynamic>),
            ),
          )
          .toList(),
      guardians: (l$guardians as List<dynamic>)
          .map(
            (e) => Fragment$MyPersonFields$guardians.fromJson(
              (e as Map<String, dynamic>),
            ),
          )
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String firstName;

  final String lastName;

  final String? birthDate;

  final int? age;

  final bool isMinor;

  final bool hasAccount;

  final String? email;

  final String? phone;

  final String? addressLine;

  final String? city;

  final String? province;

  final String? postalCode;

  final List<Fragment$MyPersonFields$teams> teams;

  final List<Fragment$MyPersonFields$guardians> guardians;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$firstName = firstName;
    _resultData['firstName'] = l$firstName;
    final l$lastName = lastName;
    _resultData['lastName'] = l$lastName;
    final l$birthDate = birthDate;
    _resultData['birthDate'] = l$birthDate;
    final l$age = age;
    _resultData['age'] = l$age;
    final l$isMinor = isMinor;
    _resultData['isMinor'] = l$isMinor;
    final l$hasAccount = hasAccount;
    _resultData['hasAccount'] = l$hasAccount;
    final l$email = email;
    _resultData['email'] = l$email;
    final l$phone = phone;
    _resultData['phone'] = l$phone;
    final l$addressLine = addressLine;
    _resultData['addressLine'] = l$addressLine;
    final l$city = city;
    _resultData['city'] = l$city;
    final l$province = province;
    _resultData['province'] = l$province;
    final l$postalCode = postalCode;
    _resultData['postalCode'] = l$postalCode;
    final l$teams = teams;
    _resultData['teams'] = l$teams.map((e) => e.toJson()).toList();
    final l$guardians = guardians;
    _resultData['guardians'] = l$guardians.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$firstName = firstName;
    final l$lastName = lastName;
    final l$birthDate = birthDate;
    final l$age = age;
    final l$isMinor = isMinor;
    final l$hasAccount = hasAccount;
    final l$email = email;
    final l$phone = phone;
    final l$addressLine = addressLine;
    final l$city = city;
    final l$province = province;
    final l$postalCode = postalCode;
    final l$teams = teams;
    final l$guardians = guardians;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$firstName,
      l$lastName,
      l$birthDate,
      l$age,
      l$isMinor,
      l$hasAccount,
      l$email,
      l$phone,
      l$addressLine,
      l$city,
      l$province,
      l$postalCode,
      Object.hashAll(l$teams.map((v) => v)),
      Object.hashAll(l$guardians.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$MyPersonFields || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$firstName = firstName;
    final lOther$firstName = other.firstName;
    if (l$firstName != lOther$firstName) {
      return false;
    }
    final l$lastName = lastName;
    final lOther$lastName = other.lastName;
    if (l$lastName != lOther$lastName) {
      return false;
    }
    final l$birthDate = birthDate;
    final lOther$birthDate = other.birthDate;
    if (l$birthDate != lOther$birthDate) {
      return false;
    }
    final l$age = age;
    final lOther$age = other.age;
    if (l$age != lOther$age) {
      return false;
    }
    final l$isMinor = isMinor;
    final lOther$isMinor = other.isMinor;
    if (l$isMinor != lOther$isMinor) {
      return false;
    }
    final l$hasAccount = hasAccount;
    final lOther$hasAccount = other.hasAccount;
    if (l$hasAccount != lOther$hasAccount) {
      return false;
    }
    final l$email = email;
    final lOther$email = other.email;
    if (l$email != lOther$email) {
      return false;
    }
    final l$phone = phone;
    final lOther$phone = other.phone;
    if (l$phone != lOther$phone) {
      return false;
    }
    final l$addressLine = addressLine;
    final lOther$addressLine = other.addressLine;
    if (l$addressLine != lOther$addressLine) {
      return false;
    }
    final l$city = city;
    final lOther$city = other.city;
    if (l$city != lOther$city) {
      return false;
    }
    final l$province = province;
    final lOther$province = other.province;
    if (l$province != lOther$province) {
      return false;
    }
    final l$postalCode = postalCode;
    final lOther$postalCode = other.postalCode;
    if (l$postalCode != lOther$postalCode) {
      return false;
    }
    final l$teams = teams;
    final lOther$teams = other.teams;
    if (l$teams.length != lOther$teams.length) {
      return false;
    }
    for (int i = 0; i < l$teams.length; i++) {
      final l$teams$entry = l$teams[i];
      final lOther$teams$entry = lOther$teams[i];
      if (l$teams$entry != lOther$teams$entry) {
        return false;
      }
    }
    final l$guardians = guardians;
    final lOther$guardians = other.guardians;
    if (l$guardians.length != lOther$guardians.length) {
      return false;
    }
    for (int i = 0; i < l$guardians.length; i++) {
      final l$guardians$entry = l$guardians[i];
      final lOther$guardians$entry = lOther$guardians[i];
      if (l$guardians$entry != lOther$guardians$entry) {
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

extension UtilityExtension$Fragment$MyPersonFields on Fragment$MyPersonFields {
  CopyWith$Fragment$MyPersonFields<Fragment$MyPersonFields> get copyWith =>
      CopyWith$Fragment$MyPersonFields(this, (i) => i);
}

abstract class CopyWith$Fragment$MyPersonFields<TRes> {
  factory CopyWith$Fragment$MyPersonFields(
    Fragment$MyPersonFields instance,
    TRes Function(Fragment$MyPersonFields) then,
  ) = _CopyWithImpl$Fragment$MyPersonFields;

  factory CopyWith$Fragment$MyPersonFields.stub(TRes res) =
      _CopyWithStubImpl$Fragment$MyPersonFields;

  TRes call({
    String? id,
    String? firstName,
    String? lastName,
    String? birthDate,
    int? age,
    bool? isMinor,
    bool? hasAccount,
    String? email,
    String? phone,
    String? addressLine,
    String? city,
    String? province,
    String? postalCode,
    List<Fragment$MyPersonFields$teams>? teams,
    List<Fragment$MyPersonFields$guardians>? guardians,
    String? $__typename,
  });
  TRes teams(
    Iterable<Fragment$MyPersonFields$teams> Function(
      Iterable<
        CopyWith$Fragment$MyPersonFields$teams<Fragment$MyPersonFields$teams>
      >,
    )
    _fn,
  );
  TRes guardians(
    Iterable<Fragment$MyPersonFields$guardians> Function(
      Iterable<
        CopyWith$Fragment$MyPersonFields$guardians<
          Fragment$MyPersonFields$guardians
        >
      >,
    )
    _fn,
  );
}

class _CopyWithImpl$Fragment$MyPersonFields<TRes>
    implements CopyWith$Fragment$MyPersonFields<TRes> {
  _CopyWithImpl$Fragment$MyPersonFields(this._instance, this._then);

  final Fragment$MyPersonFields _instance;

  final TRes Function(Fragment$MyPersonFields) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? firstName = _undefined,
    Object? lastName = _undefined,
    Object? birthDate = _undefined,
    Object? age = _undefined,
    Object? isMinor = _undefined,
    Object? hasAccount = _undefined,
    Object? email = _undefined,
    Object? phone = _undefined,
    Object? addressLine = _undefined,
    Object? city = _undefined,
    Object? province = _undefined,
    Object? postalCode = _undefined,
    Object? teams = _undefined,
    Object? guardians = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$MyPersonFields(
      id: id == _undefined || id == null ? _instance.id : (id as String),
      firstName: firstName == _undefined || firstName == null
          ? _instance.firstName
          : (firstName as String),
      lastName: lastName == _undefined || lastName == null
          ? _instance.lastName
          : (lastName as String),
      birthDate: birthDate == _undefined
          ? _instance.birthDate
          : (birthDate as String?),
      age: age == _undefined ? _instance.age : (age as int?),
      isMinor: isMinor == _undefined || isMinor == null
          ? _instance.isMinor
          : (isMinor as bool),
      hasAccount: hasAccount == _undefined || hasAccount == null
          ? _instance.hasAccount
          : (hasAccount as bool),
      email: email == _undefined ? _instance.email : (email as String?),
      phone: phone == _undefined ? _instance.phone : (phone as String?),
      addressLine: addressLine == _undefined
          ? _instance.addressLine
          : (addressLine as String?),
      city: city == _undefined ? _instance.city : (city as String?),
      province: province == _undefined
          ? _instance.province
          : (province as String?),
      postalCode: postalCode == _undefined
          ? _instance.postalCode
          : (postalCode as String?),
      teams: teams == _undefined || teams == null
          ? _instance.teams
          : (teams as List<Fragment$MyPersonFields$teams>),
      guardians: guardians == _undefined || guardians == null
          ? _instance.guardians
          : (guardians as List<Fragment$MyPersonFields$guardians>),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  TRes teams(
    Iterable<Fragment$MyPersonFields$teams> Function(
      Iterable<
        CopyWith$Fragment$MyPersonFields$teams<Fragment$MyPersonFields$teams>
      >,
    )
    _fn,
  ) => call(
    teams: _fn(
      _instance.teams.map(
        (e) => CopyWith$Fragment$MyPersonFields$teams(e, (i) => i),
      ),
    ).toList(),
  );

  TRes guardians(
    Iterable<Fragment$MyPersonFields$guardians> Function(
      Iterable<
        CopyWith$Fragment$MyPersonFields$guardians<
          Fragment$MyPersonFields$guardians
        >
      >,
    )
    _fn,
  ) => call(
    guardians: _fn(
      _instance.guardians.map(
        (e) => CopyWith$Fragment$MyPersonFields$guardians(e, (i) => i),
      ),
    ).toList(),
  );
}

class _CopyWithStubImpl$Fragment$MyPersonFields<TRes>
    implements CopyWith$Fragment$MyPersonFields<TRes> {
  _CopyWithStubImpl$Fragment$MyPersonFields(this._res);

  TRes _res;

  call({
    String? id,
    String? firstName,
    String? lastName,
    String? birthDate,
    int? age,
    bool? isMinor,
    bool? hasAccount,
    String? email,
    String? phone,
    String? addressLine,
    String? city,
    String? province,
    String? postalCode,
    List<Fragment$MyPersonFields$teams>? teams,
    List<Fragment$MyPersonFields$guardians>? guardians,
    String? $__typename,
  }) => _res;

  teams(_fn) => _res;

  guardians(_fn) => _res;
}

const fragmentDefinitionMyPersonFields = FragmentDefinitionNode(
  name: NameNode(value: 'MyPersonFields'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'Person'), isNonNull: false),
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
        name: NameNode(value: 'firstName'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'lastName'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'birthDate'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'age'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'isMinor'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'hasAccount'),
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
        name: NameNode(value: 'phone'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'addressLine'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'city'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'province'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'postalCode'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'teams'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(
          selections: [
            FieldNode(
              name: NameNode(value: 'teamId'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
            FieldNode(
              name: NameNode(value: 'teamName'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
            FieldNode(
              name: NameNode(value: 'seasonName'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
            FieldNode(
              name: NameNode(value: 'asPlayer'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
            FieldNode(
              name: NameNode(value: 'staffRole'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
            FieldNode(
              name: NameNode(value: 'jerseyNumber'),
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
        name: NameNode(value: 'guardians'),
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
              name: NameNode(value: 'relation'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
            FieldNode(
              name: NameNode(value: 'person'),
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
                    name: NameNode(value: 'firstName'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'lastName'),
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
const documentNodeFragmentMyPersonFields = DocumentNode(
  definitions: [fragmentDefinitionMyPersonFields],
);

class Fragment$MyPersonFields$teams {
  Fragment$MyPersonFields$teams({
    required this.teamId,
    required this.teamName,
    required this.seasonName,
    required this.asPlayer,
    this.staffRole,
    this.jerseyNumber,
    this.$__typename = 'PersonTeam',
  });

  factory Fragment$MyPersonFields$teams.fromJson(Map<String, dynamic> json) {
    final l$teamId = json['teamId'];
    final l$teamName = json['teamName'];
    final l$seasonName = json['seasonName'];
    final l$asPlayer = json['asPlayer'];
    final l$staffRole = json['staffRole'];
    final l$jerseyNumber = json['jerseyNumber'];
    final l$$__typename = json['__typename'];
    return Fragment$MyPersonFields$teams(
      teamId: (l$teamId as String),
      teamName: (l$teamName as String),
      seasonName: (l$seasonName as String),
      asPlayer: (l$asPlayer as bool),
      staffRole: l$staffRole == null
          ? null
          : fromJson$Enum$StaffRole((l$staffRole as String)),
      jerseyNumber: (l$jerseyNumber as int?),
      $__typename: (l$$__typename as String),
    );
  }

  final String teamId;

  final String teamName;

  final String seasonName;

  final bool asPlayer;

  final Enum$StaffRole? staffRole;

  final int? jerseyNumber;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$teamId = teamId;
    _resultData['teamId'] = l$teamId;
    final l$teamName = teamName;
    _resultData['teamName'] = l$teamName;
    final l$seasonName = seasonName;
    _resultData['seasonName'] = l$seasonName;
    final l$asPlayer = asPlayer;
    _resultData['asPlayer'] = l$asPlayer;
    final l$staffRole = staffRole;
    _resultData['staffRole'] = l$staffRole == null
        ? null
        : toJson$Enum$StaffRole(l$staffRole);
    final l$jerseyNumber = jerseyNumber;
    _resultData['jerseyNumber'] = l$jerseyNumber;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$teamId = teamId;
    final l$teamName = teamName;
    final l$seasonName = seasonName;
    final l$asPlayer = asPlayer;
    final l$staffRole = staffRole;
    final l$jerseyNumber = jerseyNumber;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$teamId,
      l$teamName,
      l$seasonName,
      l$asPlayer,
      l$staffRole,
      l$jerseyNumber,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$MyPersonFields$teams ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$teamId = teamId;
    final lOther$teamId = other.teamId;
    if (l$teamId != lOther$teamId) {
      return false;
    }
    final l$teamName = teamName;
    final lOther$teamName = other.teamName;
    if (l$teamName != lOther$teamName) {
      return false;
    }
    final l$seasonName = seasonName;
    final lOther$seasonName = other.seasonName;
    if (l$seasonName != lOther$seasonName) {
      return false;
    }
    final l$asPlayer = asPlayer;
    final lOther$asPlayer = other.asPlayer;
    if (l$asPlayer != lOther$asPlayer) {
      return false;
    }
    final l$staffRole = staffRole;
    final lOther$staffRole = other.staffRole;
    if (l$staffRole != lOther$staffRole) {
      return false;
    }
    final l$jerseyNumber = jerseyNumber;
    final lOther$jerseyNumber = other.jerseyNumber;
    if (l$jerseyNumber != lOther$jerseyNumber) {
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

extension UtilityExtension$Fragment$MyPersonFields$teams
    on Fragment$MyPersonFields$teams {
  CopyWith$Fragment$MyPersonFields$teams<Fragment$MyPersonFields$teams>
  get copyWith => CopyWith$Fragment$MyPersonFields$teams(this, (i) => i);
}

abstract class CopyWith$Fragment$MyPersonFields$teams<TRes> {
  factory CopyWith$Fragment$MyPersonFields$teams(
    Fragment$MyPersonFields$teams instance,
    TRes Function(Fragment$MyPersonFields$teams) then,
  ) = _CopyWithImpl$Fragment$MyPersonFields$teams;

  factory CopyWith$Fragment$MyPersonFields$teams.stub(TRes res) =
      _CopyWithStubImpl$Fragment$MyPersonFields$teams;

  TRes call({
    String? teamId,
    String? teamName,
    String? seasonName,
    bool? asPlayer,
    Enum$StaffRole? staffRole,
    int? jerseyNumber,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$MyPersonFields$teams<TRes>
    implements CopyWith$Fragment$MyPersonFields$teams<TRes> {
  _CopyWithImpl$Fragment$MyPersonFields$teams(this._instance, this._then);

  final Fragment$MyPersonFields$teams _instance;

  final TRes Function(Fragment$MyPersonFields$teams) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? teamId = _undefined,
    Object? teamName = _undefined,
    Object? seasonName = _undefined,
    Object? asPlayer = _undefined,
    Object? staffRole = _undefined,
    Object? jerseyNumber = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$MyPersonFields$teams(
      teamId: teamId == _undefined || teamId == null
          ? _instance.teamId
          : (teamId as String),
      teamName: teamName == _undefined || teamName == null
          ? _instance.teamName
          : (teamName as String),
      seasonName: seasonName == _undefined || seasonName == null
          ? _instance.seasonName
          : (seasonName as String),
      asPlayer: asPlayer == _undefined || asPlayer == null
          ? _instance.asPlayer
          : (asPlayer as bool),
      staffRole: staffRole == _undefined
          ? _instance.staffRole
          : (staffRole as Enum$StaffRole?),
      jerseyNumber: jerseyNumber == _undefined
          ? _instance.jerseyNumber
          : (jerseyNumber as int?),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Fragment$MyPersonFields$teams<TRes>
    implements CopyWith$Fragment$MyPersonFields$teams<TRes> {
  _CopyWithStubImpl$Fragment$MyPersonFields$teams(this._res);

  TRes _res;

  call({
    String? teamId,
    String? teamName,
    String? seasonName,
    bool? asPlayer,
    Enum$StaffRole? staffRole,
    int? jerseyNumber,
    String? $__typename,
  }) => _res;
}

class Fragment$MyPersonFields$guardians {
  Fragment$MyPersonFields$guardians({
    required this.id,
    required this.relation,
    required this.person,
    this.$__typename = 'GuardianLink',
  });

  factory Fragment$MyPersonFields$guardians.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$id = json['id'];
    final l$relation = json['relation'];
    final l$person = json['person'];
    final l$$__typename = json['__typename'];
    return Fragment$MyPersonFields$guardians(
      id: (l$id as String),
      relation: fromJson$Enum$GuardianRelation((l$relation as String)),
      person: Fragment$MyPersonFields$guardians$person.fromJson(
        (l$person as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final Enum$GuardianRelation relation;

  final Fragment$MyPersonFields$guardians$person person;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$relation = relation;
    _resultData['relation'] = toJson$Enum$GuardianRelation(l$relation);
    final l$person = person;
    _resultData['person'] = l$person.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$relation = relation;
    final l$person = person;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$relation, l$person, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$MyPersonFields$guardians ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$relation = relation;
    final lOther$relation = other.relation;
    if (l$relation != lOther$relation) {
      return false;
    }
    final l$person = person;
    final lOther$person = other.person;
    if (l$person != lOther$person) {
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

extension UtilityExtension$Fragment$MyPersonFields$guardians
    on Fragment$MyPersonFields$guardians {
  CopyWith$Fragment$MyPersonFields$guardians<Fragment$MyPersonFields$guardians>
  get copyWith => CopyWith$Fragment$MyPersonFields$guardians(this, (i) => i);
}

abstract class CopyWith$Fragment$MyPersonFields$guardians<TRes> {
  factory CopyWith$Fragment$MyPersonFields$guardians(
    Fragment$MyPersonFields$guardians instance,
    TRes Function(Fragment$MyPersonFields$guardians) then,
  ) = _CopyWithImpl$Fragment$MyPersonFields$guardians;

  factory CopyWith$Fragment$MyPersonFields$guardians.stub(TRes res) =
      _CopyWithStubImpl$Fragment$MyPersonFields$guardians;

  TRes call({
    String? id,
    Enum$GuardianRelation? relation,
    Fragment$MyPersonFields$guardians$person? person,
    String? $__typename,
  });
  CopyWith$Fragment$MyPersonFields$guardians$person<TRes> get person;
}

class _CopyWithImpl$Fragment$MyPersonFields$guardians<TRes>
    implements CopyWith$Fragment$MyPersonFields$guardians<TRes> {
  _CopyWithImpl$Fragment$MyPersonFields$guardians(this._instance, this._then);

  final Fragment$MyPersonFields$guardians _instance;

  final TRes Function(Fragment$MyPersonFields$guardians) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? relation = _undefined,
    Object? person = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$MyPersonFields$guardians(
      id: id == _undefined || id == null ? _instance.id : (id as String),
      relation: relation == _undefined || relation == null
          ? _instance.relation
          : (relation as Enum$GuardianRelation),
      person: person == _undefined || person == null
          ? _instance.person
          : (person as Fragment$MyPersonFields$guardians$person),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  CopyWith$Fragment$MyPersonFields$guardians$person<TRes> get person {
    final local$person = _instance.person;
    return CopyWith$Fragment$MyPersonFields$guardians$person(
      local$person,
      (e) => call(person: e),
    );
  }
}

class _CopyWithStubImpl$Fragment$MyPersonFields$guardians<TRes>
    implements CopyWith$Fragment$MyPersonFields$guardians<TRes> {
  _CopyWithStubImpl$Fragment$MyPersonFields$guardians(this._res);

  TRes _res;

  call({
    String? id,
    Enum$GuardianRelation? relation,
    Fragment$MyPersonFields$guardians$person? person,
    String? $__typename,
  }) => _res;

  CopyWith$Fragment$MyPersonFields$guardians$person<TRes> get person =>
      CopyWith$Fragment$MyPersonFields$guardians$person.stub(_res);
}

class Fragment$MyPersonFields$guardians$person {
  Fragment$MyPersonFields$guardians$person({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.$__typename = 'PersonRef',
  });

  factory Fragment$MyPersonFields$guardians$person.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$id = json['id'];
    final l$firstName = json['firstName'];
    final l$lastName = json['lastName'];
    final l$$__typename = json['__typename'];
    return Fragment$MyPersonFields$guardians$person(
      id: (l$id as String),
      firstName: (l$firstName as String),
      lastName: (l$lastName as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String firstName;

  final String lastName;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$firstName = firstName;
    _resultData['firstName'] = l$firstName;
    final l$lastName = lastName;
    _resultData['lastName'] = l$lastName;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$firstName = firstName;
    final l$lastName = lastName;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$firstName, l$lastName, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$MyPersonFields$guardians$person ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$firstName = firstName;
    final lOther$firstName = other.firstName;
    if (l$firstName != lOther$firstName) {
      return false;
    }
    final l$lastName = lastName;
    final lOther$lastName = other.lastName;
    if (l$lastName != lOther$lastName) {
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

extension UtilityExtension$Fragment$MyPersonFields$guardians$person
    on Fragment$MyPersonFields$guardians$person {
  CopyWith$Fragment$MyPersonFields$guardians$person<
    Fragment$MyPersonFields$guardians$person
  >
  get copyWith =>
      CopyWith$Fragment$MyPersonFields$guardians$person(this, (i) => i);
}

abstract class CopyWith$Fragment$MyPersonFields$guardians$person<TRes> {
  factory CopyWith$Fragment$MyPersonFields$guardians$person(
    Fragment$MyPersonFields$guardians$person instance,
    TRes Function(Fragment$MyPersonFields$guardians$person) then,
  ) = _CopyWithImpl$Fragment$MyPersonFields$guardians$person;

  factory CopyWith$Fragment$MyPersonFields$guardians$person.stub(TRes res) =
      _CopyWithStubImpl$Fragment$MyPersonFields$guardians$person;

  TRes call({
    String? id,
    String? firstName,
    String? lastName,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$MyPersonFields$guardians$person<TRes>
    implements CopyWith$Fragment$MyPersonFields$guardians$person<TRes> {
  _CopyWithImpl$Fragment$MyPersonFields$guardians$person(
    this._instance,
    this._then,
  );

  final Fragment$MyPersonFields$guardians$person _instance;

  final TRes Function(Fragment$MyPersonFields$guardians$person) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? firstName = _undefined,
    Object? lastName = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$MyPersonFields$guardians$person(
      id: id == _undefined || id == null ? _instance.id : (id as String),
      firstName: firstName == _undefined || firstName == null
          ? _instance.firstName
          : (firstName as String),
      lastName: lastName == _undefined || lastName == null
          ? _instance.lastName
          : (lastName as String),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Fragment$MyPersonFields$guardians$person<TRes>
    implements CopyWith$Fragment$MyPersonFields$guardians$person<TRes> {
  _CopyWithStubImpl$Fragment$MyPersonFields$guardians$person(this._res);

  TRes _res;

  call({
    String? id,
    String? firstName,
    String? lastName,
    String? $__typename,
  }) => _res;
}

class Query$MyPeople {
  Query$MyPeople({required this.myPeople, this.$__typename = 'Query'});

  factory Query$MyPeople.fromJson(Map<String, dynamic> json) {
    final l$myPeople = json['myPeople'];
    final l$$__typename = json['__typename'];
    return Query$MyPeople(
      myPeople: (l$myPeople as List<dynamic>)
          .map(
            (e) =>
                Fragment$MyPersonFields.fromJson((e as Map<String, dynamic>)),
          )
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Fragment$MyPersonFields> myPeople;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$myPeople = myPeople;
    _resultData['myPeople'] = l$myPeople.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$myPeople = myPeople;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$myPeople.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$MyPeople || runtimeType != other.runtimeType) {
      return false;
    }
    final l$myPeople = myPeople;
    final lOther$myPeople = other.myPeople;
    if (l$myPeople.length != lOther$myPeople.length) {
      return false;
    }
    for (int i = 0; i < l$myPeople.length; i++) {
      final l$myPeople$entry = l$myPeople[i];
      final lOther$myPeople$entry = lOther$myPeople[i];
      if (l$myPeople$entry != lOther$myPeople$entry) {
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

extension UtilityExtension$Query$MyPeople on Query$MyPeople {
  CopyWith$Query$MyPeople<Query$MyPeople> get copyWith =>
      CopyWith$Query$MyPeople(this, (i) => i);
}

abstract class CopyWith$Query$MyPeople<TRes> {
  factory CopyWith$Query$MyPeople(
    Query$MyPeople instance,
    TRes Function(Query$MyPeople) then,
  ) = _CopyWithImpl$Query$MyPeople;

  factory CopyWith$Query$MyPeople.stub(TRes res) =
      _CopyWithStubImpl$Query$MyPeople;

  TRes call({List<Fragment$MyPersonFields>? myPeople, String? $__typename});
  TRes myPeople(
    Iterable<Fragment$MyPersonFields> Function(
      Iterable<CopyWith$Fragment$MyPersonFields<Fragment$MyPersonFields>>,
    )
    _fn,
  );
}

class _CopyWithImpl$Query$MyPeople<TRes>
    implements CopyWith$Query$MyPeople<TRes> {
  _CopyWithImpl$Query$MyPeople(this._instance, this._then);

  final Query$MyPeople _instance;

  final TRes Function(Query$MyPeople) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? myPeople = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$MyPeople(
      myPeople: myPeople == _undefined || myPeople == null
          ? _instance.myPeople
          : (myPeople as List<Fragment$MyPersonFields>),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  TRes myPeople(
    Iterable<Fragment$MyPersonFields> Function(
      Iterable<CopyWith$Fragment$MyPersonFields<Fragment$MyPersonFields>>,
    )
    _fn,
  ) => call(
    myPeople: _fn(
      _instance.myPeople.map(
        (e) => CopyWith$Fragment$MyPersonFields(e, (i) => i),
      ),
    ).toList(),
  );
}

class _CopyWithStubImpl$Query$MyPeople<TRes>
    implements CopyWith$Query$MyPeople<TRes> {
  _CopyWithStubImpl$Query$MyPeople(this._res);

  TRes _res;

  call({List<Fragment$MyPersonFields>? myPeople, String? $__typename}) => _res;

  myPeople(_fn) => _res;
}

const documentNodeQueryMyPeople = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'MyPeople'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'myPeople'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FragmentSpreadNode(
                  name: NameNode(value: 'MyPersonFields'),
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
    fragmentDefinitionMyPersonFields,
  ],
);

class Variables$Mutation$UpdatePersonContacts {
  factory Variables$Mutation$UpdatePersonContacts({
    required String id,
    required Input$PersonContactsInput input,
  }) => Variables$Mutation$UpdatePersonContacts._({r'id': id, r'input': input});

  Variables$Mutation$UpdatePersonContacts._(this._$data);

  factory Variables$Mutation$UpdatePersonContacts.fromJson(
    Map<String, dynamic> data,
  ) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    final l$input = data['input'];
    result$data['input'] = Input$PersonContactsInput.fromJson(
      (l$input as Map<String, dynamic>),
    );
    return Variables$Mutation$UpdatePersonContacts._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  Input$PersonContactsInput get input =>
      (_$data['input'] as Input$PersonContactsInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    final l$input = input;
    result$data['input'] = l$input.toJson();
    return result$data;
  }

  CopyWith$Variables$Mutation$UpdatePersonContacts<
    Variables$Mutation$UpdatePersonContacts
  >
  get copyWith =>
      CopyWith$Variables$Mutation$UpdatePersonContacts(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$UpdatePersonContacts ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
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
    final l$id = id;
    final l$input = input;
    return Object.hashAll([l$id, l$input]);
  }
}

abstract class CopyWith$Variables$Mutation$UpdatePersonContacts<TRes> {
  factory CopyWith$Variables$Mutation$UpdatePersonContacts(
    Variables$Mutation$UpdatePersonContacts instance,
    TRes Function(Variables$Mutation$UpdatePersonContacts) then,
  ) = _CopyWithImpl$Variables$Mutation$UpdatePersonContacts;

  factory CopyWith$Variables$Mutation$UpdatePersonContacts.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$UpdatePersonContacts;

  TRes call({String? id, Input$PersonContactsInput? input});
}

class _CopyWithImpl$Variables$Mutation$UpdatePersonContacts<TRes>
    implements CopyWith$Variables$Mutation$UpdatePersonContacts<TRes> {
  _CopyWithImpl$Variables$Mutation$UpdatePersonContacts(
    this._instance,
    this._then,
  );

  final Variables$Mutation$UpdatePersonContacts _instance;

  final TRes Function(Variables$Mutation$UpdatePersonContacts) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? id = _undefined, Object? input = _undefined}) => _then(
    Variables$Mutation$UpdatePersonContacts._({
      ..._instance._$data,
      if (id != _undefined && id != null) 'id': (id as String),
      if (input != _undefined && input != null)
        'input': (input as Input$PersonContactsInput),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$UpdatePersonContacts<TRes>
    implements CopyWith$Variables$Mutation$UpdatePersonContacts<TRes> {
  _CopyWithStubImpl$Variables$Mutation$UpdatePersonContacts(this._res);

  TRes _res;

  call({String? id, Input$PersonContactsInput? input}) => _res;
}

class Mutation$UpdatePersonContacts {
  Mutation$UpdatePersonContacts({
    required this.updatePersonContacts,
    this.$__typename = 'Mutation',
  });

  factory Mutation$UpdatePersonContacts.fromJson(Map<String, dynamic> json) {
    final l$updatePersonContacts = json['updatePersonContacts'];
    final l$$__typename = json['__typename'];
    return Mutation$UpdatePersonContacts(
      updatePersonContacts: Fragment$MyPersonFields.fromJson(
        (l$updatePersonContacts as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$MyPersonFields updatePersonContacts;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updatePersonContacts = updatePersonContacts;
    _resultData['updatePersonContacts'] = l$updatePersonContacts.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updatePersonContacts = updatePersonContacts;
    final l$$__typename = $__typename;
    return Object.hashAll([l$updatePersonContacts, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$UpdatePersonContacts ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$updatePersonContacts = updatePersonContacts;
    final lOther$updatePersonContacts = other.updatePersonContacts;
    if (l$updatePersonContacts != lOther$updatePersonContacts) {
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

extension UtilityExtension$Mutation$UpdatePersonContacts
    on Mutation$UpdatePersonContacts {
  CopyWith$Mutation$UpdatePersonContacts<Mutation$UpdatePersonContacts>
  get copyWith => CopyWith$Mutation$UpdatePersonContacts(this, (i) => i);
}

abstract class CopyWith$Mutation$UpdatePersonContacts<TRes> {
  factory CopyWith$Mutation$UpdatePersonContacts(
    Mutation$UpdatePersonContacts instance,
    TRes Function(Mutation$UpdatePersonContacts) then,
  ) = _CopyWithImpl$Mutation$UpdatePersonContacts;

  factory CopyWith$Mutation$UpdatePersonContacts.stub(TRes res) =
      _CopyWithStubImpl$Mutation$UpdatePersonContacts;

  TRes call({
    Fragment$MyPersonFields? updatePersonContacts,
    String? $__typename,
  });
  CopyWith$Fragment$MyPersonFields<TRes> get updatePersonContacts;
}

class _CopyWithImpl$Mutation$UpdatePersonContacts<TRes>
    implements CopyWith$Mutation$UpdatePersonContacts<TRes> {
  _CopyWithImpl$Mutation$UpdatePersonContacts(this._instance, this._then);

  final Mutation$UpdatePersonContacts _instance;

  final TRes Function(Mutation$UpdatePersonContacts) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? updatePersonContacts = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$UpdatePersonContacts(
      updatePersonContacts:
          updatePersonContacts == _undefined || updatePersonContacts == null
          ? _instance.updatePersonContacts
          : (updatePersonContacts as Fragment$MyPersonFields),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  CopyWith$Fragment$MyPersonFields<TRes> get updatePersonContacts {
    final local$updatePersonContacts = _instance.updatePersonContacts;
    return CopyWith$Fragment$MyPersonFields(
      local$updatePersonContacts,
      (e) => call(updatePersonContacts: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$UpdatePersonContacts<TRes>
    implements CopyWith$Mutation$UpdatePersonContacts<TRes> {
  _CopyWithStubImpl$Mutation$UpdatePersonContacts(this._res);

  TRes _res;

  call({Fragment$MyPersonFields? updatePersonContacts, String? $__typename}) =>
      _res;

  CopyWith$Fragment$MyPersonFields<TRes> get updatePersonContacts =>
      CopyWith$Fragment$MyPersonFields.stub(_res);
}

const documentNodeMutationUpdatePersonContacts = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'UpdatePersonContacts'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'id')),
          type: NamedTypeNode(name: NameNode(value: 'ID'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'input')),
          type: NamedTypeNode(
            name: NameNode(value: 'PersonContactsInput'),
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
            name: NameNode(value: 'updatePersonContacts'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'id'),
                value: VariableNode(name: NameNode(value: 'id')),
              ),
              ArgumentNode(
                name: NameNode(value: 'input'),
                value: VariableNode(name: NameNode(value: 'input')),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FragmentSpreadNode(
                  name: NameNode(value: 'MyPersonFields'),
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
    fragmentDefinitionMyPersonFields,
  ],
);

class Variables$Mutation$InviteAthleteAccount {
  factory Variables$Mutation$InviteAthleteAccount({
    required String personId,
    required String email,
  }) => Variables$Mutation$InviteAthleteAccount._({
    r'personId': personId,
    r'email': email,
  });

  Variables$Mutation$InviteAthleteAccount._(this._$data);

  factory Variables$Mutation$InviteAthleteAccount.fromJson(
    Map<String, dynamic> data,
  ) {
    final result$data = <String, dynamic>{};
    final l$personId = data['personId'];
    result$data['personId'] = (l$personId as String);
    final l$email = data['email'];
    result$data['email'] = (l$email as String);
    return Variables$Mutation$InviteAthleteAccount._(result$data);
  }

  Map<String, dynamic> _$data;

  String get personId => (_$data['personId'] as String);

  String get email => (_$data['email'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$personId = personId;
    result$data['personId'] = l$personId;
    final l$email = email;
    result$data['email'] = l$email;
    return result$data;
  }

  CopyWith$Variables$Mutation$InviteAthleteAccount<
    Variables$Mutation$InviteAthleteAccount
  >
  get copyWith =>
      CopyWith$Variables$Mutation$InviteAthleteAccount(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$InviteAthleteAccount ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$personId = personId;
    final lOther$personId = other.personId;
    if (l$personId != lOther$personId) {
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
    final l$personId = personId;
    final l$email = email;
    return Object.hashAll([l$personId, l$email]);
  }
}

abstract class CopyWith$Variables$Mutation$InviteAthleteAccount<TRes> {
  factory CopyWith$Variables$Mutation$InviteAthleteAccount(
    Variables$Mutation$InviteAthleteAccount instance,
    TRes Function(Variables$Mutation$InviteAthleteAccount) then,
  ) = _CopyWithImpl$Variables$Mutation$InviteAthleteAccount;

  factory CopyWith$Variables$Mutation$InviteAthleteAccount.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$InviteAthleteAccount;

  TRes call({String? personId, String? email});
}

class _CopyWithImpl$Variables$Mutation$InviteAthleteAccount<TRes>
    implements CopyWith$Variables$Mutation$InviteAthleteAccount<TRes> {
  _CopyWithImpl$Variables$Mutation$InviteAthleteAccount(
    this._instance,
    this._then,
  );

  final Variables$Mutation$InviteAthleteAccount _instance;

  final TRes Function(Variables$Mutation$InviteAthleteAccount) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? personId = _undefined, Object? email = _undefined}) =>
      _then(
        Variables$Mutation$InviteAthleteAccount._({
          ..._instance._$data,
          if (personId != _undefined && personId != null)
            'personId': (personId as String),
          if (email != _undefined && email != null) 'email': (email as String),
        }),
      );
}

class _CopyWithStubImpl$Variables$Mutation$InviteAthleteAccount<TRes>
    implements CopyWith$Variables$Mutation$InviteAthleteAccount<TRes> {
  _CopyWithStubImpl$Variables$Mutation$InviteAthleteAccount(this._res);

  TRes _res;

  call({String? personId, String? email}) => _res;
}

class Mutation$InviteAthleteAccount {
  Mutation$InviteAthleteAccount({
    required this.invitePersonAccount,
    this.$__typename = 'Mutation',
  });

  factory Mutation$InviteAthleteAccount.fromJson(Map<String, dynamic> json) {
    final l$invitePersonAccount = json['invitePersonAccount'];
    final l$$__typename = json['__typename'];
    return Mutation$InviteAthleteAccount(
      invitePersonAccount:
          Mutation$InviteAthleteAccount$invitePersonAccount.fromJson(
            (l$invitePersonAccount as Map<String, dynamic>),
          ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$InviteAthleteAccount$invitePersonAccount invitePersonAccount;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$invitePersonAccount = invitePersonAccount;
    _resultData['invitePersonAccount'] = l$invitePersonAccount.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$invitePersonAccount = invitePersonAccount;
    final l$$__typename = $__typename;
    return Object.hashAll([l$invitePersonAccount, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$InviteAthleteAccount ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$invitePersonAccount = invitePersonAccount;
    final lOther$invitePersonAccount = other.invitePersonAccount;
    if (l$invitePersonAccount != lOther$invitePersonAccount) {
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

extension UtilityExtension$Mutation$InviteAthleteAccount
    on Mutation$InviteAthleteAccount {
  CopyWith$Mutation$InviteAthleteAccount<Mutation$InviteAthleteAccount>
  get copyWith => CopyWith$Mutation$InviteAthleteAccount(this, (i) => i);
}

abstract class CopyWith$Mutation$InviteAthleteAccount<TRes> {
  factory CopyWith$Mutation$InviteAthleteAccount(
    Mutation$InviteAthleteAccount instance,
    TRes Function(Mutation$InviteAthleteAccount) then,
  ) = _CopyWithImpl$Mutation$InviteAthleteAccount;

  factory CopyWith$Mutation$InviteAthleteAccount.stub(TRes res) =
      _CopyWithStubImpl$Mutation$InviteAthleteAccount;

  TRes call({
    Mutation$InviteAthleteAccount$invitePersonAccount? invitePersonAccount,
    String? $__typename,
  });
  CopyWith$Mutation$InviteAthleteAccount$invitePersonAccount<TRes>
  get invitePersonAccount;
}

class _CopyWithImpl$Mutation$InviteAthleteAccount<TRes>
    implements CopyWith$Mutation$InviteAthleteAccount<TRes> {
  _CopyWithImpl$Mutation$InviteAthleteAccount(this._instance, this._then);

  final Mutation$InviteAthleteAccount _instance;

  final TRes Function(Mutation$InviteAthleteAccount) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? invitePersonAccount = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$InviteAthleteAccount(
      invitePersonAccount:
          invitePersonAccount == _undefined || invitePersonAccount == null
          ? _instance.invitePersonAccount
          : (invitePersonAccount
                as Mutation$InviteAthleteAccount$invitePersonAccount),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  CopyWith$Mutation$InviteAthleteAccount$invitePersonAccount<TRes>
  get invitePersonAccount {
    final local$invitePersonAccount = _instance.invitePersonAccount;
    return CopyWith$Mutation$InviteAthleteAccount$invitePersonAccount(
      local$invitePersonAccount,
      (e) => call(invitePersonAccount: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$InviteAthleteAccount<TRes>
    implements CopyWith$Mutation$InviteAthleteAccount<TRes> {
  _CopyWithStubImpl$Mutation$InviteAthleteAccount(this._res);

  TRes _res;

  call({
    Mutation$InviteAthleteAccount$invitePersonAccount? invitePersonAccount,
    String? $__typename,
  }) => _res;

  CopyWith$Mutation$InviteAthleteAccount$invitePersonAccount<TRes>
  get invitePersonAccount =>
      CopyWith$Mutation$InviteAthleteAccount$invitePersonAccount.stub(_res);
}

const documentNodeMutationInviteAthleteAccount = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'InviteAthleteAccount'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'personId')),
          type: NamedTypeNode(name: NameNode(value: 'ID'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
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
            name: NameNode(value: 'invitePersonAccount'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'personId'),
                value: VariableNode(name: NameNode(value: 'personId')),
              ),
              ArgumentNode(
                name: NameNode(value: 'email'),
                value: VariableNode(name: NameNode(value: 'email')),
              ),
              ArgumentNode(
                name: NameNode(value: 'role'),
                value: EnumValueNode(name: NameNode(value: 'ATHLETE')),
              ),
            ],
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

class Mutation$InviteAthleteAccount$invitePersonAccount {
  Mutation$InviteAthleteAccount$invitePersonAccount({
    required this.id,
    this.$__typename = 'Invitation',
  });

  factory Mutation$InviteAthleteAccount$invitePersonAccount.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$id = json['id'];
    final l$$__typename = json['__typename'];
    return Mutation$InviteAthleteAccount$invitePersonAccount(
      id: (l$id as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$InviteAthleteAccount$invitePersonAccount ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
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

extension UtilityExtension$Mutation$InviteAthleteAccount$invitePersonAccount
    on Mutation$InviteAthleteAccount$invitePersonAccount {
  CopyWith$Mutation$InviteAthleteAccount$invitePersonAccount<
    Mutation$InviteAthleteAccount$invitePersonAccount
  >
  get copyWith => CopyWith$Mutation$InviteAthleteAccount$invitePersonAccount(
    this,
    (i) => i,
  );
}

abstract class CopyWith$Mutation$InviteAthleteAccount$invitePersonAccount<
  TRes
> {
  factory CopyWith$Mutation$InviteAthleteAccount$invitePersonAccount(
    Mutation$InviteAthleteAccount$invitePersonAccount instance,
    TRes Function(Mutation$InviteAthleteAccount$invitePersonAccount) then,
  ) = _CopyWithImpl$Mutation$InviteAthleteAccount$invitePersonAccount;

  factory CopyWith$Mutation$InviteAthleteAccount$invitePersonAccount.stub(
    TRes res,
  ) = _CopyWithStubImpl$Mutation$InviteAthleteAccount$invitePersonAccount;

  TRes call({String? id, String? $__typename});
}

class _CopyWithImpl$Mutation$InviteAthleteAccount$invitePersonAccount<TRes>
    implements
        CopyWith$Mutation$InviteAthleteAccount$invitePersonAccount<TRes> {
  _CopyWithImpl$Mutation$InviteAthleteAccount$invitePersonAccount(
    this._instance,
    this._then,
  );

  final Mutation$InviteAthleteAccount$invitePersonAccount _instance;

  final TRes Function(Mutation$InviteAthleteAccount$invitePersonAccount) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? id = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Mutation$InviteAthleteAccount$invitePersonAccount(
          id: id == _undefined || id == null ? _instance.id : (id as String),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
        ),
      );
}

class _CopyWithStubImpl$Mutation$InviteAthleteAccount$invitePersonAccount<TRes>
    implements
        CopyWith$Mutation$InviteAthleteAccount$invitePersonAccount<TRes> {
  _CopyWithStubImpl$Mutation$InviteAthleteAccount$invitePersonAccount(
    this._res,
  );

  TRes _res;

  call({String? id, String? $__typename}) => _res;
}
