import 'package:gql/ast.dart';

import 'schema.graphql.dart';

class Fragment$ParticipationFields {
  Fragment$ParticipationFields({
    required this.personId,
    required this.firstName,
    required this.lastName,
    this.status,
    required this.canReport,
    this.absenceNotice,
    this.$__typename = 'Participation',
  });

  factory Fragment$ParticipationFields.fromJson(Map<String, dynamic> json) {
    final l$personId = json['personId'];
    final l$firstName = json['firstName'];
    final l$lastName = json['lastName'];
    final l$status = json['status'];
    final l$canReport = json['canReport'];
    final l$absenceNotice = json['absenceNotice'];
    final l$$__typename = json['__typename'];
    return Fragment$ParticipationFields(
      personId: (l$personId as String),
      firstName: (l$firstName as String),
      lastName: (l$lastName as String),
      status: l$status == null
          ? null
          : fromJson$Enum$AttendanceStatus((l$status as String)),
      canReport: (l$canReport as bool),
      absenceNotice: l$absenceNotice == null
          ? null
          : Fragment$ParticipationFields$absenceNotice.fromJson(
              (l$absenceNotice as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final String personId;

  final String firstName;

  final String lastName;

  final Enum$AttendanceStatus? status;

  final bool canReport;

  final Fragment$ParticipationFields$absenceNotice? absenceNotice;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$personId = personId;
    _resultData['personId'] = l$personId;
    final l$firstName = firstName;
    _resultData['firstName'] = l$firstName;
    final l$lastName = lastName;
    _resultData['lastName'] = l$lastName;
    final l$status = status;
    _resultData['status'] = l$status == null
        ? null
        : toJson$Enum$AttendanceStatus(l$status);
    final l$canReport = canReport;
    _resultData['canReport'] = l$canReport;
    final l$absenceNotice = absenceNotice;
    _resultData['absenceNotice'] = l$absenceNotice?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$personId = personId;
    final l$firstName = firstName;
    final l$lastName = lastName;
    final l$status = status;
    final l$canReport = canReport;
    final l$absenceNotice = absenceNotice;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$personId,
      l$firstName,
      l$lastName,
      l$status,
      l$canReport,
      l$absenceNotice,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$ParticipationFields ||
        runtimeType != other.runtimeType) {
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
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) {
      return false;
    }
    final l$canReport = canReport;
    final lOther$canReport = other.canReport;
    if (l$canReport != lOther$canReport) {
      return false;
    }
    final l$absenceNotice = absenceNotice;
    final lOther$absenceNotice = other.absenceNotice;
    if (l$absenceNotice != lOther$absenceNotice) {
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

extension UtilityExtension$Fragment$ParticipationFields
    on Fragment$ParticipationFields {
  CopyWith$Fragment$ParticipationFields<Fragment$ParticipationFields>
  get copyWith => CopyWith$Fragment$ParticipationFields(this, (i) => i);
}

abstract class CopyWith$Fragment$ParticipationFields<TRes> {
  factory CopyWith$Fragment$ParticipationFields(
    Fragment$ParticipationFields instance,
    TRes Function(Fragment$ParticipationFields) then,
  ) = _CopyWithImpl$Fragment$ParticipationFields;

  factory CopyWith$Fragment$ParticipationFields.stub(TRes res) =
      _CopyWithStubImpl$Fragment$ParticipationFields;

  TRes call({
    String? personId,
    String? firstName,
    String? lastName,
    Enum$AttendanceStatus? status,
    bool? canReport,
    Fragment$ParticipationFields$absenceNotice? absenceNotice,
    String? $__typename,
  });
  CopyWith$Fragment$ParticipationFields$absenceNotice<TRes> get absenceNotice;
}

class _CopyWithImpl$Fragment$ParticipationFields<TRes>
    implements CopyWith$Fragment$ParticipationFields<TRes> {
  _CopyWithImpl$Fragment$ParticipationFields(this._instance, this._then);

  final Fragment$ParticipationFields _instance;

  final TRes Function(Fragment$ParticipationFields) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? personId = _undefined,
    Object? firstName = _undefined,
    Object? lastName = _undefined,
    Object? status = _undefined,
    Object? canReport = _undefined,
    Object? absenceNotice = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$ParticipationFields(
      personId: personId == _undefined || personId == null
          ? _instance.personId
          : (personId as String),
      firstName: firstName == _undefined || firstName == null
          ? _instance.firstName
          : (firstName as String),
      lastName: lastName == _undefined || lastName == null
          ? _instance.lastName
          : (lastName as String),
      status: status == _undefined
          ? _instance.status
          : (status as Enum$AttendanceStatus?),
      canReport: canReport == _undefined || canReport == null
          ? _instance.canReport
          : (canReport as bool),
      absenceNotice: absenceNotice == _undefined
          ? _instance.absenceNotice
          : (absenceNotice as Fragment$ParticipationFields$absenceNotice?),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  CopyWith$Fragment$ParticipationFields$absenceNotice<TRes> get absenceNotice {
    final local$absenceNotice = _instance.absenceNotice;
    return local$absenceNotice == null
        ? CopyWith$Fragment$ParticipationFields$absenceNotice.stub(
            _then(_instance),
          )
        : CopyWith$Fragment$ParticipationFields$absenceNotice(
            local$absenceNotice,
            (e) => call(absenceNotice: e),
          );
  }
}

class _CopyWithStubImpl$Fragment$ParticipationFields<TRes>
    implements CopyWith$Fragment$ParticipationFields<TRes> {
  _CopyWithStubImpl$Fragment$ParticipationFields(this._res);

  TRes _res;

  call({
    String? personId,
    String? firstName,
    String? lastName,
    Enum$AttendanceStatus? status,
    bool? canReport,
    Fragment$ParticipationFields$absenceNotice? absenceNotice,
    String? $__typename,
  }) => _res;

  CopyWith$Fragment$ParticipationFields$absenceNotice<TRes> get absenceNotice =>
      CopyWith$Fragment$ParticipationFields$absenceNotice.stub(_res);
}

const fragmentDefinitionParticipationFields = FragmentDefinitionNode(
  name: NameNode(value: 'ParticipationFields'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'Participation'), isNonNull: false),
  ),
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
        name: NameNode(value: 'status'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'canReport'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'absenceNotice'),
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
              name: NameNode(value: 'reason'),
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
const documentNodeFragmentParticipationFields = DocumentNode(
  definitions: [fragmentDefinitionParticipationFields],
);

class Fragment$ParticipationFields$absenceNotice {
  Fragment$ParticipationFields$absenceNotice({
    required this.id,
    this.reason,
    this.$__typename = 'AbsenceNotice',
  });

  factory Fragment$ParticipationFields$absenceNotice.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$id = json['id'];
    final l$reason = json['reason'];
    final l$$__typename = json['__typename'];
    return Fragment$ParticipationFields$absenceNotice(
      id: (l$id as String),
      reason: (l$reason as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String? reason;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$reason = reason;
    _resultData['reason'] = l$reason;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$reason = reason;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$reason, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$ParticipationFields$absenceNotice ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$reason = reason;
    final lOther$reason = other.reason;
    if (l$reason != lOther$reason) {
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

extension UtilityExtension$Fragment$ParticipationFields$absenceNotice
    on Fragment$ParticipationFields$absenceNotice {
  CopyWith$Fragment$ParticipationFields$absenceNotice<
    Fragment$ParticipationFields$absenceNotice
  >
  get copyWith =>
      CopyWith$Fragment$ParticipationFields$absenceNotice(this, (i) => i);
}

abstract class CopyWith$Fragment$ParticipationFields$absenceNotice<TRes> {
  factory CopyWith$Fragment$ParticipationFields$absenceNotice(
    Fragment$ParticipationFields$absenceNotice instance,
    TRes Function(Fragment$ParticipationFields$absenceNotice) then,
  ) = _CopyWithImpl$Fragment$ParticipationFields$absenceNotice;

  factory CopyWith$Fragment$ParticipationFields$absenceNotice.stub(TRes res) =
      _CopyWithStubImpl$Fragment$ParticipationFields$absenceNotice;

  TRes call({String? id, String? reason, String? $__typename});
}

class _CopyWithImpl$Fragment$ParticipationFields$absenceNotice<TRes>
    implements CopyWith$Fragment$ParticipationFields$absenceNotice<TRes> {
  _CopyWithImpl$Fragment$ParticipationFields$absenceNotice(
    this._instance,
    this._then,
  );

  final Fragment$ParticipationFields$absenceNotice _instance;

  final TRes Function(Fragment$ParticipationFields$absenceNotice) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? reason = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$ParticipationFields$absenceNotice(
      id: id == _undefined || id == null ? _instance.id : (id as String),
      reason: reason == _undefined ? _instance.reason : (reason as String?),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Fragment$ParticipationFields$absenceNotice<TRes>
    implements CopyWith$Fragment$ParticipationFields$absenceNotice<TRes> {
  _CopyWithStubImpl$Fragment$ParticipationFields$absenceNotice(this._res);

  TRes _res;

  call({String? id, String? reason, String? $__typename}) => _res;
}

class Variables$Query$RollCall {
  factory Variables$Query$RollCall({required String eventId}) =>
      Variables$Query$RollCall._({r'eventId': eventId});

  Variables$Query$RollCall._(this._$data);

  factory Variables$Query$RollCall.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$eventId = data['eventId'];
    result$data['eventId'] = (l$eventId as String);
    return Variables$Query$RollCall._(result$data);
  }

  Map<String, dynamic> _$data;

  String get eventId => (_$data['eventId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$eventId = eventId;
    result$data['eventId'] = l$eventId;
    return result$data;
  }

  CopyWith$Variables$Query$RollCall<Variables$Query$RollCall> get copyWith =>
      CopyWith$Variables$Query$RollCall(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Query$RollCall ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$eventId = eventId;
    final lOther$eventId = other.eventId;
    if (l$eventId != lOther$eventId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$eventId = eventId;
    return Object.hashAll([l$eventId]);
  }
}

abstract class CopyWith$Variables$Query$RollCall<TRes> {
  factory CopyWith$Variables$Query$RollCall(
    Variables$Query$RollCall instance,
    TRes Function(Variables$Query$RollCall) then,
  ) = _CopyWithImpl$Variables$Query$RollCall;

  factory CopyWith$Variables$Query$RollCall.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$RollCall;

  TRes call({String? eventId});
}

class _CopyWithImpl$Variables$Query$RollCall<TRes>
    implements CopyWith$Variables$Query$RollCall<TRes> {
  _CopyWithImpl$Variables$Query$RollCall(this._instance, this._then);

  final Variables$Query$RollCall _instance;

  final TRes Function(Variables$Query$RollCall) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? eventId = _undefined}) => _then(
    Variables$Query$RollCall._({
      ..._instance._$data,
      if (eventId != _undefined && eventId != null)
        'eventId': (eventId as String),
    }),
  );
}

class _CopyWithStubImpl$Variables$Query$RollCall<TRes>
    implements CopyWith$Variables$Query$RollCall<TRes> {
  _CopyWithStubImpl$Variables$Query$RollCall(this._res);

  TRes _res;

  call({String? eventId}) => _res;
}

class Query$RollCall {
  Query$RollCall({required this.rollCall, this.$__typename = 'Query'});

  factory Query$RollCall.fromJson(Map<String, dynamic> json) {
    final l$rollCall = json['rollCall'];
    final l$$__typename = json['__typename'];
    return Query$RollCall(
      rollCall: Query$RollCall$rollCall.fromJson(
        (l$rollCall as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$RollCall$rollCall rollCall;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$rollCall = rollCall;
    _resultData['rollCall'] = l$rollCall.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$rollCall = rollCall;
    final l$$__typename = $__typename;
    return Object.hashAll([l$rollCall, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$RollCall || runtimeType != other.runtimeType) {
      return false;
    }
    final l$rollCall = rollCall;
    final lOther$rollCall = other.rollCall;
    if (l$rollCall != lOther$rollCall) {
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

extension UtilityExtension$Query$RollCall on Query$RollCall {
  CopyWith$Query$RollCall<Query$RollCall> get copyWith =>
      CopyWith$Query$RollCall(this, (i) => i);
}

abstract class CopyWith$Query$RollCall<TRes> {
  factory CopyWith$Query$RollCall(
    Query$RollCall instance,
    TRes Function(Query$RollCall) then,
  ) = _CopyWithImpl$Query$RollCall;

  factory CopyWith$Query$RollCall.stub(TRes res) =
      _CopyWithStubImpl$Query$RollCall;

  TRes call({Query$RollCall$rollCall? rollCall, String? $__typename});
  CopyWith$Query$RollCall$rollCall<TRes> get rollCall;
}

class _CopyWithImpl$Query$RollCall<TRes>
    implements CopyWith$Query$RollCall<TRes> {
  _CopyWithImpl$Query$RollCall(this._instance, this._then);

  final Query$RollCall _instance;

  final TRes Function(Query$RollCall) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? rollCall = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$RollCall(
      rollCall: rollCall == _undefined || rollCall == null
          ? _instance.rollCall
          : (rollCall as Query$RollCall$rollCall),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  CopyWith$Query$RollCall$rollCall<TRes> get rollCall {
    final local$rollCall = _instance.rollCall;
    return CopyWith$Query$RollCall$rollCall(
      local$rollCall,
      (e) => call(rollCall: e),
    );
  }
}

class _CopyWithStubImpl$Query$RollCall<TRes>
    implements CopyWith$Query$RollCall<TRes> {
  _CopyWithStubImpl$Query$RollCall(this._res);

  TRes _res;

  call({Query$RollCall$rollCall? rollCall, String? $__typename}) => _res;

  CopyWith$Query$RollCall$rollCall<TRes> get rollCall =>
      CopyWith$Query$RollCall$rollCall.stub(_res);
}

const documentNodeQueryRollCall = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'RollCall'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'eventId')),
          type: NamedTypeNode(name: NameNode(value: 'ID'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'rollCall'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'eventId'),
                value: VariableNode(name: NameNode(value: 'eventId')),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'eventId'),
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
                  name: NameNode(value: 'opponent'),
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
                  name: NameNode(value: 'cancelled'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'completedAt'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'editable'),
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
                        name: NameNode(value: 'jerseyNumber'),
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
                        name: NameNode(value: 'note'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'formerPlayer'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'absenceNotice'),
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
                              name: NameNode(value: 'reason'),
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

class Query$RollCall$rollCall {
  Query$RollCall$rollCall({
    required this.eventId,
    required this.teamId,
    required this.teamName,
    required this.kind,
    this.title,
    this.opponent,
    required this.startsAt,
    required this.endsAt,
    required this.cancelled,
    this.completedAt,
    required this.editable,
    required this.players,
    this.$__typename = 'RollCall',
  });

  factory Query$RollCall$rollCall.fromJson(Map<String, dynamic> json) {
    final l$eventId = json['eventId'];
    final l$teamId = json['teamId'];
    final l$teamName = json['teamName'];
    final l$kind = json['kind'];
    final l$title = json['title'];
    final l$opponent = json['opponent'];
    final l$startsAt = json['startsAt'];
    final l$endsAt = json['endsAt'];
    final l$cancelled = json['cancelled'];
    final l$completedAt = json['completedAt'];
    final l$editable = json['editable'];
    final l$players = json['players'];
    final l$$__typename = json['__typename'];
    return Query$RollCall$rollCall(
      eventId: (l$eventId as String),
      teamId: (l$teamId as String),
      teamName: (l$teamName as String),
      kind: fromJson$Enum$EventKind((l$kind as String)),
      title: (l$title as String?),
      opponent: (l$opponent as String?),
      startsAt: (l$startsAt as String),
      endsAt: (l$endsAt as String),
      cancelled: (l$cancelled as bool),
      completedAt: (l$completedAt as String?),
      editable: (l$editable as bool),
      players: (l$players as List<dynamic>)
          .map(
            (e) => Query$RollCall$rollCall$players.fromJson(
              (e as Map<String, dynamic>),
            ),
          )
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final String eventId;

  final String teamId;

  final String teamName;

  final Enum$EventKind kind;

  final String? title;

  final String? opponent;

  final String startsAt;

  final String endsAt;

  final bool cancelled;

  final String? completedAt;

  final bool editable;

  final List<Query$RollCall$rollCall$players> players;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$eventId = eventId;
    _resultData['eventId'] = l$eventId;
    final l$teamId = teamId;
    _resultData['teamId'] = l$teamId;
    final l$teamName = teamName;
    _resultData['teamName'] = l$teamName;
    final l$kind = kind;
    _resultData['kind'] = toJson$Enum$EventKind(l$kind);
    final l$title = title;
    _resultData['title'] = l$title;
    final l$opponent = opponent;
    _resultData['opponent'] = l$opponent;
    final l$startsAt = startsAt;
    _resultData['startsAt'] = l$startsAt;
    final l$endsAt = endsAt;
    _resultData['endsAt'] = l$endsAt;
    final l$cancelled = cancelled;
    _resultData['cancelled'] = l$cancelled;
    final l$completedAt = completedAt;
    _resultData['completedAt'] = l$completedAt;
    final l$editable = editable;
    _resultData['editable'] = l$editable;
    final l$players = players;
    _resultData['players'] = l$players.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$eventId = eventId;
    final l$teamId = teamId;
    final l$teamName = teamName;
    final l$kind = kind;
    final l$title = title;
    final l$opponent = opponent;
    final l$startsAt = startsAt;
    final l$endsAt = endsAt;
    final l$cancelled = cancelled;
    final l$completedAt = completedAt;
    final l$editable = editable;
    final l$players = players;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$eventId,
      l$teamId,
      l$teamName,
      l$kind,
      l$title,
      l$opponent,
      l$startsAt,
      l$endsAt,
      l$cancelled,
      l$completedAt,
      l$editable,
      Object.hashAll(l$players.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$RollCall$rollCall || runtimeType != other.runtimeType) {
      return false;
    }
    final l$eventId = eventId;
    final lOther$eventId = other.eventId;
    if (l$eventId != lOther$eventId) {
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
    final l$opponent = opponent;
    final lOther$opponent = other.opponent;
    if (l$opponent != lOther$opponent) {
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
    final l$cancelled = cancelled;
    final lOther$cancelled = other.cancelled;
    if (l$cancelled != lOther$cancelled) {
      return false;
    }
    final l$completedAt = completedAt;
    final lOther$completedAt = other.completedAt;
    if (l$completedAt != lOther$completedAt) {
      return false;
    }
    final l$editable = editable;
    final lOther$editable = other.editable;
    if (l$editable != lOther$editable) {
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
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$RollCall$rollCall on Query$RollCall$rollCall {
  CopyWith$Query$RollCall$rollCall<Query$RollCall$rollCall> get copyWith =>
      CopyWith$Query$RollCall$rollCall(this, (i) => i);
}

abstract class CopyWith$Query$RollCall$rollCall<TRes> {
  factory CopyWith$Query$RollCall$rollCall(
    Query$RollCall$rollCall instance,
    TRes Function(Query$RollCall$rollCall) then,
  ) = _CopyWithImpl$Query$RollCall$rollCall;

  factory CopyWith$Query$RollCall$rollCall.stub(TRes res) =
      _CopyWithStubImpl$Query$RollCall$rollCall;

  TRes call({
    String? eventId,
    String? teamId,
    String? teamName,
    Enum$EventKind? kind,
    String? title,
    String? opponent,
    String? startsAt,
    String? endsAt,
    bool? cancelled,
    String? completedAt,
    bool? editable,
    List<Query$RollCall$rollCall$players>? players,
    String? $__typename,
  });
  TRes players(
    Iterable<Query$RollCall$rollCall$players> Function(
      Iterable<
        CopyWith$Query$RollCall$rollCall$players<
          Query$RollCall$rollCall$players
        >
      >,
    )
    _fn,
  );
}

class _CopyWithImpl$Query$RollCall$rollCall<TRes>
    implements CopyWith$Query$RollCall$rollCall<TRes> {
  _CopyWithImpl$Query$RollCall$rollCall(this._instance, this._then);

  final Query$RollCall$rollCall _instance;

  final TRes Function(Query$RollCall$rollCall) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? eventId = _undefined,
    Object? teamId = _undefined,
    Object? teamName = _undefined,
    Object? kind = _undefined,
    Object? title = _undefined,
    Object? opponent = _undefined,
    Object? startsAt = _undefined,
    Object? endsAt = _undefined,
    Object? cancelled = _undefined,
    Object? completedAt = _undefined,
    Object? editable = _undefined,
    Object? players = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$RollCall$rollCall(
      eventId: eventId == _undefined || eventId == null
          ? _instance.eventId
          : (eventId as String),
      teamId: teamId == _undefined || teamId == null
          ? _instance.teamId
          : (teamId as String),
      teamName: teamName == _undefined || teamName == null
          ? _instance.teamName
          : (teamName as String),
      kind: kind == _undefined || kind == null
          ? _instance.kind
          : (kind as Enum$EventKind),
      title: title == _undefined ? _instance.title : (title as String?),
      opponent: opponent == _undefined
          ? _instance.opponent
          : (opponent as String?),
      startsAt: startsAt == _undefined || startsAt == null
          ? _instance.startsAt
          : (startsAt as String),
      endsAt: endsAt == _undefined || endsAt == null
          ? _instance.endsAt
          : (endsAt as String),
      cancelled: cancelled == _undefined || cancelled == null
          ? _instance.cancelled
          : (cancelled as bool),
      completedAt: completedAt == _undefined
          ? _instance.completedAt
          : (completedAt as String?),
      editable: editable == _undefined || editable == null
          ? _instance.editable
          : (editable as bool),
      players: players == _undefined || players == null
          ? _instance.players
          : (players as List<Query$RollCall$rollCall$players>),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  TRes players(
    Iterable<Query$RollCall$rollCall$players> Function(
      Iterable<
        CopyWith$Query$RollCall$rollCall$players<
          Query$RollCall$rollCall$players
        >
      >,
    )
    _fn,
  ) => call(
    players: _fn(
      _instance.players.map(
        (e) => CopyWith$Query$RollCall$rollCall$players(e, (i) => i),
      ),
    ).toList(),
  );
}

class _CopyWithStubImpl$Query$RollCall$rollCall<TRes>
    implements CopyWith$Query$RollCall$rollCall<TRes> {
  _CopyWithStubImpl$Query$RollCall$rollCall(this._res);

  TRes _res;

  call({
    String? eventId,
    String? teamId,
    String? teamName,
    Enum$EventKind? kind,
    String? title,
    String? opponent,
    String? startsAt,
    String? endsAt,
    bool? cancelled,
    String? completedAt,
    bool? editable,
    List<Query$RollCall$rollCall$players>? players,
    String? $__typename,
  }) => _res;

  players(_fn) => _res;
}

class Query$RollCall$rollCall$players {
  Query$RollCall$rollCall$players({
    required this.personId,
    required this.firstName,
    required this.lastName,
    this.jerseyNumber,
    this.status,
    this.note,
    required this.formerPlayer,
    this.absenceNotice,
    this.$__typename = 'RollCallPlayer',
  });

  factory Query$RollCall$rollCall$players.fromJson(Map<String, dynamic> json) {
    final l$personId = json['personId'];
    final l$firstName = json['firstName'];
    final l$lastName = json['lastName'];
    final l$jerseyNumber = json['jerseyNumber'];
    final l$status = json['status'];
    final l$note = json['note'];
    final l$formerPlayer = json['formerPlayer'];
    final l$absenceNotice = json['absenceNotice'];
    final l$$__typename = json['__typename'];
    return Query$RollCall$rollCall$players(
      personId: (l$personId as String),
      firstName: (l$firstName as String),
      lastName: (l$lastName as String),
      jerseyNumber: (l$jerseyNumber as int?),
      status: l$status == null
          ? null
          : fromJson$Enum$AttendanceStatus((l$status as String)),
      note: (l$note as String?),
      formerPlayer: (l$formerPlayer as bool),
      absenceNotice: l$absenceNotice == null
          ? null
          : Query$RollCall$rollCall$players$absenceNotice.fromJson(
              (l$absenceNotice as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final String personId;

  final String firstName;

  final String lastName;

  final int? jerseyNumber;

  final Enum$AttendanceStatus? status;

  final String? note;

  final bool formerPlayer;

  final Query$RollCall$rollCall$players$absenceNotice? absenceNotice;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$personId = personId;
    _resultData['personId'] = l$personId;
    final l$firstName = firstName;
    _resultData['firstName'] = l$firstName;
    final l$lastName = lastName;
    _resultData['lastName'] = l$lastName;
    final l$jerseyNumber = jerseyNumber;
    _resultData['jerseyNumber'] = l$jerseyNumber;
    final l$status = status;
    _resultData['status'] = l$status == null
        ? null
        : toJson$Enum$AttendanceStatus(l$status);
    final l$note = note;
    _resultData['note'] = l$note;
    final l$formerPlayer = formerPlayer;
    _resultData['formerPlayer'] = l$formerPlayer;
    final l$absenceNotice = absenceNotice;
    _resultData['absenceNotice'] = l$absenceNotice?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$personId = personId;
    final l$firstName = firstName;
    final l$lastName = lastName;
    final l$jerseyNumber = jerseyNumber;
    final l$status = status;
    final l$note = note;
    final l$formerPlayer = formerPlayer;
    final l$absenceNotice = absenceNotice;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$personId,
      l$firstName,
      l$lastName,
      l$jerseyNumber,
      l$status,
      l$note,
      l$formerPlayer,
      l$absenceNotice,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$RollCall$rollCall$players ||
        runtimeType != other.runtimeType) {
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
    final l$jerseyNumber = jerseyNumber;
    final lOther$jerseyNumber = other.jerseyNumber;
    if (l$jerseyNumber != lOther$jerseyNumber) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) {
      return false;
    }
    final l$note = note;
    final lOther$note = other.note;
    if (l$note != lOther$note) {
      return false;
    }
    final l$formerPlayer = formerPlayer;
    final lOther$formerPlayer = other.formerPlayer;
    if (l$formerPlayer != lOther$formerPlayer) {
      return false;
    }
    final l$absenceNotice = absenceNotice;
    final lOther$absenceNotice = other.absenceNotice;
    if (l$absenceNotice != lOther$absenceNotice) {
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

extension UtilityExtension$Query$RollCall$rollCall$players
    on Query$RollCall$rollCall$players {
  CopyWith$Query$RollCall$rollCall$players<Query$RollCall$rollCall$players>
  get copyWith => CopyWith$Query$RollCall$rollCall$players(this, (i) => i);
}

abstract class CopyWith$Query$RollCall$rollCall$players<TRes> {
  factory CopyWith$Query$RollCall$rollCall$players(
    Query$RollCall$rollCall$players instance,
    TRes Function(Query$RollCall$rollCall$players) then,
  ) = _CopyWithImpl$Query$RollCall$rollCall$players;

  factory CopyWith$Query$RollCall$rollCall$players.stub(TRes res) =
      _CopyWithStubImpl$Query$RollCall$rollCall$players;

  TRes call({
    String? personId,
    String? firstName,
    String? lastName,
    int? jerseyNumber,
    Enum$AttendanceStatus? status,
    String? note,
    bool? formerPlayer,
    Query$RollCall$rollCall$players$absenceNotice? absenceNotice,
    String? $__typename,
  });
  CopyWith$Query$RollCall$rollCall$players$absenceNotice<TRes>
  get absenceNotice;
}

class _CopyWithImpl$Query$RollCall$rollCall$players<TRes>
    implements CopyWith$Query$RollCall$rollCall$players<TRes> {
  _CopyWithImpl$Query$RollCall$rollCall$players(this._instance, this._then);

  final Query$RollCall$rollCall$players _instance;

  final TRes Function(Query$RollCall$rollCall$players) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? personId = _undefined,
    Object? firstName = _undefined,
    Object? lastName = _undefined,
    Object? jerseyNumber = _undefined,
    Object? status = _undefined,
    Object? note = _undefined,
    Object? formerPlayer = _undefined,
    Object? absenceNotice = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$RollCall$rollCall$players(
      personId: personId == _undefined || personId == null
          ? _instance.personId
          : (personId as String),
      firstName: firstName == _undefined || firstName == null
          ? _instance.firstName
          : (firstName as String),
      lastName: lastName == _undefined || lastName == null
          ? _instance.lastName
          : (lastName as String),
      jerseyNumber: jerseyNumber == _undefined
          ? _instance.jerseyNumber
          : (jerseyNumber as int?),
      status: status == _undefined
          ? _instance.status
          : (status as Enum$AttendanceStatus?),
      note: note == _undefined ? _instance.note : (note as String?),
      formerPlayer: formerPlayer == _undefined || formerPlayer == null
          ? _instance.formerPlayer
          : (formerPlayer as bool),
      absenceNotice: absenceNotice == _undefined
          ? _instance.absenceNotice
          : (absenceNotice as Query$RollCall$rollCall$players$absenceNotice?),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  CopyWith$Query$RollCall$rollCall$players$absenceNotice<TRes>
  get absenceNotice {
    final local$absenceNotice = _instance.absenceNotice;
    return local$absenceNotice == null
        ? CopyWith$Query$RollCall$rollCall$players$absenceNotice.stub(
            _then(_instance),
          )
        : CopyWith$Query$RollCall$rollCall$players$absenceNotice(
            local$absenceNotice,
            (e) => call(absenceNotice: e),
          );
  }
}

class _CopyWithStubImpl$Query$RollCall$rollCall$players<TRes>
    implements CopyWith$Query$RollCall$rollCall$players<TRes> {
  _CopyWithStubImpl$Query$RollCall$rollCall$players(this._res);

  TRes _res;

  call({
    String? personId,
    String? firstName,
    String? lastName,
    int? jerseyNumber,
    Enum$AttendanceStatus? status,
    String? note,
    bool? formerPlayer,
    Query$RollCall$rollCall$players$absenceNotice? absenceNotice,
    String? $__typename,
  }) => _res;

  CopyWith$Query$RollCall$rollCall$players$absenceNotice<TRes>
  get absenceNotice =>
      CopyWith$Query$RollCall$rollCall$players$absenceNotice.stub(_res);
}

class Query$RollCall$rollCall$players$absenceNotice {
  Query$RollCall$rollCall$players$absenceNotice({
    required this.id,
    this.reason,
    this.$__typename = 'AbsenceNotice',
  });

  factory Query$RollCall$rollCall$players$absenceNotice.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$id = json['id'];
    final l$reason = json['reason'];
    final l$$__typename = json['__typename'];
    return Query$RollCall$rollCall$players$absenceNotice(
      id: (l$id as String),
      reason: (l$reason as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String? reason;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$reason = reason;
    _resultData['reason'] = l$reason;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$reason = reason;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$reason, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$RollCall$rollCall$players$absenceNotice ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$reason = reason;
    final lOther$reason = other.reason;
    if (l$reason != lOther$reason) {
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

extension UtilityExtension$Query$RollCall$rollCall$players$absenceNotice
    on Query$RollCall$rollCall$players$absenceNotice {
  CopyWith$Query$RollCall$rollCall$players$absenceNotice<
    Query$RollCall$rollCall$players$absenceNotice
  >
  get copyWith =>
      CopyWith$Query$RollCall$rollCall$players$absenceNotice(this, (i) => i);
}

abstract class CopyWith$Query$RollCall$rollCall$players$absenceNotice<TRes> {
  factory CopyWith$Query$RollCall$rollCall$players$absenceNotice(
    Query$RollCall$rollCall$players$absenceNotice instance,
    TRes Function(Query$RollCall$rollCall$players$absenceNotice) then,
  ) = _CopyWithImpl$Query$RollCall$rollCall$players$absenceNotice;

  factory CopyWith$Query$RollCall$rollCall$players$absenceNotice.stub(
    TRes res,
  ) = _CopyWithStubImpl$Query$RollCall$rollCall$players$absenceNotice;

  TRes call({String? id, String? reason, String? $__typename});
}

class _CopyWithImpl$Query$RollCall$rollCall$players$absenceNotice<TRes>
    implements CopyWith$Query$RollCall$rollCall$players$absenceNotice<TRes> {
  _CopyWithImpl$Query$RollCall$rollCall$players$absenceNotice(
    this._instance,
    this._then,
  );

  final Query$RollCall$rollCall$players$absenceNotice _instance;

  final TRes Function(Query$RollCall$rollCall$players$absenceNotice) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? reason = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$RollCall$rollCall$players$absenceNotice(
      id: id == _undefined || id == null ? _instance.id : (id as String),
      reason: reason == _undefined ? _instance.reason : (reason as String?),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$RollCall$rollCall$players$absenceNotice<TRes>
    implements CopyWith$Query$RollCall$rollCall$players$absenceNotice<TRes> {
  _CopyWithStubImpl$Query$RollCall$rollCall$players$absenceNotice(this._res);

  TRes _res;

  call({String? id, String? reason, String? $__typename}) => _res;
}

class Variables$Mutation$RecordAttendance {
  factory Variables$Mutation$RecordAttendance({
    required List<Input$AttendanceEntryInput> entries,
  }) => Variables$Mutation$RecordAttendance._({r'entries': entries});

  Variables$Mutation$RecordAttendance._(this._$data);

  factory Variables$Mutation$RecordAttendance.fromJson(
    Map<String, dynamic> data,
  ) {
    final result$data = <String, dynamic>{};
    final l$entries = data['entries'];
    result$data['entries'] = (l$entries as List<dynamic>)
        .map(
          (e) =>
              Input$AttendanceEntryInput.fromJson((e as Map<String, dynamic>)),
        )
        .toList();
    return Variables$Mutation$RecordAttendance._(result$data);
  }

  Map<String, dynamic> _$data;

  List<Input$AttendanceEntryInput> get entries =>
      (_$data['entries'] as List<Input$AttendanceEntryInput>);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$entries = entries;
    result$data['entries'] = l$entries.map((e) => e.toJson()).toList();
    return result$data;
  }

  CopyWith$Variables$Mutation$RecordAttendance<
    Variables$Mutation$RecordAttendance
  >
  get copyWith => CopyWith$Variables$Mutation$RecordAttendance(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$RecordAttendance ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$entries = entries;
    final lOther$entries = other.entries;
    if (l$entries.length != lOther$entries.length) {
      return false;
    }
    for (int i = 0; i < l$entries.length; i++) {
      final l$entries$entry = l$entries[i];
      final lOther$entries$entry = lOther$entries[i];
      if (l$entries$entry != lOther$entries$entry) {
        return false;
      }
    }
    return true;
  }

  @override
  int get hashCode {
    final l$entries = entries;
    return Object.hashAll([Object.hashAll(l$entries.map((v) => v))]);
  }
}

abstract class CopyWith$Variables$Mutation$RecordAttendance<TRes> {
  factory CopyWith$Variables$Mutation$RecordAttendance(
    Variables$Mutation$RecordAttendance instance,
    TRes Function(Variables$Mutation$RecordAttendance) then,
  ) = _CopyWithImpl$Variables$Mutation$RecordAttendance;

  factory CopyWith$Variables$Mutation$RecordAttendance.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$RecordAttendance;

  TRes call({List<Input$AttendanceEntryInput>? entries});
}

class _CopyWithImpl$Variables$Mutation$RecordAttendance<TRes>
    implements CopyWith$Variables$Mutation$RecordAttendance<TRes> {
  _CopyWithImpl$Variables$Mutation$RecordAttendance(this._instance, this._then);

  final Variables$Mutation$RecordAttendance _instance;

  final TRes Function(Variables$Mutation$RecordAttendance) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? entries = _undefined}) => _then(
    Variables$Mutation$RecordAttendance._({
      ..._instance._$data,
      if (entries != _undefined && entries != null)
        'entries': (entries as List<Input$AttendanceEntryInput>),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$RecordAttendance<TRes>
    implements CopyWith$Variables$Mutation$RecordAttendance<TRes> {
  _CopyWithStubImpl$Variables$Mutation$RecordAttendance(this._res);

  TRes _res;

  call({List<Input$AttendanceEntryInput>? entries}) => _res;
}

class Mutation$RecordAttendance {
  Mutation$RecordAttendance({
    required this.recordAttendance,
    this.$__typename = 'Mutation',
  });

  factory Mutation$RecordAttendance.fromJson(Map<String, dynamic> json) {
    final l$recordAttendance = json['recordAttendance'];
    final l$$__typename = json['__typename'];
    return Mutation$RecordAttendance(
      recordAttendance: (l$recordAttendance as List<dynamic>)
          .map(
            (e) => Mutation$RecordAttendance$recordAttendance.fromJson(
              (e as Map<String, dynamic>),
            ),
          )
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Mutation$RecordAttendance$recordAttendance> recordAttendance;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$recordAttendance = recordAttendance;
    _resultData['recordAttendance'] = l$recordAttendance
        .map((e) => e.toJson())
        .toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$recordAttendance = recordAttendance;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$recordAttendance.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$RecordAttendance ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$recordAttendance = recordAttendance;
    final lOther$recordAttendance = other.recordAttendance;
    if (l$recordAttendance.length != lOther$recordAttendance.length) {
      return false;
    }
    for (int i = 0; i < l$recordAttendance.length; i++) {
      final l$recordAttendance$entry = l$recordAttendance[i];
      final lOther$recordAttendance$entry = lOther$recordAttendance[i];
      if (l$recordAttendance$entry != lOther$recordAttendance$entry) {
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

extension UtilityExtension$Mutation$RecordAttendance
    on Mutation$RecordAttendance {
  CopyWith$Mutation$RecordAttendance<Mutation$RecordAttendance> get copyWith =>
      CopyWith$Mutation$RecordAttendance(this, (i) => i);
}

abstract class CopyWith$Mutation$RecordAttendance<TRes> {
  factory CopyWith$Mutation$RecordAttendance(
    Mutation$RecordAttendance instance,
    TRes Function(Mutation$RecordAttendance) then,
  ) = _CopyWithImpl$Mutation$RecordAttendance;

  factory CopyWith$Mutation$RecordAttendance.stub(TRes res) =
      _CopyWithStubImpl$Mutation$RecordAttendance;

  TRes call({
    List<Mutation$RecordAttendance$recordAttendance>? recordAttendance,
    String? $__typename,
  });
  TRes recordAttendance(
    Iterable<Mutation$RecordAttendance$recordAttendance> Function(
      Iterable<
        CopyWith$Mutation$RecordAttendance$recordAttendance<
          Mutation$RecordAttendance$recordAttendance
        >
      >,
    )
    _fn,
  );
}

class _CopyWithImpl$Mutation$RecordAttendance<TRes>
    implements CopyWith$Mutation$RecordAttendance<TRes> {
  _CopyWithImpl$Mutation$RecordAttendance(this._instance, this._then);

  final Mutation$RecordAttendance _instance;

  final TRes Function(Mutation$RecordAttendance) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? recordAttendance = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$RecordAttendance(
      recordAttendance:
          recordAttendance == _undefined || recordAttendance == null
          ? _instance.recordAttendance
          : (recordAttendance
                as List<Mutation$RecordAttendance$recordAttendance>),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  TRes recordAttendance(
    Iterable<Mutation$RecordAttendance$recordAttendance> Function(
      Iterable<
        CopyWith$Mutation$RecordAttendance$recordAttendance<
          Mutation$RecordAttendance$recordAttendance
        >
      >,
    )
    _fn,
  ) => call(
    recordAttendance: _fn(
      _instance.recordAttendance.map(
        (e) => CopyWith$Mutation$RecordAttendance$recordAttendance(e, (i) => i),
      ),
    ).toList(),
  );
}

class _CopyWithStubImpl$Mutation$RecordAttendance<TRes>
    implements CopyWith$Mutation$RecordAttendance<TRes> {
  _CopyWithStubImpl$Mutation$RecordAttendance(this._res);

  TRes _res;

  call({
    List<Mutation$RecordAttendance$recordAttendance>? recordAttendance,
    String? $__typename,
  }) => _res;

  recordAttendance(_fn) => _res;
}

const documentNodeMutationRecordAttendance = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'RecordAttendance'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'entries')),
          type: ListTypeNode(
            type: NamedTypeNode(
              name: NameNode(value: 'AttendanceEntryInput'),
              isNonNull: true,
            ),
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
            name: NameNode(value: 'recordAttendance'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'entries'),
                value: VariableNode(name: NameNode(value: 'entries')),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'clientMutationId'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'result'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'code'),
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

class Mutation$RecordAttendance$recordAttendance {
  Mutation$RecordAttendance$recordAttendance({
    required this.clientMutationId,
    required this.result,
    this.code,
    this.$__typename = 'AttendanceEntryResult',
  });

  factory Mutation$RecordAttendance$recordAttendance.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$clientMutationId = json['clientMutationId'];
    final l$result = json['result'];
    final l$code = json['code'];
    final l$$__typename = json['__typename'];
    return Mutation$RecordAttendance$recordAttendance(
      clientMutationId: (l$clientMutationId as String),
      result: fromJson$Enum$AttendanceResult((l$result as String)),
      code: (l$code as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String clientMutationId;

  final Enum$AttendanceResult result;

  final String? code;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$clientMutationId = clientMutationId;
    _resultData['clientMutationId'] = l$clientMutationId;
    final l$result = result;
    _resultData['result'] = toJson$Enum$AttendanceResult(l$result);
    final l$code = code;
    _resultData['code'] = l$code;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$clientMutationId = clientMutationId;
    final l$result = result;
    final l$code = code;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$clientMutationId,
      l$result,
      l$code,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$RecordAttendance$recordAttendance ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$clientMutationId = clientMutationId;
    final lOther$clientMutationId = other.clientMutationId;
    if (l$clientMutationId != lOther$clientMutationId) {
      return false;
    }
    final l$result = result;
    final lOther$result = other.result;
    if (l$result != lOther$result) {
      return false;
    }
    final l$code = code;
    final lOther$code = other.code;
    if (l$code != lOther$code) {
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

extension UtilityExtension$Mutation$RecordAttendance$recordAttendance
    on Mutation$RecordAttendance$recordAttendance {
  CopyWith$Mutation$RecordAttendance$recordAttendance<
    Mutation$RecordAttendance$recordAttendance
  >
  get copyWith =>
      CopyWith$Mutation$RecordAttendance$recordAttendance(this, (i) => i);
}

abstract class CopyWith$Mutation$RecordAttendance$recordAttendance<TRes> {
  factory CopyWith$Mutation$RecordAttendance$recordAttendance(
    Mutation$RecordAttendance$recordAttendance instance,
    TRes Function(Mutation$RecordAttendance$recordAttendance) then,
  ) = _CopyWithImpl$Mutation$RecordAttendance$recordAttendance;

  factory CopyWith$Mutation$RecordAttendance$recordAttendance.stub(TRes res) =
      _CopyWithStubImpl$Mutation$RecordAttendance$recordAttendance;

  TRes call({
    String? clientMutationId,
    Enum$AttendanceResult? result,
    String? code,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$RecordAttendance$recordAttendance<TRes>
    implements CopyWith$Mutation$RecordAttendance$recordAttendance<TRes> {
  _CopyWithImpl$Mutation$RecordAttendance$recordAttendance(
    this._instance,
    this._then,
  );

  final Mutation$RecordAttendance$recordAttendance _instance;

  final TRes Function(Mutation$RecordAttendance$recordAttendance) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? clientMutationId = _undefined,
    Object? result = _undefined,
    Object? code = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$RecordAttendance$recordAttendance(
      clientMutationId:
          clientMutationId == _undefined || clientMutationId == null
          ? _instance.clientMutationId
          : (clientMutationId as String),
      result: result == _undefined || result == null
          ? _instance.result
          : (result as Enum$AttendanceResult),
      code: code == _undefined ? _instance.code : (code as String?),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Mutation$RecordAttendance$recordAttendance<TRes>
    implements CopyWith$Mutation$RecordAttendance$recordAttendance<TRes> {
  _CopyWithStubImpl$Mutation$RecordAttendance$recordAttendance(this._res);

  TRes _res;

  call({
    String? clientMutationId,
    Enum$AttendanceResult? result,
    String? code,
    String? $__typename,
  }) => _res;
}

class Variables$Mutation$CompleteRollCall {
  factory Variables$Mutation$CompleteRollCall({required String eventId}) =>
      Variables$Mutation$CompleteRollCall._({r'eventId': eventId});

  Variables$Mutation$CompleteRollCall._(this._$data);

  factory Variables$Mutation$CompleteRollCall.fromJson(
    Map<String, dynamic> data,
  ) {
    final result$data = <String, dynamic>{};
    final l$eventId = data['eventId'];
    result$data['eventId'] = (l$eventId as String);
    return Variables$Mutation$CompleteRollCall._(result$data);
  }

  Map<String, dynamic> _$data;

  String get eventId => (_$data['eventId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$eventId = eventId;
    result$data['eventId'] = l$eventId;
    return result$data;
  }

  CopyWith$Variables$Mutation$CompleteRollCall<
    Variables$Mutation$CompleteRollCall
  >
  get copyWith => CopyWith$Variables$Mutation$CompleteRollCall(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$CompleteRollCall ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$eventId = eventId;
    final lOther$eventId = other.eventId;
    if (l$eventId != lOther$eventId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$eventId = eventId;
    return Object.hashAll([l$eventId]);
  }
}

abstract class CopyWith$Variables$Mutation$CompleteRollCall<TRes> {
  factory CopyWith$Variables$Mutation$CompleteRollCall(
    Variables$Mutation$CompleteRollCall instance,
    TRes Function(Variables$Mutation$CompleteRollCall) then,
  ) = _CopyWithImpl$Variables$Mutation$CompleteRollCall;

  factory CopyWith$Variables$Mutation$CompleteRollCall.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$CompleteRollCall;

  TRes call({String? eventId});
}

class _CopyWithImpl$Variables$Mutation$CompleteRollCall<TRes>
    implements CopyWith$Variables$Mutation$CompleteRollCall<TRes> {
  _CopyWithImpl$Variables$Mutation$CompleteRollCall(this._instance, this._then);

  final Variables$Mutation$CompleteRollCall _instance;

  final TRes Function(Variables$Mutation$CompleteRollCall) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? eventId = _undefined}) => _then(
    Variables$Mutation$CompleteRollCall._({
      ..._instance._$data,
      if (eventId != _undefined && eventId != null)
        'eventId': (eventId as String),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$CompleteRollCall<TRes>
    implements CopyWith$Variables$Mutation$CompleteRollCall<TRes> {
  _CopyWithStubImpl$Variables$Mutation$CompleteRollCall(this._res);

  TRes _res;

  call({String? eventId}) => _res;
}

class Mutation$CompleteRollCall {
  Mutation$CompleteRollCall({
    required this.completeRollCall,
    this.$__typename = 'Mutation',
  });

  factory Mutation$CompleteRollCall.fromJson(Map<String, dynamic> json) {
    final l$completeRollCall = json['completeRollCall'];
    final l$$__typename = json['__typename'];
    return Mutation$CompleteRollCall(
      completeRollCall: Mutation$CompleteRollCall$completeRollCall.fromJson(
        (l$completeRollCall as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$CompleteRollCall$completeRollCall completeRollCall;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$completeRollCall = completeRollCall;
    _resultData['completeRollCall'] = l$completeRollCall.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$completeRollCall = completeRollCall;
    final l$$__typename = $__typename;
    return Object.hashAll([l$completeRollCall, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$CompleteRollCall ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$completeRollCall = completeRollCall;
    final lOther$completeRollCall = other.completeRollCall;
    if (l$completeRollCall != lOther$completeRollCall) {
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

extension UtilityExtension$Mutation$CompleteRollCall
    on Mutation$CompleteRollCall {
  CopyWith$Mutation$CompleteRollCall<Mutation$CompleteRollCall> get copyWith =>
      CopyWith$Mutation$CompleteRollCall(this, (i) => i);
}

abstract class CopyWith$Mutation$CompleteRollCall<TRes> {
  factory CopyWith$Mutation$CompleteRollCall(
    Mutation$CompleteRollCall instance,
    TRes Function(Mutation$CompleteRollCall) then,
  ) = _CopyWithImpl$Mutation$CompleteRollCall;

  factory CopyWith$Mutation$CompleteRollCall.stub(TRes res) =
      _CopyWithStubImpl$Mutation$CompleteRollCall;

  TRes call({
    Mutation$CompleteRollCall$completeRollCall? completeRollCall,
    String? $__typename,
  });
  CopyWith$Mutation$CompleteRollCall$completeRollCall<TRes>
  get completeRollCall;
}

class _CopyWithImpl$Mutation$CompleteRollCall<TRes>
    implements CopyWith$Mutation$CompleteRollCall<TRes> {
  _CopyWithImpl$Mutation$CompleteRollCall(this._instance, this._then);

  final Mutation$CompleteRollCall _instance;

  final TRes Function(Mutation$CompleteRollCall) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? completeRollCall = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$CompleteRollCall(
      completeRollCall:
          completeRollCall == _undefined || completeRollCall == null
          ? _instance.completeRollCall
          : (completeRollCall as Mutation$CompleteRollCall$completeRollCall),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  CopyWith$Mutation$CompleteRollCall$completeRollCall<TRes>
  get completeRollCall {
    final local$completeRollCall = _instance.completeRollCall;
    return CopyWith$Mutation$CompleteRollCall$completeRollCall(
      local$completeRollCall,
      (e) => call(completeRollCall: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$CompleteRollCall<TRes>
    implements CopyWith$Mutation$CompleteRollCall<TRes> {
  _CopyWithStubImpl$Mutation$CompleteRollCall(this._res);

  TRes _res;

  call({
    Mutation$CompleteRollCall$completeRollCall? completeRollCall,
    String? $__typename,
  }) => _res;

  CopyWith$Mutation$CompleteRollCall$completeRollCall<TRes>
  get completeRollCall =>
      CopyWith$Mutation$CompleteRollCall$completeRollCall.stub(_res);
}

const documentNodeMutationCompleteRollCall = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'CompleteRollCall'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'eventId')),
          type: NamedTypeNode(name: NameNode(value: 'ID'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'completeRollCall'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'eventId'),
                value: VariableNode(name: NameNode(value: 'eventId')),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'eventId'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'completedAt'),
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

class Mutation$CompleteRollCall$completeRollCall {
  Mutation$CompleteRollCall$completeRollCall({
    required this.eventId,
    this.completedAt,
    this.$__typename = 'RollCall',
  });

  factory Mutation$CompleteRollCall$completeRollCall.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$eventId = json['eventId'];
    final l$completedAt = json['completedAt'];
    final l$$__typename = json['__typename'];
    return Mutation$CompleteRollCall$completeRollCall(
      eventId: (l$eventId as String),
      completedAt: (l$completedAt as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String eventId;

  final String? completedAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$eventId = eventId;
    _resultData['eventId'] = l$eventId;
    final l$completedAt = completedAt;
    _resultData['completedAt'] = l$completedAt;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$eventId = eventId;
    final l$completedAt = completedAt;
    final l$$__typename = $__typename;
    return Object.hashAll([l$eventId, l$completedAt, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$CompleteRollCall$completeRollCall ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$eventId = eventId;
    final lOther$eventId = other.eventId;
    if (l$eventId != lOther$eventId) {
      return false;
    }
    final l$completedAt = completedAt;
    final lOther$completedAt = other.completedAt;
    if (l$completedAt != lOther$completedAt) {
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

extension UtilityExtension$Mutation$CompleteRollCall$completeRollCall
    on Mutation$CompleteRollCall$completeRollCall {
  CopyWith$Mutation$CompleteRollCall$completeRollCall<
    Mutation$CompleteRollCall$completeRollCall
  >
  get copyWith =>
      CopyWith$Mutation$CompleteRollCall$completeRollCall(this, (i) => i);
}

abstract class CopyWith$Mutation$CompleteRollCall$completeRollCall<TRes> {
  factory CopyWith$Mutation$CompleteRollCall$completeRollCall(
    Mutation$CompleteRollCall$completeRollCall instance,
    TRes Function(Mutation$CompleteRollCall$completeRollCall) then,
  ) = _CopyWithImpl$Mutation$CompleteRollCall$completeRollCall;

  factory CopyWith$Mutation$CompleteRollCall$completeRollCall.stub(TRes res) =
      _CopyWithStubImpl$Mutation$CompleteRollCall$completeRollCall;

  TRes call({String? eventId, String? completedAt, String? $__typename});
}

class _CopyWithImpl$Mutation$CompleteRollCall$completeRollCall<TRes>
    implements CopyWith$Mutation$CompleteRollCall$completeRollCall<TRes> {
  _CopyWithImpl$Mutation$CompleteRollCall$completeRollCall(
    this._instance,
    this._then,
  );

  final Mutation$CompleteRollCall$completeRollCall _instance;

  final TRes Function(Mutation$CompleteRollCall$completeRollCall) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? eventId = _undefined,
    Object? completedAt = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$CompleteRollCall$completeRollCall(
      eventId: eventId == _undefined || eventId == null
          ? _instance.eventId
          : (eventId as String),
      completedAt: completedAt == _undefined
          ? _instance.completedAt
          : (completedAt as String?),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Mutation$CompleteRollCall$completeRollCall<TRes>
    implements CopyWith$Mutation$CompleteRollCall$completeRollCall<TRes> {
  _CopyWithStubImpl$Mutation$CompleteRollCall$completeRollCall(this._res);

  TRes _res;

  call({String? eventId, String? completedAt, String? $__typename}) => _res;
}

class Variables$Query$MyParticipation {
  factory Variables$Query$MyParticipation({required String eventId}) =>
      Variables$Query$MyParticipation._({r'eventId': eventId});

  Variables$Query$MyParticipation._(this._$data);

  factory Variables$Query$MyParticipation.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$eventId = data['eventId'];
    result$data['eventId'] = (l$eventId as String);
    return Variables$Query$MyParticipation._(result$data);
  }

  Map<String, dynamic> _$data;

  String get eventId => (_$data['eventId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$eventId = eventId;
    result$data['eventId'] = l$eventId;
    return result$data;
  }

  CopyWith$Variables$Query$MyParticipation<Variables$Query$MyParticipation>
  get copyWith => CopyWith$Variables$Query$MyParticipation(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Query$MyParticipation ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$eventId = eventId;
    final lOther$eventId = other.eventId;
    if (l$eventId != lOther$eventId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$eventId = eventId;
    return Object.hashAll([l$eventId]);
  }
}

abstract class CopyWith$Variables$Query$MyParticipation<TRes> {
  factory CopyWith$Variables$Query$MyParticipation(
    Variables$Query$MyParticipation instance,
    TRes Function(Variables$Query$MyParticipation) then,
  ) = _CopyWithImpl$Variables$Query$MyParticipation;

  factory CopyWith$Variables$Query$MyParticipation.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$MyParticipation;

  TRes call({String? eventId});
}

class _CopyWithImpl$Variables$Query$MyParticipation<TRes>
    implements CopyWith$Variables$Query$MyParticipation<TRes> {
  _CopyWithImpl$Variables$Query$MyParticipation(this._instance, this._then);

  final Variables$Query$MyParticipation _instance;

  final TRes Function(Variables$Query$MyParticipation) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? eventId = _undefined}) => _then(
    Variables$Query$MyParticipation._({
      ..._instance._$data,
      if (eventId != _undefined && eventId != null)
        'eventId': (eventId as String),
    }),
  );
}

class _CopyWithStubImpl$Variables$Query$MyParticipation<TRes>
    implements CopyWith$Variables$Query$MyParticipation<TRes> {
  _CopyWithStubImpl$Variables$Query$MyParticipation(this._res);

  TRes _res;

  call({String? eventId}) => _res;
}

class Query$MyParticipation {
  Query$MyParticipation({
    required this.myParticipation,
    this.$__typename = 'Query',
  });

  factory Query$MyParticipation.fromJson(Map<String, dynamic> json) {
    final l$myParticipation = json['myParticipation'];
    final l$$__typename = json['__typename'];
    return Query$MyParticipation(
      myParticipation: (l$myParticipation as List<dynamic>)
          .map(
            (e) => Fragment$ParticipationFields.fromJson(
              (e as Map<String, dynamic>),
            ),
          )
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Fragment$ParticipationFields> myParticipation;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$myParticipation = myParticipation;
    _resultData['myParticipation'] = l$myParticipation
        .map((e) => e.toJson())
        .toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$myParticipation = myParticipation;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$myParticipation.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$MyParticipation || runtimeType != other.runtimeType) {
      return false;
    }
    final l$myParticipation = myParticipation;
    final lOther$myParticipation = other.myParticipation;
    if (l$myParticipation.length != lOther$myParticipation.length) {
      return false;
    }
    for (int i = 0; i < l$myParticipation.length; i++) {
      final l$myParticipation$entry = l$myParticipation[i];
      final lOther$myParticipation$entry = lOther$myParticipation[i];
      if (l$myParticipation$entry != lOther$myParticipation$entry) {
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

extension UtilityExtension$Query$MyParticipation on Query$MyParticipation {
  CopyWith$Query$MyParticipation<Query$MyParticipation> get copyWith =>
      CopyWith$Query$MyParticipation(this, (i) => i);
}

abstract class CopyWith$Query$MyParticipation<TRes> {
  factory CopyWith$Query$MyParticipation(
    Query$MyParticipation instance,
    TRes Function(Query$MyParticipation) then,
  ) = _CopyWithImpl$Query$MyParticipation;

  factory CopyWith$Query$MyParticipation.stub(TRes res) =
      _CopyWithStubImpl$Query$MyParticipation;

  TRes call({
    List<Fragment$ParticipationFields>? myParticipation,
    String? $__typename,
  });
  TRes myParticipation(
    Iterable<Fragment$ParticipationFields> Function(
      Iterable<
        CopyWith$Fragment$ParticipationFields<Fragment$ParticipationFields>
      >,
    )
    _fn,
  );
}

class _CopyWithImpl$Query$MyParticipation<TRes>
    implements CopyWith$Query$MyParticipation<TRes> {
  _CopyWithImpl$Query$MyParticipation(this._instance, this._then);

  final Query$MyParticipation _instance;

  final TRes Function(Query$MyParticipation) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? myParticipation = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$MyParticipation(
      myParticipation: myParticipation == _undefined || myParticipation == null
          ? _instance.myParticipation
          : (myParticipation as List<Fragment$ParticipationFields>),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  TRes myParticipation(
    Iterable<Fragment$ParticipationFields> Function(
      Iterable<
        CopyWith$Fragment$ParticipationFields<Fragment$ParticipationFields>
      >,
    )
    _fn,
  ) => call(
    myParticipation: _fn(
      _instance.myParticipation.map(
        (e) => CopyWith$Fragment$ParticipationFields(e, (i) => i),
      ),
    ).toList(),
  );
}

class _CopyWithStubImpl$Query$MyParticipation<TRes>
    implements CopyWith$Query$MyParticipation<TRes> {
  _CopyWithStubImpl$Query$MyParticipation(this._res);

  TRes _res;

  call({
    List<Fragment$ParticipationFields>? myParticipation,
    String? $__typename,
  }) => _res;

  myParticipation(_fn) => _res;
}

const documentNodeQueryMyParticipation = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'MyParticipation'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'eventId')),
          type: NamedTypeNode(name: NameNode(value: 'ID'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'myParticipation'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'eventId'),
                value: VariableNode(name: NameNode(value: 'eventId')),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FragmentSpreadNode(
                  name: NameNode(value: 'ParticipationFields'),
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
    fragmentDefinitionParticipationFields,
  ],
);

class Variables$Mutation$ReportAbsence {
  factory Variables$Mutation$ReportAbsence({
    required String eventId,
    required String personId,
    String? reason,
  }) => Variables$Mutation$ReportAbsence._({
    r'eventId': eventId,
    r'personId': personId,
    if (reason != null) r'reason': reason,
  });

  Variables$Mutation$ReportAbsence._(this._$data);

  factory Variables$Mutation$ReportAbsence.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$eventId = data['eventId'];
    result$data['eventId'] = (l$eventId as String);
    final l$personId = data['personId'];
    result$data['personId'] = (l$personId as String);
    if (data.containsKey('reason')) {
      final l$reason = data['reason'];
      result$data['reason'] = (l$reason as String?);
    }
    return Variables$Mutation$ReportAbsence._(result$data);
  }

  Map<String, dynamic> _$data;

  String get eventId => (_$data['eventId'] as String);

  String get personId => (_$data['personId'] as String);

  String? get reason => (_$data['reason'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$eventId = eventId;
    result$data['eventId'] = l$eventId;
    final l$personId = personId;
    result$data['personId'] = l$personId;
    if (_$data.containsKey('reason')) {
      final l$reason = reason;
      result$data['reason'] = l$reason;
    }
    return result$data;
  }

  CopyWith$Variables$Mutation$ReportAbsence<Variables$Mutation$ReportAbsence>
  get copyWith => CopyWith$Variables$Mutation$ReportAbsence(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$ReportAbsence ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$eventId = eventId;
    final lOther$eventId = other.eventId;
    if (l$eventId != lOther$eventId) {
      return false;
    }
    final l$personId = personId;
    final lOther$personId = other.personId;
    if (l$personId != lOther$personId) {
      return false;
    }
    final l$reason = reason;
    final lOther$reason = other.reason;
    if (_$data.containsKey('reason') != other._$data.containsKey('reason')) {
      return false;
    }
    if (l$reason != lOther$reason) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$eventId = eventId;
    final l$personId = personId;
    final l$reason = reason;
    return Object.hashAll([
      l$eventId,
      l$personId,
      _$data.containsKey('reason') ? l$reason : const {},
    ]);
  }
}

abstract class CopyWith$Variables$Mutation$ReportAbsence<TRes> {
  factory CopyWith$Variables$Mutation$ReportAbsence(
    Variables$Mutation$ReportAbsence instance,
    TRes Function(Variables$Mutation$ReportAbsence) then,
  ) = _CopyWithImpl$Variables$Mutation$ReportAbsence;

  factory CopyWith$Variables$Mutation$ReportAbsence.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$ReportAbsence;

  TRes call({String? eventId, String? personId, String? reason});
}

class _CopyWithImpl$Variables$Mutation$ReportAbsence<TRes>
    implements CopyWith$Variables$Mutation$ReportAbsence<TRes> {
  _CopyWithImpl$Variables$Mutation$ReportAbsence(this._instance, this._then);

  final Variables$Mutation$ReportAbsence _instance;

  final TRes Function(Variables$Mutation$ReportAbsence) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? eventId = _undefined,
    Object? personId = _undefined,
    Object? reason = _undefined,
  }) => _then(
    Variables$Mutation$ReportAbsence._({
      ..._instance._$data,
      if (eventId != _undefined && eventId != null)
        'eventId': (eventId as String),
      if (personId != _undefined && personId != null)
        'personId': (personId as String),
      if (reason != _undefined) 'reason': (reason as String?),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$ReportAbsence<TRes>
    implements CopyWith$Variables$Mutation$ReportAbsence<TRes> {
  _CopyWithStubImpl$Variables$Mutation$ReportAbsence(this._res);

  TRes _res;

  call({String? eventId, String? personId, String? reason}) => _res;
}

class Mutation$ReportAbsence {
  Mutation$ReportAbsence({
    required this.reportAbsence,
    this.$__typename = 'Mutation',
  });

  factory Mutation$ReportAbsence.fromJson(Map<String, dynamic> json) {
    final l$reportAbsence = json['reportAbsence'];
    final l$$__typename = json['__typename'];
    return Mutation$ReportAbsence(
      reportAbsence: (l$reportAbsence as List<dynamic>)
          .map(
            (e) => Fragment$ParticipationFields.fromJson(
              (e as Map<String, dynamic>),
            ),
          )
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Fragment$ParticipationFields> reportAbsence;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$reportAbsence = reportAbsence;
    _resultData['reportAbsence'] = l$reportAbsence
        .map((e) => e.toJson())
        .toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$reportAbsence = reportAbsence;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$reportAbsence.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$ReportAbsence || runtimeType != other.runtimeType) {
      return false;
    }
    final l$reportAbsence = reportAbsence;
    final lOther$reportAbsence = other.reportAbsence;
    if (l$reportAbsence.length != lOther$reportAbsence.length) {
      return false;
    }
    for (int i = 0; i < l$reportAbsence.length; i++) {
      final l$reportAbsence$entry = l$reportAbsence[i];
      final lOther$reportAbsence$entry = lOther$reportAbsence[i];
      if (l$reportAbsence$entry != lOther$reportAbsence$entry) {
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

extension UtilityExtension$Mutation$ReportAbsence on Mutation$ReportAbsence {
  CopyWith$Mutation$ReportAbsence<Mutation$ReportAbsence> get copyWith =>
      CopyWith$Mutation$ReportAbsence(this, (i) => i);
}

abstract class CopyWith$Mutation$ReportAbsence<TRes> {
  factory CopyWith$Mutation$ReportAbsence(
    Mutation$ReportAbsence instance,
    TRes Function(Mutation$ReportAbsence) then,
  ) = _CopyWithImpl$Mutation$ReportAbsence;

  factory CopyWith$Mutation$ReportAbsence.stub(TRes res) =
      _CopyWithStubImpl$Mutation$ReportAbsence;

  TRes call({
    List<Fragment$ParticipationFields>? reportAbsence,
    String? $__typename,
  });
  TRes reportAbsence(
    Iterable<Fragment$ParticipationFields> Function(
      Iterable<
        CopyWith$Fragment$ParticipationFields<Fragment$ParticipationFields>
      >,
    )
    _fn,
  );
}

class _CopyWithImpl$Mutation$ReportAbsence<TRes>
    implements CopyWith$Mutation$ReportAbsence<TRes> {
  _CopyWithImpl$Mutation$ReportAbsence(this._instance, this._then);

  final Mutation$ReportAbsence _instance;

  final TRes Function(Mutation$ReportAbsence) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? reportAbsence = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$ReportAbsence(
      reportAbsence: reportAbsence == _undefined || reportAbsence == null
          ? _instance.reportAbsence
          : (reportAbsence as List<Fragment$ParticipationFields>),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  TRes reportAbsence(
    Iterable<Fragment$ParticipationFields> Function(
      Iterable<
        CopyWith$Fragment$ParticipationFields<Fragment$ParticipationFields>
      >,
    )
    _fn,
  ) => call(
    reportAbsence: _fn(
      _instance.reportAbsence.map(
        (e) => CopyWith$Fragment$ParticipationFields(e, (i) => i),
      ),
    ).toList(),
  );
}

class _CopyWithStubImpl$Mutation$ReportAbsence<TRes>
    implements CopyWith$Mutation$ReportAbsence<TRes> {
  _CopyWithStubImpl$Mutation$ReportAbsence(this._res);

  TRes _res;

  call({
    List<Fragment$ParticipationFields>? reportAbsence,
    String? $__typename,
  }) => _res;

  reportAbsence(_fn) => _res;
}

const documentNodeMutationReportAbsence = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'ReportAbsence'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'eventId')),
          type: NamedTypeNode(name: NameNode(value: 'ID'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'personId')),
          type: NamedTypeNode(name: NameNode(value: 'ID'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'reason')),
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
            name: NameNode(value: 'reportAbsence'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'eventId'),
                value: VariableNode(name: NameNode(value: 'eventId')),
              ),
              ArgumentNode(
                name: NameNode(value: 'personId'),
                value: VariableNode(name: NameNode(value: 'personId')),
              ),
              ArgumentNode(
                name: NameNode(value: 'reason'),
                value: VariableNode(name: NameNode(value: 'reason')),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FragmentSpreadNode(
                  name: NameNode(value: 'ParticipationFields'),
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
    fragmentDefinitionParticipationFields,
  ],
);

class Variables$Mutation$WithdrawAbsence {
  factory Variables$Mutation$WithdrawAbsence({required String noticeId}) =>
      Variables$Mutation$WithdrawAbsence._({r'noticeId': noticeId});

  Variables$Mutation$WithdrawAbsence._(this._$data);

  factory Variables$Mutation$WithdrawAbsence.fromJson(
    Map<String, dynamic> data,
  ) {
    final result$data = <String, dynamic>{};
    final l$noticeId = data['noticeId'];
    result$data['noticeId'] = (l$noticeId as String);
    return Variables$Mutation$WithdrawAbsence._(result$data);
  }

  Map<String, dynamic> _$data;

  String get noticeId => (_$data['noticeId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$noticeId = noticeId;
    result$data['noticeId'] = l$noticeId;
    return result$data;
  }

  CopyWith$Variables$Mutation$WithdrawAbsence<
    Variables$Mutation$WithdrawAbsence
  >
  get copyWith => CopyWith$Variables$Mutation$WithdrawAbsence(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$WithdrawAbsence ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$noticeId = noticeId;
    final lOther$noticeId = other.noticeId;
    if (l$noticeId != lOther$noticeId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$noticeId = noticeId;
    return Object.hashAll([l$noticeId]);
  }
}

abstract class CopyWith$Variables$Mutation$WithdrawAbsence<TRes> {
  factory CopyWith$Variables$Mutation$WithdrawAbsence(
    Variables$Mutation$WithdrawAbsence instance,
    TRes Function(Variables$Mutation$WithdrawAbsence) then,
  ) = _CopyWithImpl$Variables$Mutation$WithdrawAbsence;

  factory CopyWith$Variables$Mutation$WithdrawAbsence.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$WithdrawAbsence;

  TRes call({String? noticeId});
}

class _CopyWithImpl$Variables$Mutation$WithdrawAbsence<TRes>
    implements CopyWith$Variables$Mutation$WithdrawAbsence<TRes> {
  _CopyWithImpl$Variables$Mutation$WithdrawAbsence(this._instance, this._then);

  final Variables$Mutation$WithdrawAbsence _instance;

  final TRes Function(Variables$Mutation$WithdrawAbsence) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? noticeId = _undefined}) => _then(
    Variables$Mutation$WithdrawAbsence._({
      ..._instance._$data,
      if (noticeId != _undefined && noticeId != null)
        'noticeId': (noticeId as String),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$WithdrawAbsence<TRes>
    implements CopyWith$Variables$Mutation$WithdrawAbsence<TRes> {
  _CopyWithStubImpl$Variables$Mutation$WithdrawAbsence(this._res);

  TRes _res;

  call({String? noticeId}) => _res;
}

class Mutation$WithdrawAbsence {
  Mutation$WithdrawAbsence({
    required this.withdrawAbsence,
    this.$__typename = 'Mutation',
  });

  factory Mutation$WithdrawAbsence.fromJson(Map<String, dynamic> json) {
    final l$withdrawAbsence = json['withdrawAbsence'];
    final l$$__typename = json['__typename'];
    return Mutation$WithdrawAbsence(
      withdrawAbsence: (l$withdrawAbsence as List<dynamic>)
          .map(
            (e) => Fragment$ParticipationFields.fromJson(
              (e as Map<String, dynamic>),
            ),
          )
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Fragment$ParticipationFields> withdrawAbsence;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$withdrawAbsence = withdrawAbsence;
    _resultData['withdrawAbsence'] = l$withdrawAbsence
        .map((e) => e.toJson())
        .toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$withdrawAbsence = withdrawAbsence;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$withdrawAbsence.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$WithdrawAbsence ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$withdrawAbsence = withdrawAbsence;
    final lOther$withdrawAbsence = other.withdrawAbsence;
    if (l$withdrawAbsence.length != lOther$withdrawAbsence.length) {
      return false;
    }
    for (int i = 0; i < l$withdrawAbsence.length; i++) {
      final l$withdrawAbsence$entry = l$withdrawAbsence[i];
      final lOther$withdrawAbsence$entry = lOther$withdrawAbsence[i];
      if (l$withdrawAbsence$entry != lOther$withdrawAbsence$entry) {
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

extension UtilityExtension$Mutation$WithdrawAbsence
    on Mutation$WithdrawAbsence {
  CopyWith$Mutation$WithdrawAbsence<Mutation$WithdrawAbsence> get copyWith =>
      CopyWith$Mutation$WithdrawAbsence(this, (i) => i);
}

abstract class CopyWith$Mutation$WithdrawAbsence<TRes> {
  factory CopyWith$Mutation$WithdrawAbsence(
    Mutation$WithdrawAbsence instance,
    TRes Function(Mutation$WithdrawAbsence) then,
  ) = _CopyWithImpl$Mutation$WithdrawAbsence;

  factory CopyWith$Mutation$WithdrawAbsence.stub(TRes res) =
      _CopyWithStubImpl$Mutation$WithdrawAbsence;

  TRes call({
    List<Fragment$ParticipationFields>? withdrawAbsence,
    String? $__typename,
  });
  TRes withdrawAbsence(
    Iterable<Fragment$ParticipationFields> Function(
      Iterable<
        CopyWith$Fragment$ParticipationFields<Fragment$ParticipationFields>
      >,
    )
    _fn,
  );
}

class _CopyWithImpl$Mutation$WithdrawAbsence<TRes>
    implements CopyWith$Mutation$WithdrawAbsence<TRes> {
  _CopyWithImpl$Mutation$WithdrawAbsence(this._instance, this._then);

  final Mutation$WithdrawAbsence _instance;

  final TRes Function(Mutation$WithdrawAbsence) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? withdrawAbsence = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$WithdrawAbsence(
      withdrawAbsence: withdrawAbsence == _undefined || withdrawAbsence == null
          ? _instance.withdrawAbsence
          : (withdrawAbsence as List<Fragment$ParticipationFields>),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  TRes withdrawAbsence(
    Iterable<Fragment$ParticipationFields> Function(
      Iterable<
        CopyWith$Fragment$ParticipationFields<Fragment$ParticipationFields>
      >,
    )
    _fn,
  ) => call(
    withdrawAbsence: _fn(
      _instance.withdrawAbsence.map(
        (e) => CopyWith$Fragment$ParticipationFields(e, (i) => i),
      ),
    ).toList(),
  );
}

class _CopyWithStubImpl$Mutation$WithdrawAbsence<TRes>
    implements CopyWith$Mutation$WithdrawAbsence<TRes> {
  _CopyWithStubImpl$Mutation$WithdrawAbsence(this._res);

  TRes _res;

  call({
    List<Fragment$ParticipationFields>? withdrawAbsence,
    String? $__typename,
  }) => _res;

  withdrawAbsence(_fn) => _res;
}

const documentNodeMutationWithdrawAbsence = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'WithdrawAbsence'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'noticeId')),
          type: NamedTypeNode(name: NameNode(value: 'ID'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'withdrawAbsence'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'noticeId'),
                value: VariableNode(name: NameNode(value: 'noticeId')),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FragmentSpreadNode(
                  name: NameNode(value: 'ParticipationFields'),
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
    fragmentDefinitionParticipationFields,
  ],
);

class Variables$Query$PersonAttendance {
  factory Variables$Query$PersonAttendance({required String personId}) =>
      Variables$Query$PersonAttendance._({r'personId': personId});

  Variables$Query$PersonAttendance._(this._$data);

  factory Variables$Query$PersonAttendance.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$personId = data['personId'];
    result$data['personId'] = (l$personId as String);
    return Variables$Query$PersonAttendance._(result$data);
  }

  Map<String, dynamic> _$data;

  String get personId => (_$data['personId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$personId = personId;
    result$data['personId'] = l$personId;
    return result$data;
  }

  CopyWith$Variables$Query$PersonAttendance<Variables$Query$PersonAttendance>
  get copyWith => CopyWith$Variables$Query$PersonAttendance(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Query$PersonAttendance ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$personId = personId;
    final lOther$personId = other.personId;
    if (l$personId != lOther$personId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$personId = personId;
    return Object.hashAll([l$personId]);
  }
}

abstract class CopyWith$Variables$Query$PersonAttendance<TRes> {
  factory CopyWith$Variables$Query$PersonAttendance(
    Variables$Query$PersonAttendance instance,
    TRes Function(Variables$Query$PersonAttendance) then,
  ) = _CopyWithImpl$Variables$Query$PersonAttendance;

  factory CopyWith$Variables$Query$PersonAttendance.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$PersonAttendance;

  TRes call({String? personId});
}

class _CopyWithImpl$Variables$Query$PersonAttendance<TRes>
    implements CopyWith$Variables$Query$PersonAttendance<TRes> {
  _CopyWithImpl$Variables$Query$PersonAttendance(this._instance, this._then);

  final Variables$Query$PersonAttendance _instance;

  final TRes Function(Variables$Query$PersonAttendance) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? personId = _undefined}) => _then(
    Variables$Query$PersonAttendance._({
      ..._instance._$data,
      if (personId != _undefined && personId != null)
        'personId': (personId as String),
    }),
  );
}

class _CopyWithStubImpl$Variables$Query$PersonAttendance<TRes>
    implements CopyWith$Variables$Query$PersonAttendance<TRes> {
  _CopyWithStubImpl$Variables$Query$PersonAttendance(this._res);

  TRes _res;

  call({String? personId}) => _res;
}

class Query$PersonAttendance {
  Query$PersonAttendance({
    required this.personAttendance,
    this.$__typename = 'Query',
  });

  factory Query$PersonAttendance.fromJson(Map<String, dynamic> json) {
    final l$personAttendance = json['personAttendance'];
    final l$$__typename = json['__typename'];
    return Query$PersonAttendance(
      personAttendance: (l$personAttendance as List<dynamic>)
          .map(
            (e) => Query$PersonAttendance$personAttendance.fromJson(
              (e as Map<String, dynamic>),
            ),
          )
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Query$PersonAttendance$personAttendance> personAttendance;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$personAttendance = personAttendance;
    _resultData['personAttendance'] = l$personAttendance
        .map((e) => e.toJson())
        .toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$personAttendance = personAttendance;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$personAttendance.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$PersonAttendance || runtimeType != other.runtimeType) {
      return false;
    }
    final l$personAttendance = personAttendance;
    final lOther$personAttendance = other.personAttendance;
    if (l$personAttendance.length != lOther$personAttendance.length) {
      return false;
    }
    for (int i = 0; i < l$personAttendance.length; i++) {
      final l$personAttendance$entry = l$personAttendance[i];
      final lOther$personAttendance$entry = lOther$personAttendance[i];
      if (l$personAttendance$entry != lOther$personAttendance$entry) {
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

extension UtilityExtension$Query$PersonAttendance on Query$PersonAttendance {
  CopyWith$Query$PersonAttendance<Query$PersonAttendance> get copyWith =>
      CopyWith$Query$PersonAttendance(this, (i) => i);
}

abstract class CopyWith$Query$PersonAttendance<TRes> {
  factory CopyWith$Query$PersonAttendance(
    Query$PersonAttendance instance,
    TRes Function(Query$PersonAttendance) then,
  ) = _CopyWithImpl$Query$PersonAttendance;

  factory CopyWith$Query$PersonAttendance.stub(TRes res) =
      _CopyWithStubImpl$Query$PersonAttendance;

  TRes call({
    List<Query$PersonAttendance$personAttendance>? personAttendance,
    String? $__typename,
  });
  TRes personAttendance(
    Iterable<Query$PersonAttendance$personAttendance> Function(
      Iterable<
        CopyWith$Query$PersonAttendance$personAttendance<
          Query$PersonAttendance$personAttendance
        >
      >,
    )
    _fn,
  );
}

class _CopyWithImpl$Query$PersonAttendance<TRes>
    implements CopyWith$Query$PersonAttendance<TRes> {
  _CopyWithImpl$Query$PersonAttendance(this._instance, this._then);

  final Query$PersonAttendance _instance;

  final TRes Function(Query$PersonAttendance) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? personAttendance = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$PersonAttendance(
      personAttendance:
          personAttendance == _undefined || personAttendance == null
          ? _instance.personAttendance
          : (personAttendance as List<Query$PersonAttendance$personAttendance>),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  TRes personAttendance(
    Iterable<Query$PersonAttendance$personAttendance> Function(
      Iterable<
        CopyWith$Query$PersonAttendance$personAttendance<
          Query$PersonAttendance$personAttendance
        >
      >,
    )
    _fn,
  ) => call(
    personAttendance: _fn(
      _instance.personAttendance.map(
        (e) => CopyWith$Query$PersonAttendance$personAttendance(e, (i) => i),
      ),
    ).toList(),
  );
}

class _CopyWithStubImpl$Query$PersonAttendance<TRes>
    implements CopyWith$Query$PersonAttendance<TRes> {
  _CopyWithStubImpl$Query$PersonAttendance(this._res);

  TRes _res;

  call({
    List<Query$PersonAttendance$personAttendance>? personAttendance,
    String? $__typename,
  }) => _res;

  personAttendance(_fn) => _res;
}

const documentNodeQueryPersonAttendance = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'PersonAttendance'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'personId')),
          type: NamedTypeNode(name: NameNode(value: 'ID'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'personAttendance'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'personId'),
                value: VariableNode(name: NameNode(value: 'personId')),
              ),
              ArgumentNode(
                name: NameNode(value: 'limit'),
                value: IntValueNode(value: '20'),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'eventId'),
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
                  name: NameNode(value: 'opponent'),
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
                  name: NameNode(value: 'status'),
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

class Query$PersonAttendance$personAttendance {
  Query$PersonAttendance$personAttendance({
    required this.eventId,
    required this.startsAt,
    required this.kind,
    this.title,
    this.opponent,
    required this.teamName,
    required this.status,
    this.$__typename = 'PersonAttendance',
  });

  factory Query$PersonAttendance$personAttendance.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$eventId = json['eventId'];
    final l$startsAt = json['startsAt'];
    final l$kind = json['kind'];
    final l$title = json['title'];
    final l$opponent = json['opponent'];
    final l$teamName = json['teamName'];
    final l$status = json['status'];
    final l$$__typename = json['__typename'];
    return Query$PersonAttendance$personAttendance(
      eventId: (l$eventId as String),
      startsAt: (l$startsAt as String),
      kind: fromJson$Enum$EventKind((l$kind as String)),
      title: (l$title as String?),
      opponent: (l$opponent as String?),
      teamName: (l$teamName as String),
      status: fromJson$Enum$AttendanceStatus((l$status as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String eventId;

  final String startsAt;

  final Enum$EventKind kind;

  final String? title;

  final String? opponent;

  final String teamName;

  final Enum$AttendanceStatus status;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$eventId = eventId;
    _resultData['eventId'] = l$eventId;
    final l$startsAt = startsAt;
    _resultData['startsAt'] = l$startsAt;
    final l$kind = kind;
    _resultData['kind'] = toJson$Enum$EventKind(l$kind);
    final l$title = title;
    _resultData['title'] = l$title;
    final l$opponent = opponent;
    _resultData['opponent'] = l$opponent;
    final l$teamName = teamName;
    _resultData['teamName'] = l$teamName;
    final l$status = status;
    _resultData['status'] = toJson$Enum$AttendanceStatus(l$status);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$eventId = eventId;
    final l$startsAt = startsAt;
    final l$kind = kind;
    final l$title = title;
    final l$opponent = opponent;
    final l$teamName = teamName;
    final l$status = status;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$eventId,
      l$startsAt,
      l$kind,
      l$title,
      l$opponent,
      l$teamName,
      l$status,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$PersonAttendance$personAttendance ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$eventId = eventId;
    final lOther$eventId = other.eventId;
    if (l$eventId != lOther$eventId) {
      return false;
    }
    final l$startsAt = startsAt;
    final lOther$startsAt = other.startsAt;
    if (l$startsAt != lOther$startsAt) {
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
    final l$opponent = opponent;
    final lOther$opponent = other.opponent;
    if (l$opponent != lOther$opponent) {
      return false;
    }
    final l$teamName = teamName;
    final lOther$teamName = other.teamName;
    if (l$teamName != lOther$teamName) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) {
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

extension UtilityExtension$Query$PersonAttendance$personAttendance
    on Query$PersonAttendance$personAttendance {
  CopyWith$Query$PersonAttendance$personAttendance<
    Query$PersonAttendance$personAttendance
  >
  get copyWith =>
      CopyWith$Query$PersonAttendance$personAttendance(this, (i) => i);
}

abstract class CopyWith$Query$PersonAttendance$personAttendance<TRes> {
  factory CopyWith$Query$PersonAttendance$personAttendance(
    Query$PersonAttendance$personAttendance instance,
    TRes Function(Query$PersonAttendance$personAttendance) then,
  ) = _CopyWithImpl$Query$PersonAttendance$personAttendance;

  factory CopyWith$Query$PersonAttendance$personAttendance.stub(TRes res) =
      _CopyWithStubImpl$Query$PersonAttendance$personAttendance;

  TRes call({
    String? eventId,
    String? startsAt,
    Enum$EventKind? kind,
    String? title,
    String? opponent,
    String? teamName,
    Enum$AttendanceStatus? status,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$PersonAttendance$personAttendance<TRes>
    implements CopyWith$Query$PersonAttendance$personAttendance<TRes> {
  _CopyWithImpl$Query$PersonAttendance$personAttendance(
    this._instance,
    this._then,
  );

  final Query$PersonAttendance$personAttendance _instance;

  final TRes Function(Query$PersonAttendance$personAttendance) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? eventId = _undefined,
    Object? startsAt = _undefined,
    Object? kind = _undefined,
    Object? title = _undefined,
    Object? opponent = _undefined,
    Object? teamName = _undefined,
    Object? status = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$PersonAttendance$personAttendance(
      eventId: eventId == _undefined || eventId == null
          ? _instance.eventId
          : (eventId as String),
      startsAt: startsAt == _undefined || startsAt == null
          ? _instance.startsAt
          : (startsAt as String),
      kind: kind == _undefined || kind == null
          ? _instance.kind
          : (kind as Enum$EventKind),
      title: title == _undefined ? _instance.title : (title as String?),
      opponent: opponent == _undefined
          ? _instance.opponent
          : (opponent as String?),
      teamName: teamName == _undefined || teamName == null
          ? _instance.teamName
          : (teamName as String),
      status: status == _undefined || status == null
          ? _instance.status
          : (status as Enum$AttendanceStatus),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$PersonAttendance$personAttendance<TRes>
    implements CopyWith$Query$PersonAttendance$personAttendance<TRes> {
  _CopyWithStubImpl$Query$PersonAttendance$personAttendance(this._res);

  TRes _res;

  call({
    String? eventId,
    String? startsAt,
    Enum$EventKind? kind,
    String? title,
    String? opponent,
    String? teamName,
    Enum$AttendanceStatus? status,
    String? $__typename,
  }) => _res;
}
