import 'package:gql/ast.dart';

import 'schema.graphql.dart';

class Query$MyTeams {
  Query$MyTeams({required this.teams, this.$__typename = 'Query'});

  factory Query$MyTeams.fromJson(Map<String, dynamic> json) {
    final l$teams = json['teams'];
    final l$$__typename = json['__typename'];
    return Query$MyTeams(
      teams: (l$teams as List<dynamic>)
          .map((e) => Query$MyTeams$teams.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Query$MyTeams$teams> teams;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$teams = teams;
    _resultData['teams'] = l$teams.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$teams = teams;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$teams.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$MyTeams || runtimeType != other.runtimeType) {
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
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$MyTeams on Query$MyTeams {
  CopyWith$Query$MyTeams<Query$MyTeams> get copyWith =>
      CopyWith$Query$MyTeams(this, (i) => i);
}

abstract class CopyWith$Query$MyTeams<TRes> {
  factory CopyWith$Query$MyTeams(
    Query$MyTeams instance,
    TRes Function(Query$MyTeams) then,
  ) = _CopyWithImpl$Query$MyTeams;

  factory CopyWith$Query$MyTeams.stub(TRes res) =
      _CopyWithStubImpl$Query$MyTeams;

  TRes call({List<Query$MyTeams$teams>? teams, String? $__typename});
  TRes teams(
    Iterable<Query$MyTeams$teams> Function(
      Iterable<CopyWith$Query$MyTeams$teams<Query$MyTeams$teams>>,
    )
    _fn,
  );
}

class _CopyWithImpl$Query$MyTeams<TRes>
    implements CopyWith$Query$MyTeams<TRes> {
  _CopyWithImpl$Query$MyTeams(this._instance, this._then);

  final Query$MyTeams _instance;

  final TRes Function(Query$MyTeams) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? teams = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Query$MyTeams(
          teams: teams == _undefined || teams == null
              ? _instance.teams
              : (teams as List<Query$MyTeams$teams>),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
        ),
      );

  TRes teams(
    Iterable<Query$MyTeams$teams> Function(
      Iterable<CopyWith$Query$MyTeams$teams<Query$MyTeams$teams>>,
    )
    _fn,
  ) => call(
    teams: _fn(
      _instance.teams.map((e) => CopyWith$Query$MyTeams$teams(e, (i) => i)),
    ).toList(),
  );
}

class _CopyWithStubImpl$Query$MyTeams<TRes>
    implements CopyWith$Query$MyTeams<TRes> {
  _CopyWithStubImpl$Query$MyTeams(this._res);

  TRes _res;

  call({List<Query$MyTeams$teams>? teams, String? $__typename}) => _res;

  teams(_fn) => _res;
}

const documentNodeQueryMyTeams = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'MyTeams'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'teams'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'includeArchived'),
                value: BooleanValueNode(value: false),
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
                  name: NameNode(value: 'name'),
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
                  name: NameNode(value: 'category'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'color'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'playerCount'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'staffCount'),
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

class Query$MyTeams$teams {
  Query$MyTeams$teams({
    required this.id,
    required this.name,
    required this.seasonName,
    this.category,
    this.color,
    required this.playerCount,
    required this.staffCount,
    this.$__typename = 'Team',
  });

  factory Query$MyTeams$teams.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$seasonName = json['seasonName'];
    final l$category = json['category'];
    final l$color = json['color'];
    final l$playerCount = json['playerCount'];
    final l$staffCount = json['staffCount'];
    final l$$__typename = json['__typename'];
    return Query$MyTeams$teams(
      id: (l$id as String),
      name: (l$name as String),
      seasonName: (l$seasonName as String),
      category: (l$category as String?),
      color: (l$color as String?),
      playerCount: (l$playerCount as int),
      staffCount: (l$staffCount as int),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String name;

  final String seasonName;

  final String? category;

  final String? color;

  final int playerCount;

  final int staffCount;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$seasonName = seasonName;
    _resultData['seasonName'] = l$seasonName;
    final l$category = category;
    _resultData['category'] = l$category;
    final l$color = color;
    _resultData['color'] = l$color;
    final l$playerCount = playerCount;
    _resultData['playerCount'] = l$playerCount;
    final l$staffCount = staffCount;
    _resultData['staffCount'] = l$staffCount;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$name = name;
    final l$seasonName = seasonName;
    final l$category = category;
    final l$color = color;
    final l$playerCount = playerCount;
    final l$staffCount = staffCount;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$name,
      l$seasonName,
      l$category,
      l$color,
      l$playerCount,
      l$staffCount,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$MyTeams$teams || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$seasonName = seasonName;
    final lOther$seasonName = other.seasonName;
    if (l$seasonName != lOther$seasonName) {
      return false;
    }
    final l$category = category;
    final lOther$category = other.category;
    if (l$category != lOther$category) {
      return false;
    }
    final l$color = color;
    final lOther$color = other.color;
    if (l$color != lOther$color) {
      return false;
    }
    final l$playerCount = playerCount;
    final lOther$playerCount = other.playerCount;
    if (l$playerCount != lOther$playerCount) {
      return false;
    }
    final l$staffCount = staffCount;
    final lOther$staffCount = other.staffCount;
    if (l$staffCount != lOther$staffCount) {
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

extension UtilityExtension$Query$MyTeams$teams on Query$MyTeams$teams {
  CopyWith$Query$MyTeams$teams<Query$MyTeams$teams> get copyWith =>
      CopyWith$Query$MyTeams$teams(this, (i) => i);
}

abstract class CopyWith$Query$MyTeams$teams<TRes> {
  factory CopyWith$Query$MyTeams$teams(
    Query$MyTeams$teams instance,
    TRes Function(Query$MyTeams$teams) then,
  ) = _CopyWithImpl$Query$MyTeams$teams;

  factory CopyWith$Query$MyTeams$teams.stub(TRes res) =
      _CopyWithStubImpl$Query$MyTeams$teams;

  TRes call({
    String? id,
    String? name,
    String? seasonName,
    String? category,
    String? color,
    int? playerCount,
    int? staffCount,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$MyTeams$teams<TRes>
    implements CopyWith$Query$MyTeams$teams<TRes> {
  _CopyWithImpl$Query$MyTeams$teams(this._instance, this._then);

  final Query$MyTeams$teams _instance;

  final TRes Function(Query$MyTeams$teams) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? name = _undefined,
    Object? seasonName = _undefined,
    Object? category = _undefined,
    Object? color = _undefined,
    Object? playerCount = _undefined,
    Object? staffCount = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$MyTeams$teams(
      id: id == _undefined || id == null ? _instance.id : (id as String),
      name: name == _undefined || name == null
          ? _instance.name
          : (name as String),
      seasonName: seasonName == _undefined || seasonName == null
          ? _instance.seasonName
          : (seasonName as String),
      category: category == _undefined
          ? _instance.category
          : (category as String?),
      color: color == _undefined ? _instance.color : (color as String?),
      playerCount: playerCount == _undefined || playerCount == null
          ? _instance.playerCount
          : (playerCount as int),
      staffCount: staffCount == _undefined || staffCount == null
          ? _instance.staffCount
          : (staffCount as int),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$MyTeams$teams<TRes>
    implements CopyWith$Query$MyTeams$teams<TRes> {
  _CopyWithStubImpl$Query$MyTeams$teams(this._res);

  TRes _res;

  call({
    String? id,
    String? name,
    String? seasonName,
    String? category,
    String? color,
    int? playerCount,
    int? staffCount,
    String? $__typename,
  }) => _res;
}

class Variables$Query$TeamRoster {
  factory Variables$Query$TeamRoster({required String id}) =>
      Variables$Query$TeamRoster._({r'id': id});

  Variables$Query$TeamRoster._(this._$data);

  factory Variables$Query$TeamRoster.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    return Variables$Query$TeamRoster._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    return result$data;
  }

  CopyWith$Variables$Query$TeamRoster<Variables$Query$TeamRoster>
  get copyWith => CopyWith$Variables$Query$TeamRoster(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Query$TeamRoster ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    return Object.hashAll([l$id]);
  }
}

abstract class CopyWith$Variables$Query$TeamRoster<TRes> {
  factory CopyWith$Variables$Query$TeamRoster(
    Variables$Query$TeamRoster instance,
    TRes Function(Variables$Query$TeamRoster) then,
  ) = _CopyWithImpl$Variables$Query$TeamRoster;

  factory CopyWith$Variables$Query$TeamRoster.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$TeamRoster;

  TRes call({String? id});
}

class _CopyWithImpl$Variables$Query$TeamRoster<TRes>
    implements CopyWith$Variables$Query$TeamRoster<TRes> {
  _CopyWithImpl$Variables$Query$TeamRoster(this._instance, this._then);

  final Variables$Query$TeamRoster _instance;

  final TRes Function(Variables$Query$TeamRoster) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? id = _undefined}) => _then(
    Variables$Query$TeamRoster._({
      ..._instance._$data,
      if (id != _undefined && id != null) 'id': (id as String),
    }),
  );
}

class _CopyWithStubImpl$Variables$Query$TeamRoster<TRes>
    implements CopyWith$Variables$Query$TeamRoster<TRes> {
  _CopyWithStubImpl$Variables$Query$TeamRoster(this._res);

  TRes _res;

  call({String? id}) => _res;
}

class Query$TeamRoster {
  Query$TeamRoster({required this.team, this.$__typename = 'Query'});

  factory Query$TeamRoster.fromJson(Map<String, dynamic> json) {
    final l$team = json['team'];
    final l$$__typename = json['__typename'];
    return Query$TeamRoster(
      team: Query$TeamRoster$team.fromJson((l$team as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$TeamRoster$team team;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$team = team;
    _resultData['team'] = l$team.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$team = team;
    final l$$__typename = $__typename;
    return Object.hashAll([l$team, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$TeamRoster || runtimeType != other.runtimeType) {
      return false;
    }
    final l$team = team;
    final lOther$team = other.team;
    if (l$team != lOther$team) {
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

extension UtilityExtension$Query$TeamRoster on Query$TeamRoster {
  CopyWith$Query$TeamRoster<Query$TeamRoster> get copyWith =>
      CopyWith$Query$TeamRoster(this, (i) => i);
}

abstract class CopyWith$Query$TeamRoster<TRes> {
  factory CopyWith$Query$TeamRoster(
    Query$TeamRoster instance,
    TRes Function(Query$TeamRoster) then,
  ) = _CopyWithImpl$Query$TeamRoster;

  factory CopyWith$Query$TeamRoster.stub(TRes res) =
      _CopyWithStubImpl$Query$TeamRoster;

  TRes call({Query$TeamRoster$team? team, String? $__typename});
  CopyWith$Query$TeamRoster$team<TRes> get team;
}

class _CopyWithImpl$Query$TeamRoster<TRes>
    implements CopyWith$Query$TeamRoster<TRes> {
  _CopyWithImpl$Query$TeamRoster(this._instance, this._then);

  final Query$TeamRoster _instance;

  final TRes Function(Query$TeamRoster) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? team = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Query$TeamRoster(
          team: team == _undefined || team == null
              ? _instance.team
              : (team as Query$TeamRoster$team),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
        ),
      );

  CopyWith$Query$TeamRoster$team<TRes> get team {
    final local$team = _instance.team;
    return CopyWith$Query$TeamRoster$team(local$team, (e) => call(team: e));
  }
}

class _CopyWithStubImpl$Query$TeamRoster<TRes>
    implements CopyWith$Query$TeamRoster<TRes> {
  _CopyWithStubImpl$Query$TeamRoster(this._res);

  TRes _res;

  call({Query$TeamRoster$team? team, String? $__typename}) => _res;

  CopyWith$Query$TeamRoster$team<TRes> get team =>
      CopyWith$Query$TeamRoster$team.stub(_res);
}

const documentNodeQueryTeamRoster = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'TeamRoster'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'id')),
          type: NamedTypeNode(name: NameNode(value: 'ID'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'team'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'id'),
                value: VariableNode(name: NameNode(value: 'id')),
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
                  name: NameNode(value: 'name'),
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
                  name: NameNode(value: 'color'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'players'),
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
                        name: NameNode(value: 'personId'),
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
                        name: NameNode(value: 'jerseyNumber'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'position'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'availability'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'availabilityNote'),
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
                        name: NameNode(value: 'guardians'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(
                          selections: [
                            FieldNode(
                              name: NameNode(value: 'personId'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null,
                            ),
                            FieldNode(
                              name: NameNode(value: 'name'),
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
                  name: NameNode(value: 'staff'),
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
                        name: NameNode(value: 'personId'),
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
                        name: NameNode(value: 'role'),
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
    ),
  ],
);

class Query$TeamRoster$team {
  Query$TeamRoster$team({
    required this.id,
    required this.name,
    required this.seasonName,
    this.color,
    required this.players,
    required this.staff,
    this.$__typename = 'TeamDetail',
  });

  factory Query$TeamRoster$team.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$seasonName = json['seasonName'];
    final l$color = json['color'];
    final l$players = json['players'];
    final l$staff = json['staff'];
    final l$$__typename = json['__typename'];
    return Query$TeamRoster$team(
      id: (l$id as String),
      name: (l$name as String),
      seasonName: (l$seasonName as String),
      color: (l$color as String?),
      players: (l$players as List<dynamic>)
          .map(
            (e) => Query$TeamRoster$team$players.fromJson(
              (e as Map<String, dynamic>),
            ),
          )
          .toList(),
      staff: (l$staff as List<dynamic>)
          .map(
            (e) => Query$TeamRoster$team$staff.fromJson(
              (e as Map<String, dynamic>),
            ),
          )
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String name;

  final String seasonName;

  final String? color;

  final List<Query$TeamRoster$team$players> players;

  final List<Query$TeamRoster$team$staff> staff;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$seasonName = seasonName;
    _resultData['seasonName'] = l$seasonName;
    final l$color = color;
    _resultData['color'] = l$color;
    final l$players = players;
    _resultData['players'] = l$players.map((e) => e.toJson()).toList();
    final l$staff = staff;
    _resultData['staff'] = l$staff.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$name = name;
    final l$seasonName = seasonName;
    final l$color = color;
    final l$players = players;
    final l$staff = staff;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$name,
      l$seasonName,
      l$color,
      Object.hashAll(l$players.map((v) => v)),
      Object.hashAll(l$staff.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$TeamRoster$team || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$seasonName = seasonName;
    final lOther$seasonName = other.seasonName;
    if (l$seasonName != lOther$seasonName) {
      return false;
    }
    final l$color = color;
    final lOther$color = other.color;
    if (l$color != lOther$color) {
      return false;
    }
    final l$players = players;
    final lOther$players = other.players;
    if (l$players.length != lOther$players.length) {
      return false;
    }
    for (int i = 0; i < l$players.length; i++) {
      final l$players$entry = l$players[i];
      final lOther$players$entry = lOther$players[i];
      if (l$players$entry != lOther$players$entry) {
        return false;
      }
    }
    final l$staff = staff;
    final lOther$staff = other.staff;
    if (l$staff.length != lOther$staff.length) {
      return false;
    }
    for (int i = 0; i < l$staff.length; i++) {
      final l$staff$entry = l$staff[i];
      final lOther$staff$entry = lOther$staff[i];
      if (l$staff$entry != lOther$staff$entry) {
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

extension UtilityExtension$Query$TeamRoster$team on Query$TeamRoster$team {
  CopyWith$Query$TeamRoster$team<Query$TeamRoster$team> get copyWith =>
      CopyWith$Query$TeamRoster$team(this, (i) => i);
}

abstract class CopyWith$Query$TeamRoster$team<TRes> {
  factory CopyWith$Query$TeamRoster$team(
    Query$TeamRoster$team instance,
    TRes Function(Query$TeamRoster$team) then,
  ) = _CopyWithImpl$Query$TeamRoster$team;

  factory CopyWith$Query$TeamRoster$team.stub(TRes res) =
      _CopyWithStubImpl$Query$TeamRoster$team;

  TRes call({
    String? id,
    String? name,
    String? seasonName,
    String? color,
    List<Query$TeamRoster$team$players>? players,
    List<Query$TeamRoster$team$staff>? staff,
    String? $__typename,
  });
  TRes players(
    Iterable<Query$TeamRoster$team$players> Function(
      Iterable<
        CopyWith$Query$TeamRoster$team$players<Query$TeamRoster$team$players>
      >,
    )
    _fn,
  );
  TRes staff(
    Iterable<Query$TeamRoster$team$staff> Function(
      Iterable<
        CopyWith$Query$TeamRoster$team$staff<Query$TeamRoster$team$staff>
      >,
    )
    _fn,
  );
}

class _CopyWithImpl$Query$TeamRoster$team<TRes>
    implements CopyWith$Query$TeamRoster$team<TRes> {
  _CopyWithImpl$Query$TeamRoster$team(this._instance, this._then);

  final Query$TeamRoster$team _instance;

  final TRes Function(Query$TeamRoster$team) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? name = _undefined,
    Object? seasonName = _undefined,
    Object? color = _undefined,
    Object? players = _undefined,
    Object? staff = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$TeamRoster$team(
      id: id == _undefined || id == null ? _instance.id : (id as String),
      name: name == _undefined || name == null
          ? _instance.name
          : (name as String),
      seasonName: seasonName == _undefined || seasonName == null
          ? _instance.seasonName
          : (seasonName as String),
      color: color == _undefined ? _instance.color : (color as String?),
      players: players == _undefined || players == null
          ? _instance.players
          : (players as List<Query$TeamRoster$team$players>),
      staff: staff == _undefined || staff == null
          ? _instance.staff
          : (staff as List<Query$TeamRoster$team$staff>),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  TRes players(
    Iterable<Query$TeamRoster$team$players> Function(
      Iterable<
        CopyWith$Query$TeamRoster$team$players<Query$TeamRoster$team$players>
      >,
    )
    _fn,
  ) => call(
    players: _fn(
      _instance.players.map(
        (e) => CopyWith$Query$TeamRoster$team$players(e, (i) => i),
      ),
    ).toList(),
  );

  TRes staff(
    Iterable<Query$TeamRoster$team$staff> Function(
      Iterable<
        CopyWith$Query$TeamRoster$team$staff<Query$TeamRoster$team$staff>
      >,
    )
    _fn,
  ) => call(
    staff: _fn(
      _instance.staff.map(
        (e) => CopyWith$Query$TeamRoster$team$staff(e, (i) => i),
      ),
    ).toList(),
  );
}

class _CopyWithStubImpl$Query$TeamRoster$team<TRes>
    implements CopyWith$Query$TeamRoster$team<TRes> {
  _CopyWithStubImpl$Query$TeamRoster$team(this._res);

  TRes _res;

  call({
    String? id,
    String? name,
    String? seasonName,
    String? color,
    List<Query$TeamRoster$team$players>? players,
    List<Query$TeamRoster$team$staff>? staff,
    String? $__typename,
  }) => _res;

  players(_fn) => _res;

  staff(_fn) => _res;
}

class Query$TeamRoster$team$players {
  Query$TeamRoster$team$players({
    required this.id,
    required this.personId,
    required this.firstName,
    required this.lastName,
    this.birthDate,
    this.jerseyNumber,
    this.position,
    required this.availability,
    this.availabilityNote,
    this.email,
    this.phone,
    required this.guardians,
    this.$__typename = 'RosterPlayer',
  });

  factory Query$TeamRoster$team$players.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$personId = json['personId'];
    final l$firstName = json['firstName'];
    final l$lastName = json['lastName'];
    final l$birthDate = json['birthDate'];
    final l$jerseyNumber = json['jerseyNumber'];
    final l$position = json['position'];
    final l$availability = json['availability'];
    final l$availabilityNote = json['availabilityNote'];
    final l$email = json['email'];
    final l$phone = json['phone'];
    final l$guardians = json['guardians'];
    final l$$__typename = json['__typename'];
    return Query$TeamRoster$team$players(
      id: (l$id as String),
      personId: (l$personId as String),
      firstName: (l$firstName as String),
      lastName: (l$lastName as String),
      birthDate: (l$birthDate as String?),
      jerseyNumber: (l$jerseyNumber as int?),
      position: (l$position as String?),
      availability: fromJson$Enum$PlayerAvailability(
        (l$availability as String),
      ),
      availabilityNote: (l$availabilityNote as String?),
      email: (l$email as String?),
      phone: (l$phone as String?),
      guardians: (l$guardians as List<dynamic>)
          .map(
            (e) => Query$TeamRoster$team$players$guardians.fromJson(
              (e as Map<String, dynamic>),
            ),
          )
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String personId;

  final String firstName;

  final String lastName;

  final String? birthDate;

  final int? jerseyNumber;

  final String? position;

  final Enum$PlayerAvailability availability;

  final String? availabilityNote;

  final String? email;

  final String? phone;

  final List<Query$TeamRoster$team$players$guardians> guardians;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$personId = personId;
    _resultData['personId'] = l$personId;
    final l$firstName = firstName;
    _resultData['firstName'] = l$firstName;
    final l$lastName = lastName;
    _resultData['lastName'] = l$lastName;
    final l$birthDate = birthDate;
    _resultData['birthDate'] = l$birthDate;
    final l$jerseyNumber = jerseyNumber;
    _resultData['jerseyNumber'] = l$jerseyNumber;
    final l$position = position;
    _resultData['position'] = l$position;
    final l$availability = availability;
    _resultData['availability'] = toJson$Enum$PlayerAvailability(
      l$availability,
    );
    final l$availabilityNote = availabilityNote;
    _resultData['availabilityNote'] = l$availabilityNote;
    final l$email = email;
    _resultData['email'] = l$email;
    final l$phone = phone;
    _resultData['phone'] = l$phone;
    final l$guardians = guardians;
    _resultData['guardians'] = l$guardians.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$personId = personId;
    final l$firstName = firstName;
    final l$lastName = lastName;
    final l$birthDate = birthDate;
    final l$jerseyNumber = jerseyNumber;
    final l$position = position;
    final l$availability = availability;
    final l$availabilityNote = availabilityNote;
    final l$email = email;
    final l$phone = phone;
    final l$guardians = guardians;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$personId,
      l$firstName,
      l$lastName,
      l$birthDate,
      l$jerseyNumber,
      l$position,
      l$availability,
      l$availabilityNote,
      l$email,
      l$phone,
      Object.hashAll(l$guardians.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$TeamRoster$team$players ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$personId = personId;
    final lOther$personId = other.personId;
    if (l$personId != lOther$personId) {
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
    final l$jerseyNumber = jerseyNumber;
    final lOther$jerseyNumber = other.jerseyNumber;
    if (l$jerseyNumber != lOther$jerseyNumber) {
      return false;
    }
    final l$position = position;
    final lOther$position = other.position;
    if (l$position != lOther$position) {
      return false;
    }
    final l$availability = availability;
    final lOther$availability = other.availability;
    if (l$availability != lOther$availability) {
      return false;
    }
    final l$availabilityNote = availabilityNote;
    final lOther$availabilityNote = other.availabilityNote;
    if (l$availabilityNote != lOther$availabilityNote) {
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

extension UtilityExtension$Query$TeamRoster$team$players
    on Query$TeamRoster$team$players {
  CopyWith$Query$TeamRoster$team$players<Query$TeamRoster$team$players>
  get copyWith => CopyWith$Query$TeamRoster$team$players(this, (i) => i);
}

abstract class CopyWith$Query$TeamRoster$team$players<TRes> {
  factory CopyWith$Query$TeamRoster$team$players(
    Query$TeamRoster$team$players instance,
    TRes Function(Query$TeamRoster$team$players) then,
  ) = _CopyWithImpl$Query$TeamRoster$team$players;

  factory CopyWith$Query$TeamRoster$team$players.stub(TRes res) =
      _CopyWithStubImpl$Query$TeamRoster$team$players;

  TRes call({
    String? id,
    String? personId,
    String? firstName,
    String? lastName,
    String? birthDate,
    int? jerseyNumber,
    String? position,
    Enum$PlayerAvailability? availability,
    String? availabilityNote,
    String? email,
    String? phone,
    List<Query$TeamRoster$team$players$guardians>? guardians,
    String? $__typename,
  });
  TRes guardians(
    Iterable<Query$TeamRoster$team$players$guardians> Function(
      Iterable<
        CopyWith$Query$TeamRoster$team$players$guardians<
          Query$TeamRoster$team$players$guardians
        >
      >,
    )
    _fn,
  );
}

class _CopyWithImpl$Query$TeamRoster$team$players<TRes>
    implements CopyWith$Query$TeamRoster$team$players<TRes> {
  _CopyWithImpl$Query$TeamRoster$team$players(this._instance, this._then);

  final Query$TeamRoster$team$players _instance;

  final TRes Function(Query$TeamRoster$team$players) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? personId = _undefined,
    Object? firstName = _undefined,
    Object? lastName = _undefined,
    Object? birthDate = _undefined,
    Object? jerseyNumber = _undefined,
    Object? position = _undefined,
    Object? availability = _undefined,
    Object? availabilityNote = _undefined,
    Object? email = _undefined,
    Object? phone = _undefined,
    Object? guardians = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$TeamRoster$team$players(
      id: id == _undefined || id == null ? _instance.id : (id as String),
      personId: personId == _undefined || personId == null
          ? _instance.personId
          : (personId as String),
      firstName: firstName == _undefined || firstName == null
          ? _instance.firstName
          : (firstName as String),
      lastName: lastName == _undefined || lastName == null
          ? _instance.lastName
          : (lastName as String),
      birthDate: birthDate == _undefined
          ? _instance.birthDate
          : (birthDate as String?),
      jerseyNumber: jerseyNumber == _undefined
          ? _instance.jerseyNumber
          : (jerseyNumber as int?),
      position: position == _undefined
          ? _instance.position
          : (position as String?),
      availability: availability == _undefined || availability == null
          ? _instance.availability
          : (availability as Enum$PlayerAvailability),
      availabilityNote: availabilityNote == _undefined
          ? _instance.availabilityNote
          : (availabilityNote as String?),
      email: email == _undefined ? _instance.email : (email as String?),
      phone: phone == _undefined ? _instance.phone : (phone as String?),
      guardians: guardians == _undefined || guardians == null
          ? _instance.guardians
          : (guardians as List<Query$TeamRoster$team$players$guardians>),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  TRes guardians(
    Iterable<Query$TeamRoster$team$players$guardians> Function(
      Iterable<
        CopyWith$Query$TeamRoster$team$players$guardians<
          Query$TeamRoster$team$players$guardians
        >
      >,
    )
    _fn,
  ) => call(
    guardians: _fn(
      _instance.guardians.map(
        (e) => CopyWith$Query$TeamRoster$team$players$guardians(e, (i) => i),
      ),
    ).toList(),
  );
}

class _CopyWithStubImpl$Query$TeamRoster$team$players<TRes>
    implements CopyWith$Query$TeamRoster$team$players<TRes> {
  _CopyWithStubImpl$Query$TeamRoster$team$players(this._res);

  TRes _res;

  call({
    String? id,
    String? personId,
    String? firstName,
    String? lastName,
    String? birthDate,
    int? jerseyNumber,
    String? position,
    Enum$PlayerAvailability? availability,
    String? availabilityNote,
    String? email,
    String? phone,
    List<Query$TeamRoster$team$players$guardians>? guardians,
    String? $__typename,
  }) => _res;

  guardians(_fn) => _res;
}

class Query$TeamRoster$team$players$guardians {
  Query$TeamRoster$team$players$guardians({
    required this.personId,
    required this.name,
    required this.relation,
    this.email,
    this.phone,
    this.$__typename = 'GuardianContact',
  });

  factory Query$TeamRoster$team$players$guardians.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$personId = json['personId'];
    final l$name = json['name'];
    final l$relation = json['relation'];
    final l$email = json['email'];
    final l$phone = json['phone'];
    final l$$__typename = json['__typename'];
    return Query$TeamRoster$team$players$guardians(
      personId: (l$personId as String),
      name: (l$name as String),
      relation: fromJson$Enum$GuardianRelation((l$relation as String)),
      email: (l$email as String?),
      phone: (l$phone as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String personId;

  final String name;

  final Enum$GuardianRelation relation;

  final String? email;

  final String? phone;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$personId = personId;
    _resultData['personId'] = l$personId;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$relation = relation;
    _resultData['relation'] = toJson$Enum$GuardianRelation(l$relation);
    final l$email = email;
    _resultData['email'] = l$email;
    final l$phone = phone;
    _resultData['phone'] = l$phone;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$personId = personId;
    final l$name = name;
    final l$relation = relation;
    final l$email = email;
    final l$phone = phone;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$personId,
      l$name,
      l$relation,
      l$email,
      l$phone,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$TeamRoster$team$players$guardians ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$personId = personId;
    final lOther$personId = other.personId;
    if (l$personId != lOther$personId) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$relation = relation;
    final lOther$relation = other.relation;
    if (l$relation != lOther$relation) {
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
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$TeamRoster$team$players$guardians
    on Query$TeamRoster$team$players$guardians {
  CopyWith$Query$TeamRoster$team$players$guardians<
    Query$TeamRoster$team$players$guardians
  >
  get copyWith =>
      CopyWith$Query$TeamRoster$team$players$guardians(this, (i) => i);
}

abstract class CopyWith$Query$TeamRoster$team$players$guardians<TRes> {
  factory CopyWith$Query$TeamRoster$team$players$guardians(
    Query$TeamRoster$team$players$guardians instance,
    TRes Function(Query$TeamRoster$team$players$guardians) then,
  ) = _CopyWithImpl$Query$TeamRoster$team$players$guardians;

  factory CopyWith$Query$TeamRoster$team$players$guardians.stub(TRes res) =
      _CopyWithStubImpl$Query$TeamRoster$team$players$guardians;

  TRes call({
    String? personId,
    String? name,
    Enum$GuardianRelation? relation,
    String? email,
    String? phone,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$TeamRoster$team$players$guardians<TRes>
    implements CopyWith$Query$TeamRoster$team$players$guardians<TRes> {
  _CopyWithImpl$Query$TeamRoster$team$players$guardians(
    this._instance,
    this._then,
  );

  final Query$TeamRoster$team$players$guardians _instance;

  final TRes Function(Query$TeamRoster$team$players$guardians) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? personId = _undefined,
    Object? name = _undefined,
    Object? relation = _undefined,
    Object? email = _undefined,
    Object? phone = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$TeamRoster$team$players$guardians(
      personId: personId == _undefined || personId == null
          ? _instance.personId
          : (personId as String),
      name: name == _undefined || name == null
          ? _instance.name
          : (name as String),
      relation: relation == _undefined || relation == null
          ? _instance.relation
          : (relation as Enum$GuardianRelation),
      email: email == _undefined ? _instance.email : (email as String?),
      phone: phone == _undefined ? _instance.phone : (phone as String?),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$TeamRoster$team$players$guardians<TRes>
    implements CopyWith$Query$TeamRoster$team$players$guardians<TRes> {
  _CopyWithStubImpl$Query$TeamRoster$team$players$guardians(this._res);

  TRes _res;

  call({
    String? personId,
    String? name,
    Enum$GuardianRelation? relation,
    String? email,
    String? phone,
    String? $__typename,
  }) => _res;
}

class Query$TeamRoster$team$staff {
  Query$TeamRoster$team$staff({
    required this.id,
    required this.personId,
    required this.firstName,
    required this.lastName,
    required this.role,
    this.email,
    this.phone,
    this.$__typename = 'RosterStaff',
  });

  factory Query$TeamRoster$team$staff.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$personId = json['personId'];
    final l$firstName = json['firstName'];
    final l$lastName = json['lastName'];
    final l$role = json['role'];
    final l$email = json['email'];
    final l$phone = json['phone'];
    final l$$__typename = json['__typename'];
    return Query$TeamRoster$team$staff(
      id: (l$id as String),
      personId: (l$personId as String),
      firstName: (l$firstName as String),
      lastName: (l$lastName as String),
      role: fromJson$Enum$StaffRole((l$role as String)),
      email: (l$email as String?),
      phone: (l$phone as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String personId;

  final String firstName;

  final String lastName;

  final Enum$StaffRole role;

  final String? email;

  final String? phone;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$personId = personId;
    _resultData['personId'] = l$personId;
    final l$firstName = firstName;
    _resultData['firstName'] = l$firstName;
    final l$lastName = lastName;
    _resultData['lastName'] = l$lastName;
    final l$role = role;
    _resultData['role'] = toJson$Enum$StaffRole(l$role);
    final l$email = email;
    _resultData['email'] = l$email;
    final l$phone = phone;
    _resultData['phone'] = l$phone;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$personId = personId;
    final l$firstName = firstName;
    final l$lastName = lastName;
    final l$role = role;
    final l$email = email;
    final l$phone = phone;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$personId,
      l$firstName,
      l$lastName,
      l$role,
      l$email,
      l$phone,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$TeamRoster$team$staff ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$personId = personId;
    final lOther$personId = other.personId;
    if (l$personId != lOther$personId) {
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
    final l$role = role;
    final lOther$role = other.role;
    if (l$role != lOther$role) {
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
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$TeamRoster$team$staff
    on Query$TeamRoster$team$staff {
  CopyWith$Query$TeamRoster$team$staff<Query$TeamRoster$team$staff>
  get copyWith => CopyWith$Query$TeamRoster$team$staff(this, (i) => i);
}

abstract class CopyWith$Query$TeamRoster$team$staff<TRes> {
  factory CopyWith$Query$TeamRoster$team$staff(
    Query$TeamRoster$team$staff instance,
    TRes Function(Query$TeamRoster$team$staff) then,
  ) = _CopyWithImpl$Query$TeamRoster$team$staff;

  factory CopyWith$Query$TeamRoster$team$staff.stub(TRes res) =
      _CopyWithStubImpl$Query$TeamRoster$team$staff;

  TRes call({
    String? id,
    String? personId,
    String? firstName,
    String? lastName,
    Enum$StaffRole? role,
    String? email,
    String? phone,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$TeamRoster$team$staff<TRes>
    implements CopyWith$Query$TeamRoster$team$staff<TRes> {
  _CopyWithImpl$Query$TeamRoster$team$staff(this._instance, this._then);

  final Query$TeamRoster$team$staff _instance;

  final TRes Function(Query$TeamRoster$team$staff) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? personId = _undefined,
    Object? firstName = _undefined,
    Object? lastName = _undefined,
    Object? role = _undefined,
    Object? email = _undefined,
    Object? phone = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$TeamRoster$team$staff(
      id: id == _undefined || id == null ? _instance.id : (id as String),
      personId: personId == _undefined || personId == null
          ? _instance.personId
          : (personId as String),
      firstName: firstName == _undefined || firstName == null
          ? _instance.firstName
          : (firstName as String),
      lastName: lastName == _undefined || lastName == null
          ? _instance.lastName
          : (lastName as String),
      role: role == _undefined || role == null
          ? _instance.role
          : (role as Enum$StaffRole),
      email: email == _undefined ? _instance.email : (email as String?),
      phone: phone == _undefined ? _instance.phone : (phone as String?),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$TeamRoster$team$staff<TRes>
    implements CopyWith$Query$TeamRoster$team$staff<TRes> {
  _CopyWithStubImpl$Query$TeamRoster$team$staff(this._res);

  TRes _res;

  call({
    String? id,
    String? personId,
    String? firstName,
    String? lastName,
    Enum$StaffRole? role,
    String? email,
    String? phone,
    String? $__typename,
  }) => _res;
}
