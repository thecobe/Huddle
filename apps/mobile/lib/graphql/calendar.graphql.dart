import 'package:gql/ast.dart';

import 'schema.graphql.dart';

class Fragment$AgendaEvent {
  Fragment$AgendaEvent({
    required this.id,
    this.teamId,
    this.teamName,
    this.teamColor,
    required this.kind,
    this.title,
    required this.startsAt,
    required this.endsAt,
    this.location,
    this.notes,
    required this.status,
    this.cancelReason,
    this.opponent,
    this.isHome,
    this.competition,
    required this.canEdit,
    this.$__typename = 'CalendarEvent',
  });

  factory Fragment$AgendaEvent.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$teamId = json['teamId'];
    final l$teamName = json['teamName'];
    final l$teamColor = json['teamColor'];
    final l$kind = json['kind'];
    final l$title = json['title'];
    final l$startsAt = json['startsAt'];
    final l$endsAt = json['endsAt'];
    final l$location = json['location'];
    final l$notes = json['notes'];
    final l$status = json['status'];
    final l$cancelReason = json['cancelReason'];
    final l$opponent = json['opponent'];
    final l$isHome = json['isHome'];
    final l$competition = json['competition'];
    final l$canEdit = json['canEdit'];
    final l$$__typename = json['__typename'];
    return Fragment$AgendaEvent(
      id: (l$id as String),
      teamId: (l$teamId as String?),
      teamName: (l$teamName as String?),
      teamColor: (l$teamColor as String?),
      kind: fromJson$Enum$EventKind((l$kind as String)),
      title: (l$title as String?),
      startsAt: (l$startsAt as String),
      endsAt: (l$endsAt as String),
      location: (l$location as String?),
      notes: (l$notes as String?),
      status: fromJson$Enum$EventStatus((l$status as String)),
      cancelReason: (l$cancelReason as String?),
      opponent: (l$opponent as String?),
      isHome: (l$isHome as bool?),
      competition: (l$competition as String?),
      canEdit: (l$canEdit as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String? teamId;

  final String? teamName;

  final String? teamColor;

  final Enum$EventKind kind;

  final String? title;

  final String startsAt;

  final String endsAt;

  final String? location;

  final String? notes;

  final Enum$EventStatus status;

  final String? cancelReason;

  final String? opponent;

  final bool? isHome;

  final String? competition;

  final bool canEdit;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$teamId = teamId;
    _resultData['teamId'] = l$teamId;
    final l$teamName = teamName;
    _resultData['teamName'] = l$teamName;
    final l$teamColor = teamColor;
    _resultData['teamColor'] = l$teamColor;
    final l$kind = kind;
    _resultData['kind'] = toJson$Enum$EventKind(l$kind);
    final l$title = title;
    _resultData['title'] = l$title;
    final l$startsAt = startsAt;
    _resultData['startsAt'] = l$startsAt;
    final l$endsAt = endsAt;
    _resultData['endsAt'] = l$endsAt;
    final l$location = location;
    _resultData['location'] = l$location;
    final l$notes = notes;
    _resultData['notes'] = l$notes;
    final l$status = status;
    _resultData['status'] = toJson$Enum$EventStatus(l$status);
    final l$cancelReason = cancelReason;
    _resultData['cancelReason'] = l$cancelReason;
    final l$opponent = opponent;
    _resultData['opponent'] = l$opponent;
    final l$isHome = isHome;
    _resultData['isHome'] = l$isHome;
    final l$competition = competition;
    _resultData['competition'] = l$competition;
    final l$canEdit = canEdit;
    _resultData['canEdit'] = l$canEdit;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$teamId = teamId;
    final l$teamName = teamName;
    final l$teamColor = teamColor;
    final l$kind = kind;
    final l$title = title;
    final l$startsAt = startsAt;
    final l$endsAt = endsAt;
    final l$location = location;
    final l$notes = notes;
    final l$status = status;
    final l$cancelReason = cancelReason;
    final l$opponent = opponent;
    final l$isHome = isHome;
    final l$competition = competition;
    final l$canEdit = canEdit;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$teamId,
      l$teamName,
      l$teamColor,
      l$kind,
      l$title,
      l$startsAt,
      l$endsAt,
      l$location,
      l$notes,
      l$status,
      l$cancelReason,
      l$opponent,
      l$isHome,
      l$competition,
      l$canEdit,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$AgendaEvent || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
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
    final l$teamColor = teamColor;
    final lOther$teamColor = other.teamColor;
    if (l$teamColor != lOther$teamColor) {
      return false;
    }
    final l$kind = kind;
    final lOther$kind = other.kind;
    if (l$kind != lOther$kind) {
      return false;
    }
    final l$title = title;
    final lOther$title = other.title;
    if (l$title != lOther$title) {
      return false;
    }
    final l$startsAt = startsAt;
    final lOther$startsAt = other.startsAt;
    if (l$startsAt != lOther$startsAt) {
      return false;
    }
    final l$endsAt = endsAt;
    final lOther$endsAt = other.endsAt;
    if (l$endsAt != lOther$endsAt) {
      return false;
    }
    final l$location = location;
    final lOther$location = other.location;
    if (l$location != lOther$location) {
      return false;
    }
    final l$notes = notes;
    final lOther$notes = other.notes;
    if (l$notes != lOther$notes) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) {
      return false;
    }
    final l$cancelReason = cancelReason;
    final lOther$cancelReason = other.cancelReason;
    if (l$cancelReason != lOther$cancelReason) {
      return false;
    }
    final l$opponent = opponent;
    final lOther$opponent = other.opponent;
    if (l$opponent != lOther$opponent) {
      return false;
    }
    final l$isHome = isHome;
    final lOther$isHome = other.isHome;
    if (l$isHome != lOther$isHome) {
      return false;
    }
    final l$competition = competition;
    final lOther$competition = other.competition;
    if (l$competition != lOther$competition) {
      return false;
    }
    final l$canEdit = canEdit;
    final lOther$canEdit = other.canEdit;
    if (l$canEdit != lOther$canEdit) {
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

extension UtilityExtension$Fragment$AgendaEvent on Fragment$AgendaEvent {
  CopyWith$Fragment$AgendaEvent<Fragment$AgendaEvent> get copyWith =>
      CopyWith$Fragment$AgendaEvent(this, (i) => i);
}

abstract class CopyWith$Fragment$AgendaEvent<TRes> {
  factory CopyWith$Fragment$AgendaEvent(
    Fragment$AgendaEvent instance,
    TRes Function(Fragment$AgendaEvent) then,
  ) = _CopyWithImpl$Fragment$AgendaEvent;

  factory CopyWith$Fragment$AgendaEvent.stub(TRes res) =
      _CopyWithStubImpl$Fragment$AgendaEvent;

  TRes call({
    String? id,
    String? teamId,
    String? teamName,
    String? teamColor,
    Enum$EventKind? kind,
    String? title,
    String? startsAt,
    String? endsAt,
    String? location,
    String? notes,
    Enum$EventStatus? status,
    String? cancelReason,
    String? opponent,
    bool? isHome,
    String? competition,
    bool? canEdit,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$AgendaEvent<TRes>
    implements CopyWith$Fragment$AgendaEvent<TRes> {
  _CopyWithImpl$Fragment$AgendaEvent(this._instance, this._then);

  final Fragment$AgendaEvent _instance;

  final TRes Function(Fragment$AgendaEvent) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? teamId = _undefined,
    Object? teamName = _undefined,
    Object? teamColor = _undefined,
    Object? kind = _undefined,
    Object? title = _undefined,
    Object? startsAt = _undefined,
    Object? endsAt = _undefined,
    Object? location = _undefined,
    Object? notes = _undefined,
    Object? status = _undefined,
    Object? cancelReason = _undefined,
    Object? opponent = _undefined,
    Object? isHome = _undefined,
    Object? competition = _undefined,
    Object? canEdit = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$AgendaEvent(
      id: id == _undefined || id == null ? _instance.id : (id as String),
      teamId: teamId == _undefined ? _instance.teamId : (teamId as String?),
      teamName: teamName == _undefined
          ? _instance.teamName
          : (teamName as String?),
      teamColor: teamColor == _undefined
          ? _instance.teamColor
          : (teamColor as String?),
      kind: kind == _undefined || kind == null
          ? _instance.kind
          : (kind as Enum$EventKind),
      title: title == _undefined ? _instance.title : (title as String?),
      startsAt: startsAt == _undefined || startsAt == null
          ? _instance.startsAt
          : (startsAt as String),
      endsAt: endsAt == _undefined || endsAt == null
          ? _instance.endsAt
          : (endsAt as String),
      location: location == _undefined
          ? _instance.location
          : (location as String?),
      notes: notes == _undefined ? _instance.notes : (notes as String?),
      status: status == _undefined || status == null
          ? _instance.status
          : (status as Enum$EventStatus),
      cancelReason: cancelReason == _undefined
          ? _instance.cancelReason
          : (cancelReason as String?),
      opponent: opponent == _undefined
          ? _instance.opponent
          : (opponent as String?),
      isHome: isHome == _undefined ? _instance.isHome : (isHome as bool?),
      competition: competition == _undefined
          ? _instance.competition
          : (competition as String?),
      canEdit: canEdit == _undefined || canEdit == null
          ? _instance.canEdit
          : (canEdit as bool),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Fragment$AgendaEvent<TRes>
    implements CopyWith$Fragment$AgendaEvent<TRes> {
  _CopyWithStubImpl$Fragment$AgendaEvent(this._res);

  TRes _res;

  call({
    String? id,
    String? teamId,
    String? teamName,
    String? teamColor,
    Enum$EventKind? kind,
    String? title,
    String? startsAt,
    String? endsAt,
    String? location,
    String? notes,
    Enum$EventStatus? status,
    String? cancelReason,
    String? opponent,
    bool? isHome,
    String? competition,
    bool? canEdit,
    String? $__typename,
  }) => _res;
}

const fragmentDefinitionAgendaEvent = FragmentDefinitionNode(
  name: NameNode(value: 'AgendaEvent'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'CalendarEvent'), isNonNull: false),
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
        name: NameNode(value: 'teamColor'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'kind'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'title'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'startsAt'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'endsAt'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'location'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'notes'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'status'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'cancelReason'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'opponent'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'isHome'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'competition'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'canEdit'),
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
);
const documentNodeFragmentAgendaEvent = DocumentNode(
  definitions: [fragmentDefinitionAgendaEvent],
);

class Variables$Query$MyAgenda {
  factory Variables$Query$MyAgenda({
    required String from,
    required String to,
  }) => Variables$Query$MyAgenda._({r'from': from, r'to': to});

  Variables$Query$MyAgenda._(this._$data);

  factory Variables$Query$MyAgenda.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$from = data['from'];
    result$data['from'] = (l$from as String);
    final l$to = data['to'];
    result$data['to'] = (l$to as String);
    return Variables$Query$MyAgenda._(result$data);
  }

  Map<String, dynamic> _$data;

  String get from => (_$data['from'] as String);

  String get to => (_$data['to'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$from = from;
    result$data['from'] = l$from;
    final l$to = to;
    result$data['to'] = l$to;
    return result$data;
  }

  CopyWith$Variables$Query$MyAgenda<Variables$Query$MyAgenda> get copyWith =>
      CopyWith$Variables$Query$MyAgenda(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Query$MyAgenda ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$from = from;
    final lOther$from = other.from;
    if (l$from != lOther$from) {
      return false;
    }
    final l$to = to;
    final lOther$to = other.to;
    if (l$to != lOther$to) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$from = from;
    final l$to = to;
    return Object.hashAll([l$from, l$to]);
  }
}

abstract class CopyWith$Variables$Query$MyAgenda<TRes> {
  factory CopyWith$Variables$Query$MyAgenda(
    Variables$Query$MyAgenda instance,
    TRes Function(Variables$Query$MyAgenda) then,
  ) = _CopyWithImpl$Variables$Query$MyAgenda;

  factory CopyWith$Variables$Query$MyAgenda.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$MyAgenda;

  TRes call({String? from, String? to});
}

class _CopyWithImpl$Variables$Query$MyAgenda<TRes>
    implements CopyWith$Variables$Query$MyAgenda<TRes> {
  _CopyWithImpl$Variables$Query$MyAgenda(this._instance, this._then);

  final Variables$Query$MyAgenda _instance;

  final TRes Function(Variables$Query$MyAgenda) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? from = _undefined, Object? to = _undefined}) => _then(
    Variables$Query$MyAgenda._({
      ..._instance._$data,
      if (from != _undefined && from != null) 'from': (from as String),
      if (to != _undefined && to != null) 'to': (to as String),
    }),
  );
}

class _CopyWithStubImpl$Variables$Query$MyAgenda<TRes>
    implements CopyWith$Variables$Query$MyAgenda<TRes> {
  _CopyWithStubImpl$Variables$Query$MyAgenda(this._res);

  TRes _res;

  call({String? from, String? to}) => _res;
}

class Query$MyAgenda {
  Query$MyAgenda({required this.myAgenda, this.$__typename = 'Query'});

  factory Query$MyAgenda.fromJson(Map<String, dynamic> json) {
    final l$myAgenda = json['myAgenda'];
    final l$$__typename = json['__typename'];
    return Query$MyAgenda(
      myAgenda: (l$myAgenda as List<dynamic>)
          .map(
            (e) => Fragment$AgendaEvent.fromJson((e as Map<String, dynamic>)),
          )
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Fragment$AgendaEvent> myAgenda;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$myAgenda = myAgenda;
    _resultData['myAgenda'] = l$myAgenda.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$myAgenda = myAgenda;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$myAgenda.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$MyAgenda || runtimeType != other.runtimeType) {
      return false;
    }
    final l$myAgenda = myAgenda;
    final lOther$myAgenda = other.myAgenda;
    if (l$myAgenda.length != lOther$myAgenda.length) {
      return false;
    }
    for (int i = 0; i < l$myAgenda.length; i++) {
      final l$myAgenda$entry = l$myAgenda[i];
      final lOther$myAgenda$entry = lOther$myAgenda[i];
      if (l$myAgenda$entry != lOther$myAgenda$entry) {
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

extension UtilityExtension$Query$MyAgenda on Query$MyAgenda {
  CopyWith$Query$MyAgenda<Query$MyAgenda> get copyWith =>
      CopyWith$Query$MyAgenda(this, (i) => i);
}

abstract class CopyWith$Query$MyAgenda<TRes> {
  factory CopyWith$Query$MyAgenda(
    Query$MyAgenda instance,
    TRes Function(Query$MyAgenda) then,
  ) = _CopyWithImpl$Query$MyAgenda;

  factory CopyWith$Query$MyAgenda.stub(TRes res) =
      _CopyWithStubImpl$Query$MyAgenda;

  TRes call({List<Fragment$AgendaEvent>? myAgenda, String? $__typename});
  TRes myAgenda(
    Iterable<Fragment$AgendaEvent> Function(
      Iterable<CopyWith$Fragment$AgendaEvent<Fragment$AgendaEvent>>,
    )
    _fn,
  );
}

class _CopyWithImpl$Query$MyAgenda<TRes>
    implements CopyWith$Query$MyAgenda<TRes> {
  _CopyWithImpl$Query$MyAgenda(this._instance, this._then);

  final Query$MyAgenda _instance;

  final TRes Function(Query$MyAgenda) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? myAgenda = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$MyAgenda(
      myAgenda: myAgenda == _undefined || myAgenda == null
          ? _instance.myAgenda
          : (myAgenda as List<Fragment$AgendaEvent>),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  TRes myAgenda(
    Iterable<Fragment$AgendaEvent> Function(
      Iterable<CopyWith$Fragment$AgendaEvent<Fragment$AgendaEvent>>,
    )
    _fn,
  ) => call(
    myAgenda: _fn(
      _instance.myAgenda.map((e) => CopyWith$Fragment$AgendaEvent(e, (i) => i)),
    ).toList(),
  );
}

class _CopyWithStubImpl$Query$MyAgenda<TRes>
    implements CopyWith$Query$MyAgenda<TRes> {
  _CopyWithStubImpl$Query$MyAgenda(this._res);

  TRes _res;

  call({List<Fragment$AgendaEvent>? myAgenda, String? $__typename}) => _res;

  myAgenda(_fn) => _res;
}

const documentNodeQueryMyAgenda = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'MyAgenda'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'from')),
          type: NamedTypeNode(
            name: NameNode(value: 'DateTime'),
            isNonNull: true,
          ),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'to')),
          type: NamedTypeNode(
            name: NameNode(value: 'DateTime'),
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
            name: NameNode(value: 'myAgenda'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'from'),
                value: VariableNode(name: NameNode(value: 'from')),
              ),
              ArgumentNode(
                name: NameNode(value: 'to'),
                value: VariableNode(name: NameNode(value: 'to')),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FragmentSpreadNode(
                  name: NameNode(value: 'AgendaEvent'),
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
    fragmentDefinitionAgendaEvent,
  ],
);

class Variables$Query$EventDetail {
  factory Variables$Query$EventDetail({required String id}) =>
      Variables$Query$EventDetail._({r'id': id});

  Variables$Query$EventDetail._(this._$data);

  factory Variables$Query$EventDetail.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    return Variables$Query$EventDetail._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    return result$data;
  }

  CopyWith$Variables$Query$EventDetail<Variables$Query$EventDetail>
  get copyWith => CopyWith$Variables$Query$EventDetail(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Query$EventDetail ||
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

abstract class CopyWith$Variables$Query$EventDetail<TRes> {
  factory CopyWith$Variables$Query$EventDetail(
    Variables$Query$EventDetail instance,
    TRes Function(Variables$Query$EventDetail) then,
  ) = _CopyWithImpl$Variables$Query$EventDetail;

  factory CopyWith$Variables$Query$EventDetail.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$EventDetail;

  TRes call({String? id});
}

class _CopyWithImpl$Variables$Query$EventDetail<TRes>
    implements CopyWith$Variables$Query$EventDetail<TRes> {
  _CopyWithImpl$Variables$Query$EventDetail(this._instance, this._then);

  final Variables$Query$EventDetail _instance;

  final TRes Function(Variables$Query$EventDetail) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? id = _undefined}) => _then(
    Variables$Query$EventDetail._({
      ..._instance._$data,
      if (id != _undefined && id != null) 'id': (id as String),
    }),
  );
}

class _CopyWithStubImpl$Variables$Query$EventDetail<TRes>
    implements CopyWith$Variables$Query$EventDetail<TRes> {
  _CopyWithStubImpl$Variables$Query$EventDetail(this._res);

  TRes _res;

  call({String? id}) => _res;
}

class Query$EventDetail {
  Query$EventDetail({required this.event, this.$__typename = 'Query'});

  factory Query$EventDetail.fromJson(Map<String, dynamic> json) {
    final l$event = json['event'];
    final l$$__typename = json['__typename'];
    return Query$EventDetail(
      event: Fragment$AgendaEvent.fromJson((l$event as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$AgendaEvent event;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$event = event;
    _resultData['event'] = l$event.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$event = event;
    final l$$__typename = $__typename;
    return Object.hashAll([l$event, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$EventDetail || runtimeType != other.runtimeType) {
      return false;
    }
    final l$event = event;
    final lOther$event = other.event;
    if (l$event != lOther$event) {
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

extension UtilityExtension$Query$EventDetail on Query$EventDetail {
  CopyWith$Query$EventDetail<Query$EventDetail> get copyWith =>
      CopyWith$Query$EventDetail(this, (i) => i);
}

abstract class CopyWith$Query$EventDetail<TRes> {
  factory CopyWith$Query$EventDetail(
    Query$EventDetail instance,
    TRes Function(Query$EventDetail) then,
  ) = _CopyWithImpl$Query$EventDetail;

  factory CopyWith$Query$EventDetail.stub(TRes res) =
      _CopyWithStubImpl$Query$EventDetail;

  TRes call({Fragment$AgendaEvent? event, String? $__typename});
  CopyWith$Fragment$AgendaEvent<TRes> get event;
}

class _CopyWithImpl$Query$EventDetail<TRes>
    implements CopyWith$Query$EventDetail<TRes> {
  _CopyWithImpl$Query$EventDetail(this._instance, this._then);

  final Query$EventDetail _instance;

  final TRes Function(Query$EventDetail) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? event = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Query$EventDetail(
          event: event == _undefined || event == null
              ? _instance.event
              : (event as Fragment$AgendaEvent),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
        ),
      );

  CopyWith$Fragment$AgendaEvent<TRes> get event {
    final local$event = _instance.event;
    return CopyWith$Fragment$AgendaEvent(local$event, (e) => call(event: e));
  }
}

class _CopyWithStubImpl$Query$EventDetail<TRes>
    implements CopyWith$Query$EventDetail<TRes> {
  _CopyWithStubImpl$Query$EventDetail(this._res);

  TRes _res;

  call({Fragment$AgendaEvent? event, String? $__typename}) => _res;

  CopyWith$Fragment$AgendaEvent<TRes> get event =>
      CopyWith$Fragment$AgendaEvent.stub(_res);
}

const documentNodeQueryEventDetail = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'EventDetail'),
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
            name: NameNode(value: 'event'),
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
                FragmentSpreadNode(
                  name: NameNode(value: 'AgendaEvent'),
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
    fragmentDefinitionAgendaEvent,
  ],
);
