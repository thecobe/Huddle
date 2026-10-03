// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_database.dart';

// ignore_for_file: type=lint
class $CachedEventsTable extends CachedEvents
    with TableInfo<$CachedEventsTable, CachedEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _teamIdMeta = const VerificationMeta('teamId');
  @override
  late final GeneratedColumn<String> teamId = GeneratedColumn<String>(
    'team_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _teamNameMeta = const VerificationMeta(
    'teamName',
  );
  @override
  late final GeneratedColumn<String> teamName = GeneratedColumn<String>(
    'team_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _opponentMeta = const VerificationMeta(
    'opponent',
  );
  @override
  late final GeneratedColumn<String> opponent = GeneratedColumn<String>(
    'opponent',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startsAtMeta = const VerificationMeta(
    'startsAt',
  );
  @override
  late final GeneratedColumn<DateTime> startsAt = GeneratedColumn<DateTime>(
    'starts_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endsAtMeta = const VerificationMeta('endsAt');
  @override
  late final GeneratedColumn<DateTime> endsAt = GeneratedColumn<DateTime>(
    'ends_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cancelledMeta = const VerificationMeta(
    'cancelled',
  );
  @override
  late final GeneratedColumn<bool> cancelled = GeneratedColumn<bool>(
    'cancelled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("cancelled" IN (0, 1))',
    ),
  );
  static const VerificationMeta _editableMeta = const VerificationMeta(
    'editable',
  );
  @override
  late final GeneratedColumn<bool> editable = GeneratedColumn<bool>(
    'editable',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("editable" IN (0, 1))',
    ),
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    teamId,
    teamName,
    kind,
    title,
    opponent,
    startsAt,
    endsAt,
    cancelled,
    editable,
    completedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('team_id')) {
      context.handle(
        _teamIdMeta,
        teamId.isAcceptableOrUnknown(data['team_id']!, _teamIdMeta),
      );
    } else if (isInserting) {
      context.missing(_teamIdMeta);
    }
    if (data.containsKey('team_name')) {
      context.handle(
        _teamNameMeta,
        teamName.isAcceptableOrUnknown(data['team_name']!, _teamNameMeta),
      );
    } else if (isInserting) {
      context.missing(_teamNameMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('opponent')) {
      context.handle(
        _opponentMeta,
        opponent.isAcceptableOrUnknown(data['opponent']!, _opponentMeta),
      );
    }
    if (data.containsKey('starts_at')) {
      context.handle(
        _startsAtMeta,
        startsAt.isAcceptableOrUnknown(data['starts_at']!, _startsAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startsAtMeta);
    }
    if (data.containsKey('ends_at')) {
      context.handle(
        _endsAtMeta,
        endsAt.isAcceptableOrUnknown(data['ends_at']!, _endsAtMeta),
      );
    } else if (isInserting) {
      context.missing(_endsAtMeta);
    }
    if (data.containsKey('cancelled')) {
      context.handle(
        _cancelledMeta,
        cancelled.isAcceptableOrUnknown(data['cancelled']!, _cancelledMeta),
      );
    } else if (isInserting) {
      context.missing(_cancelledMeta);
    }
    if (data.containsKey('editable')) {
      context.handle(
        _editableMeta,
        editable.isAcceptableOrUnknown(data['editable']!, _editableMeta),
      );
    } else if (isInserting) {
      context.missing(_editableMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedEvent(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      teamId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}team_id'],
          )!,
      teamName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}team_name'],
          )!,
      kind:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}kind'],
          )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      opponent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}opponent'],
      ),
      startsAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}starts_at'],
          )!,
      endsAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}ends_at'],
          )!,
      cancelled:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}cancelled'],
          )!,
      editable:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}editable'],
          )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
    );
  }

  @override
  $CachedEventsTable createAlias(String alias) {
    return $CachedEventsTable(attachedDatabase, alias);
  }
}

class CachedEvent extends DataClass implements Insertable<CachedEvent> {
  final String id;
  final String teamId;
  final String teamName;
  final String kind;
  final String? title;
  final String? opponent;
  final DateTime startsAt;
  final DateTime endsAt;
  final bool cancelled;
  final bool editable;
  final DateTime? completedAt;
  const CachedEvent({
    required this.id,
    required this.teamId,
    required this.teamName,
    required this.kind,
    this.title,
    this.opponent,
    required this.startsAt,
    required this.endsAt,
    required this.cancelled,
    required this.editable,
    this.completedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['team_id'] = Variable<String>(teamId);
    map['team_name'] = Variable<String>(teamName);
    map['kind'] = Variable<String>(kind);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || opponent != null) {
      map['opponent'] = Variable<String>(opponent);
    }
    map['starts_at'] = Variable<DateTime>(startsAt);
    map['ends_at'] = Variable<DateTime>(endsAt);
    map['cancelled'] = Variable<bool>(cancelled);
    map['editable'] = Variable<bool>(editable);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  CachedEventsCompanion toCompanion(bool nullToAbsent) {
    return CachedEventsCompanion(
      id: Value(id),
      teamId: Value(teamId),
      teamName: Value(teamName),
      kind: Value(kind),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      opponent:
          opponent == null && nullToAbsent
              ? const Value.absent()
              : Value(opponent),
      startsAt: Value(startsAt),
      endsAt: Value(endsAt),
      cancelled: Value(cancelled),
      editable: Value(editable),
      completedAt:
          completedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(completedAt),
    );
  }

  factory CachedEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedEvent(
      id: serializer.fromJson<String>(json['id']),
      teamId: serializer.fromJson<String>(json['teamId']),
      teamName: serializer.fromJson<String>(json['teamName']),
      kind: serializer.fromJson<String>(json['kind']),
      title: serializer.fromJson<String?>(json['title']),
      opponent: serializer.fromJson<String?>(json['opponent']),
      startsAt: serializer.fromJson<DateTime>(json['startsAt']),
      endsAt: serializer.fromJson<DateTime>(json['endsAt']),
      cancelled: serializer.fromJson<bool>(json['cancelled']),
      editable: serializer.fromJson<bool>(json['editable']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'teamId': serializer.toJson<String>(teamId),
      'teamName': serializer.toJson<String>(teamName),
      'kind': serializer.toJson<String>(kind),
      'title': serializer.toJson<String?>(title),
      'opponent': serializer.toJson<String?>(opponent),
      'startsAt': serializer.toJson<DateTime>(startsAt),
      'endsAt': serializer.toJson<DateTime>(endsAt),
      'cancelled': serializer.toJson<bool>(cancelled),
      'editable': serializer.toJson<bool>(editable),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  CachedEvent copyWith({
    String? id,
    String? teamId,
    String? teamName,
    String? kind,
    Value<String?> title = const Value.absent(),
    Value<String?> opponent = const Value.absent(),
    DateTime? startsAt,
    DateTime? endsAt,
    bool? cancelled,
    bool? editable,
    Value<DateTime?> completedAt = const Value.absent(),
  }) => CachedEvent(
    id: id ?? this.id,
    teamId: teamId ?? this.teamId,
    teamName: teamName ?? this.teamName,
    kind: kind ?? this.kind,
    title: title.present ? title.value : this.title,
    opponent: opponent.present ? opponent.value : this.opponent,
    startsAt: startsAt ?? this.startsAt,
    endsAt: endsAt ?? this.endsAt,
    cancelled: cancelled ?? this.cancelled,
    editable: editable ?? this.editable,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
  );
  CachedEvent copyWithCompanion(CachedEventsCompanion data) {
    return CachedEvent(
      id: data.id.present ? data.id.value : this.id,
      teamId: data.teamId.present ? data.teamId.value : this.teamId,
      teamName: data.teamName.present ? data.teamName.value : this.teamName,
      kind: data.kind.present ? data.kind.value : this.kind,
      title: data.title.present ? data.title.value : this.title,
      opponent: data.opponent.present ? data.opponent.value : this.opponent,
      startsAt: data.startsAt.present ? data.startsAt.value : this.startsAt,
      endsAt: data.endsAt.present ? data.endsAt.value : this.endsAt,
      cancelled: data.cancelled.present ? data.cancelled.value : this.cancelled,
      editable: data.editable.present ? data.editable.value : this.editable,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedEvent(')
          ..write('id: $id, ')
          ..write('teamId: $teamId, ')
          ..write('teamName: $teamName, ')
          ..write('kind: $kind, ')
          ..write('title: $title, ')
          ..write('opponent: $opponent, ')
          ..write('startsAt: $startsAt, ')
          ..write('endsAt: $endsAt, ')
          ..write('cancelled: $cancelled, ')
          ..write('editable: $editable, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    teamId,
    teamName,
    kind,
    title,
    opponent,
    startsAt,
    endsAt,
    cancelled,
    editable,
    completedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedEvent &&
          other.id == this.id &&
          other.teamId == this.teamId &&
          other.teamName == this.teamName &&
          other.kind == this.kind &&
          other.title == this.title &&
          other.opponent == this.opponent &&
          other.startsAt == this.startsAt &&
          other.endsAt == this.endsAt &&
          other.cancelled == this.cancelled &&
          other.editable == this.editable &&
          other.completedAt == this.completedAt);
}

class CachedEventsCompanion extends UpdateCompanion<CachedEvent> {
  final Value<String> id;
  final Value<String> teamId;
  final Value<String> teamName;
  final Value<String> kind;
  final Value<String?> title;
  final Value<String?> opponent;
  final Value<DateTime> startsAt;
  final Value<DateTime> endsAt;
  final Value<bool> cancelled;
  final Value<bool> editable;
  final Value<DateTime?> completedAt;
  final Value<int> rowid;
  const CachedEventsCompanion({
    this.id = const Value.absent(),
    this.teamId = const Value.absent(),
    this.teamName = const Value.absent(),
    this.kind = const Value.absent(),
    this.title = const Value.absent(),
    this.opponent = const Value.absent(),
    this.startsAt = const Value.absent(),
    this.endsAt = const Value.absent(),
    this.cancelled = const Value.absent(),
    this.editable = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedEventsCompanion.insert({
    required String id,
    required String teamId,
    required String teamName,
    required String kind,
    this.title = const Value.absent(),
    this.opponent = const Value.absent(),
    required DateTime startsAt,
    required DateTime endsAt,
    required bool cancelled,
    required bool editable,
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       teamId = Value(teamId),
       teamName = Value(teamName),
       kind = Value(kind),
       startsAt = Value(startsAt),
       endsAt = Value(endsAt),
       cancelled = Value(cancelled),
       editable = Value(editable);
  static Insertable<CachedEvent> custom({
    Expression<String>? id,
    Expression<String>? teamId,
    Expression<String>? teamName,
    Expression<String>? kind,
    Expression<String>? title,
    Expression<String>? opponent,
    Expression<DateTime>? startsAt,
    Expression<DateTime>? endsAt,
    Expression<bool>? cancelled,
    Expression<bool>? editable,
    Expression<DateTime>? completedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (teamId != null) 'team_id': teamId,
      if (teamName != null) 'team_name': teamName,
      if (kind != null) 'kind': kind,
      if (title != null) 'title': title,
      if (opponent != null) 'opponent': opponent,
      if (startsAt != null) 'starts_at': startsAt,
      if (endsAt != null) 'ends_at': endsAt,
      if (cancelled != null) 'cancelled': cancelled,
      if (editable != null) 'editable': editable,
      if (completedAt != null) 'completed_at': completedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedEventsCompanion copyWith({
    Value<String>? id,
    Value<String>? teamId,
    Value<String>? teamName,
    Value<String>? kind,
    Value<String?>? title,
    Value<String?>? opponent,
    Value<DateTime>? startsAt,
    Value<DateTime>? endsAt,
    Value<bool>? cancelled,
    Value<bool>? editable,
    Value<DateTime?>? completedAt,
    Value<int>? rowid,
  }) {
    return CachedEventsCompanion(
      id: id ?? this.id,
      teamId: teamId ?? this.teamId,
      teamName: teamName ?? this.teamName,
      kind: kind ?? this.kind,
      title: title ?? this.title,
      opponent: opponent ?? this.opponent,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt ?? this.endsAt,
      cancelled: cancelled ?? this.cancelled,
      editable: editable ?? this.editable,
      completedAt: completedAt ?? this.completedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (teamId.present) {
      map['team_id'] = Variable<String>(teamId.value);
    }
    if (teamName.present) {
      map['team_name'] = Variable<String>(teamName.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (opponent.present) {
      map['opponent'] = Variable<String>(opponent.value);
    }
    if (startsAt.present) {
      map['starts_at'] = Variable<DateTime>(startsAt.value);
    }
    if (endsAt.present) {
      map['ends_at'] = Variable<DateTime>(endsAt.value);
    }
    if (cancelled.present) {
      map['cancelled'] = Variable<bool>(cancelled.value);
    }
    if (editable.present) {
      map['editable'] = Variable<bool>(editable.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedEventsCompanion(')
          ..write('id: $id, ')
          ..write('teamId: $teamId, ')
          ..write('teamName: $teamName, ')
          ..write('kind: $kind, ')
          ..write('title: $title, ')
          ..write('opponent: $opponent, ')
          ..write('startsAt: $startsAt, ')
          ..write('endsAt: $endsAt, ')
          ..write('cancelled: $cancelled, ')
          ..write('editable: $editable, ')
          ..write('completedAt: $completedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedPlayersTable extends CachedPlayers
    with TableInfo<$CachedPlayersTable, CachedPlayer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedPlayersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _personIdMeta = const VerificationMeta(
    'personId',
  );
  @override
  late final GeneratedColumn<String> personId = GeneratedColumn<String>(
    'person_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'first_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastNameMeta = const VerificationMeta(
    'lastName',
  );
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
    'last_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jerseyNumberMeta = const VerificationMeta(
    'jerseyNumber',
  );
  @override
  late final GeneratedColumn<int> jerseyNumber = GeneratedColumn<int>(
    'jersey_number',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serverStatusMeta = const VerificationMeta(
    'serverStatus',
  );
  @override
  late final GeneratedColumn<String> serverStatus = GeneratedColumn<String>(
    'server_status',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serverNoteMeta = const VerificationMeta(
    'serverNote',
  );
  @override
  late final GeneratedColumn<String> serverNote = GeneratedColumn<String>(
    'server_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noticeReasonMeta = const VerificationMeta(
    'noticeReason',
  );
  @override
  late final GeneratedColumn<String> noticeReason = GeneratedColumn<String>(
    'notice_reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hasNoticeMeta = const VerificationMeta(
    'hasNotice',
  );
  @override
  late final GeneratedColumn<bool> hasNotice = GeneratedColumn<bool>(
    'has_notice',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_notice" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    eventId,
    personId,
    firstName,
    lastName,
    jerseyNumber,
    serverStatus,
    serverNote,
    noticeReason,
    hasNotice,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_players';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedPlayer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('person_id')) {
      context.handle(
        _personIdMeta,
        personId.isAcceptableOrUnknown(data['person_id']!, _personIdMeta),
      );
    } else if (isInserting) {
      context.missing(_personIdMeta);
    }
    if (data.containsKey('first_name')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta),
      );
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(
        _lastNameMeta,
        lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta),
      );
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('jersey_number')) {
      context.handle(
        _jerseyNumberMeta,
        jerseyNumber.isAcceptableOrUnknown(
          data['jersey_number']!,
          _jerseyNumberMeta,
        ),
      );
    }
    if (data.containsKey('server_status')) {
      context.handle(
        _serverStatusMeta,
        serverStatus.isAcceptableOrUnknown(
          data['server_status']!,
          _serverStatusMeta,
        ),
      );
    }
    if (data.containsKey('server_note')) {
      context.handle(
        _serverNoteMeta,
        serverNote.isAcceptableOrUnknown(data['server_note']!, _serverNoteMeta),
      );
    }
    if (data.containsKey('notice_reason')) {
      context.handle(
        _noticeReasonMeta,
        noticeReason.isAcceptableOrUnknown(
          data['notice_reason']!,
          _noticeReasonMeta,
        ),
      );
    }
    if (data.containsKey('has_notice')) {
      context.handle(
        _hasNoticeMeta,
        hasNotice.isAcceptableOrUnknown(data['has_notice']!, _hasNoticeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {eventId, personId};
  @override
  CachedPlayer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedPlayer(
      eventId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}event_id'],
          )!,
      personId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}person_id'],
          )!,
      firstName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}first_name'],
          )!,
      lastName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}last_name'],
          )!,
      jerseyNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}jersey_number'],
      ),
      serverStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_status'],
      ),
      serverNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_note'],
      ),
      noticeReason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notice_reason'],
      ),
      hasNotice:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}has_notice'],
          )!,
    );
  }

  @override
  $CachedPlayersTable createAlias(String alias) {
    return $CachedPlayersTable(attachedDatabase, alias);
  }
}

class CachedPlayer extends DataClass implements Insertable<CachedPlayer> {
  final String eventId;
  final String personId;
  final String firstName;
  final String lastName;
  final int? jerseyNumber;
  final String? serverStatus;
  final String? serverNote;
  final String? noticeReason;
  final bool hasNotice;
  const CachedPlayer({
    required this.eventId,
    required this.personId,
    required this.firstName,
    required this.lastName,
    this.jerseyNumber,
    this.serverStatus,
    this.serverNote,
    this.noticeReason,
    required this.hasNotice,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['event_id'] = Variable<String>(eventId);
    map['person_id'] = Variable<String>(personId);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    if (!nullToAbsent || jerseyNumber != null) {
      map['jersey_number'] = Variable<int>(jerseyNumber);
    }
    if (!nullToAbsent || serverStatus != null) {
      map['server_status'] = Variable<String>(serverStatus);
    }
    if (!nullToAbsent || serverNote != null) {
      map['server_note'] = Variable<String>(serverNote);
    }
    if (!nullToAbsent || noticeReason != null) {
      map['notice_reason'] = Variable<String>(noticeReason);
    }
    map['has_notice'] = Variable<bool>(hasNotice);
    return map;
  }

  CachedPlayersCompanion toCompanion(bool nullToAbsent) {
    return CachedPlayersCompanion(
      eventId: Value(eventId),
      personId: Value(personId),
      firstName: Value(firstName),
      lastName: Value(lastName),
      jerseyNumber:
          jerseyNumber == null && nullToAbsent
              ? const Value.absent()
              : Value(jerseyNumber),
      serverStatus:
          serverStatus == null && nullToAbsent
              ? const Value.absent()
              : Value(serverStatus),
      serverNote:
          serverNote == null && nullToAbsent
              ? const Value.absent()
              : Value(serverNote),
      noticeReason:
          noticeReason == null && nullToAbsent
              ? const Value.absent()
              : Value(noticeReason),
      hasNotice: Value(hasNotice),
    );
  }

  factory CachedPlayer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedPlayer(
      eventId: serializer.fromJson<String>(json['eventId']),
      personId: serializer.fromJson<String>(json['personId']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      jerseyNumber: serializer.fromJson<int?>(json['jerseyNumber']),
      serverStatus: serializer.fromJson<String?>(json['serverStatus']),
      serverNote: serializer.fromJson<String?>(json['serverNote']),
      noticeReason: serializer.fromJson<String?>(json['noticeReason']),
      hasNotice: serializer.fromJson<bool>(json['hasNotice']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'eventId': serializer.toJson<String>(eventId),
      'personId': serializer.toJson<String>(personId),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'jerseyNumber': serializer.toJson<int?>(jerseyNumber),
      'serverStatus': serializer.toJson<String?>(serverStatus),
      'serverNote': serializer.toJson<String?>(serverNote),
      'noticeReason': serializer.toJson<String?>(noticeReason),
      'hasNotice': serializer.toJson<bool>(hasNotice),
    };
  }

  CachedPlayer copyWith({
    String? eventId,
    String? personId,
    String? firstName,
    String? lastName,
    Value<int?> jerseyNumber = const Value.absent(),
    Value<String?> serverStatus = const Value.absent(),
    Value<String?> serverNote = const Value.absent(),
    Value<String?> noticeReason = const Value.absent(),
    bool? hasNotice,
  }) => CachedPlayer(
    eventId: eventId ?? this.eventId,
    personId: personId ?? this.personId,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    jerseyNumber: jerseyNumber.present ? jerseyNumber.value : this.jerseyNumber,
    serverStatus: serverStatus.present ? serverStatus.value : this.serverStatus,
    serverNote: serverNote.present ? serverNote.value : this.serverNote,
    noticeReason: noticeReason.present ? noticeReason.value : this.noticeReason,
    hasNotice: hasNotice ?? this.hasNotice,
  );
  CachedPlayer copyWithCompanion(CachedPlayersCompanion data) {
    return CachedPlayer(
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      personId: data.personId.present ? data.personId.value : this.personId,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      jerseyNumber:
          data.jerseyNumber.present
              ? data.jerseyNumber.value
              : this.jerseyNumber,
      serverStatus:
          data.serverStatus.present
              ? data.serverStatus.value
              : this.serverStatus,
      serverNote:
          data.serverNote.present ? data.serverNote.value : this.serverNote,
      noticeReason:
          data.noticeReason.present
              ? data.noticeReason.value
              : this.noticeReason,
      hasNotice: data.hasNotice.present ? data.hasNotice.value : this.hasNotice,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedPlayer(')
          ..write('eventId: $eventId, ')
          ..write('personId: $personId, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('jerseyNumber: $jerseyNumber, ')
          ..write('serverStatus: $serverStatus, ')
          ..write('serverNote: $serverNote, ')
          ..write('noticeReason: $noticeReason, ')
          ..write('hasNotice: $hasNotice')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    eventId,
    personId,
    firstName,
    lastName,
    jerseyNumber,
    serverStatus,
    serverNote,
    noticeReason,
    hasNotice,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedPlayer &&
          other.eventId == this.eventId &&
          other.personId == this.personId &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.jerseyNumber == this.jerseyNumber &&
          other.serverStatus == this.serverStatus &&
          other.serverNote == this.serverNote &&
          other.noticeReason == this.noticeReason &&
          other.hasNotice == this.hasNotice);
}

class CachedPlayersCompanion extends UpdateCompanion<CachedPlayer> {
  final Value<String> eventId;
  final Value<String> personId;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<int?> jerseyNumber;
  final Value<String?> serverStatus;
  final Value<String?> serverNote;
  final Value<String?> noticeReason;
  final Value<bool> hasNotice;
  final Value<int> rowid;
  const CachedPlayersCompanion({
    this.eventId = const Value.absent(),
    this.personId = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.jerseyNumber = const Value.absent(),
    this.serverStatus = const Value.absent(),
    this.serverNote = const Value.absent(),
    this.noticeReason = const Value.absent(),
    this.hasNotice = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedPlayersCompanion.insert({
    required String eventId,
    required String personId,
    required String firstName,
    required String lastName,
    this.jerseyNumber = const Value.absent(),
    this.serverStatus = const Value.absent(),
    this.serverNote = const Value.absent(),
    this.noticeReason = const Value.absent(),
    this.hasNotice = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : eventId = Value(eventId),
       personId = Value(personId),
       firstName = Value(firstName),
       lastName = Value(lastName);
  static Insertable<CachedPlayer> custom({
    Expression<String>? eventId,
    Expression<String>? personId,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<int>? jerseyNumber,
    Expression<String>? serverStatus,
    Expression<String>? serverNote,
    Expression<String>? noticeReason,
    Expression<bool>? hasNotice,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (eventId != null) 'event_id': eventId,
      if (personId != null) 'person_id': personId,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (jerseyNumber != null) 'jersey_number': jerseyNumber,
      if (serverStatus != null) 'server_status': serverStatus,
      if (serverNote != null) 'server_note': serverNote,
      if (noticeReason != null) 'notice_reason': noticeReason,
      if (hasNotice != null) 'has_notice': hasNotice,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedPlayersCompanion copyWith({
    Value<String>? eventId,
    Value<String>? personId,
    Value<String>? firstName,
    Value<String>? lastName,
    Value<int?>? jerseyNumber,
    Value<String?>? serverStatus,
    Value<String?>? serverNote,
    Value<String?>? noticeReason,
    Value<bool>? hasNotice,
    Value<int>? rowid,
  }) {
    return CachedPlayersCompanion(
      eventId: eventId ?? this.eventId,
      personId: personId ?? this.personId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      jerseyNumber: jerseyNumber ?? this.jerseyNumber,
      serverStatus: serverStatus ?? this.serverStatus,
      serverNote: serverNote ?? this.serverNote,
      noticeReason: noticeReason ?? this.noticeReason,
      hasNotice: hasNotice ?? this.hasNotice,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (eventId.present) {
      map['event_id'] = Variable<String>(eventId.value);
    }
    if (personId.present) {
      map['person_id'] = Variable<String>(personId.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (jerseyNumber.present) {
      map['jersey_number'] = Variable<int>(jerseyNumber.value);
    }
    if (serverStatus.present) {
      map['server_status'] = Variable<String>(serverStatus.value);
    }
    if (serverNote.present) {
      map['server_note'] = Variable<String>(serverNote.value);
    }
    if (noticeReason.present) {
      map['notice_reason'] = Variable<String>(noticeReason.value);
    }
    if (hasNotice.present) {
      map['has_notice'] = Variable<bool>(hasNotice.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedPlayersCompanion(')
          ..write('eventId: $eventId, ')
          ..write('personId: $personId, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('jerseyNumber: $jerseyNumber, ')
          ..write('serverStatus: $serverStatus, ')
          ..write('serverNote: $serverNote, ')
          ..write('noticeReason: $noticeReason, ')
          ..write('hasNotice: $hasNotice, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalAttendanceTable extends LocalAttendance
    with TableInfo<$LocalAttendanceTable, LocalAttendanceData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalAttendanceTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _personIdMeta = const VerificationMeta(
    'personId',
  );
  @override
  late final GeneratedColumn<String> personId = GeneratedColumn<String>(
    'person_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recordedAtMeta = const VerificationMeta(
    'recordedAt',
  );
  @override
  late final GeneratedColumn<DateTime> recordedAt = GeneratedColumn<DateTime>(
    'recorded_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    eventId,
    personId,
    status,
    note,
    recordedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_attendance';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalAttendanceData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('person_id')) {
      context.handle(
        _personIdMeta,
        personId.isAcceptableOrUnknown(data['person_id']!, _personIdMeta),
      );
    } else if (isInserting) {
      context.missing(_personIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('recorded_at')) {
      context.handle(
        _recordedAtMeta,
        recordedAt.isAcceptableOrUnknown(data['recorded_at']!, _recordedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_recordedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {eventId, personId};
  @override
  LocalAttendanceData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalAttendanceData(
      eventId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}event_id'],
          )!,
      personId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}person_id'],
          )!,
      status:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}status'],
          )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      recordedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}recorded_at'],
          )!,
    );
  }

  @override
  $LocalAttendanceTable createAlias(String alias) {
    return $LocalAttendanceTable(attachedDatabase, alias);
  }
}

class LocalAttendanceData extends DataClass
    implements Insertable<LocalAttendanceData> {
  final String eventId;
  final String personId;
  final String status;
  final String? note;
  final DateTime recordedAt;
  const LocalAttendanceData({
    required this.eventId,
    required this.personId,
    required this.status,
    this.note,
    required this.recordedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['event_id'] = Variable<String>(eventId);
    map['person_id'] = Variable<String>(personId);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['recorded_at'] = Variable<DateTime>(recordedAt);
    return map;
  }

  LocalAttendanceCompanion toCompanion(bool nullToAbsent) {
    return LocalAttendanceCompanion(
      eventId: Value(eventId),
      personId: Value(personId),
      status: Value(status),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      recordedAt: Value(recordedAt),
    );
  }

  factory LocalAttendanceData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalAttendanceData(
      eventId: serializer.fromJson<String>(json['eventId']),
      personId: serializer.fromJson<String>(json['personId']),
      status: serializer.fromJson<String>(json['status']),
      note: serializer.fromJson<String?>(json['note']),
      recordedAt: serializer.fromJson<DateTime>(json['recordedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'eventId': serializer.toJson<String>(eventId),
      'personId': serializer.toJson<String>(personId),
      'status': serializer.toJson<String>(status),
      'note': serializer.toJson<String?>(note),
      'recordedAt': serializer.toJson<DateTime>(recordedAt),
    };
  }

  LocalAttendanceData copyWith({
    String? eventId,
    String? personId,
    String? status,
    Value<String?> note = const Value.absent(),
    DateTime? recordedAt,
  }) => LocalAttendanceData(
    eventId: eventId ?? this.eventId,
    personId: personId ?? this.personId,
    status: status ?? this.status,
    note: note.present ? note.value : this.note,
    recordedAt: recordedAt ?? this.recordedAt,
  );
  LocalAttendanceData copyWithCompanion(LocalAttendanceCompanion data) {
    return LocalAttendanceData(
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      personId: data.personId.present ? data.personId.value : this.personId,
      status: data.status.present ? data.status.value : this.status,
      note: data.note.present ? data.note.value : this.note,
      recordedAt:
          data.recordedAt.present ? data.recordedAt.value : this.recordedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalAttendanceData(')
          ..write('eventId: $eventId, ')
          ..write('personId: $personId, ')
          ..write('status: $status, ')
          ..write('note: $note, ')
          ..write('recordedAt: $recordedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(eventId, personId, status, note, recordedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalAttendanceData &&
          other.eventId == this.eventId &&
          other.personId == this.personId &&
          other.status == this.status &&
          other.note == this.note &&
          other.recordedAt == this.recordedAt);
}

class LocalAttendanceCompanion extends UpdateCompanion<LocalAttendanceData> {
  final Value<String> eventId;
  final Value<String> personId;
  final Value<String> status;
  final Value<String?> note;
  final Value<DateTime> recordedAt;
  final Value<int> rowid;
  const LocalAttendanceCompanion({
    this.eventId = const Value.absent(),
    this.personId = const Value.absent(),
    this.status = const Value.absent(),
    this.note = const Value.absent(),
    this.recordedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalAttendanceCompanion.insert({
    required String eventId,
    required String personId,
    required String status,
    this.note = const Value.absent(),
    required DateTime recordedAt,
    this.rowid = const Value.absent(),
  }) : eventId = Value(eventId),
       personId = Value(personId),
       status = Value(status),
       recordedAt = Value(recordedAt);
  static Insertable<LocalAttendanceData> custom({
    Expression<String>? eventId,
    Expression<String>? personId,
    Expression<String>? status,
    Expression<String>? note,
    Expression<DateTime>? recordedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (eventId != null) 'event_id': eventId,
      if (personId != null) 'person_id': personId,
      if (status != null) 'status': status,
      if (note != null) 'note': note,
      if (recordedAt != null) 'recorded_at': recordedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalAttendanceCompanion copyWith({
    Value<String>? eventId,
    Value<String>? personId,
    Value<String>? status,
    Value<String?>? note,
    Value<DateTime>? recordedAt,
    Value<int>? rowid,
  }) {
    return LocalAttendanceCompanion(
      eventId: eventId ?? this.eventId,
      personId: personId ?? this.personId,
      status: status ?? this.status,
      note: note ?? this.note,
      recordedAt: recordedAt ?? this.recordedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (eventId.present) {
      map['event_id'] = Variable<String>(eventId.value);
    }
    if (personId.present) {
      map['person_id'] = Variable<String>(personId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (recordedAt.present) {
      map['recorded_at'] = Variable<DateTime>(recordedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalAttendanceCompanion(')
          ..write('eventId: $eventId, ')
          ..write('personId: $personId, ')
          ..write('status: $status, ')
          ..write('note: $note, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OutboxTable extends Outbox with TableInfo<$OutboxTable, OutboxData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OutboxTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _clientMutationIdMeta = const VerificationMeta(
    'clientMutationId',
  );
  @override
  late final GeneratedColumn<String> clientMutationId = GeneratedColumn<String>(
    'client_mutation_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _personIdMeta = const VerificationMeta(
    'personId',
  );
  @override
  late final GeneratedColumn<String> personId = GeneratedColumn<String>(
    'person_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recordedAtMeta = const VerificationMeta(
    'recordedAt',
  );
  @override
  late final GeneratedColumn<DateTime> recordedAt = GeneratedColumn<DateTime>(
    'recorded_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attemptsMeta = const VerificationMeta(
    'attempts',
  );
  @override
  late final GeneratedColumn<int> attempts = GeneratedColumn<int>(
    'attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _rejectedCodeMeta = const VerificationMeta(
    'rejectedCode',
  );
  @override
  late final GeneratedColumn<String> rejectedCode = GeneratedColumn<String>(
    'rejected_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    clientMutationId,
    kind,
    eventId,
    personId,
    status,
    note,
    recordedAt,
    attempts,
    rejectedCode,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'outbox';
  @override
  VerificationContext validateIntegrity(
    Insertable<OutboxData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('client_mutation_id')) {
      context.handle(
        _clientMutationIdMeta,
        clientMutationId.isAcceptableOrUnknown(
          data['client_mutation_id']!,
          _clientMutationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_clientMutationIdMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('person_id')) {
      context.handle(
        _personIdMeta,
        personId.isAcceptableOrUnknown(data['person_id']!, _personIdMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('recorded_at')) {
      context.handle(
        _recordedAtMeta,
        recordedAt.isAcceptableOrUnknown(data['recorded_at']!, _recordedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_recordedAtMeta);
    }
    if (data.containsKey('attempts')) {
      context.handle(
        _attemptsMeta,
        attempts.isAcceptableOrUnknown(data['attempts']!, _attemptsMeta),
      );
    }
    if (data.containsKey('rejected_code')) {
      context.handle(
        _rejectedCodeMeta,
        rejectedCode.isAcceptableOrUnknown(
          data['rejected_code']!,
          _rejectedCodeMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {clientMutationId};
  @override
  OutboxData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OutboxData(
      clientMutationId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}client_mutation_id'],
          )!,
      kind:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}kind'],
          )!,
      eventId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}event_id'],
          )!,
      personId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}person_id'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      recordedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}recorded_at'],
          )!,
      attempts:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}attempts'],
          )!,
      rejectedCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rejected_code'],
      ),
    );
  }

  @override
  $OutboxTable createAlias(String alias) {
    return $OutboxTable(attachedDatabase, alias);
  }
}

class OutboxData extends DataClass implements Insertable<OutboxData> {
  final String clientMutationId;
  final String kind;
  final String eventId;
  final String? personId;
  final String? status;
  final String? note;
  final DateTime recordedAt;
  final int attempts;
  final String? rejectedCode;
  const OutboxData({
    required this.clientMutationId,
    required this.kind,
    required this.eventId,
    this.personId,
    this.status,
    this.note,
    required this.recordedAt,
    required this.attempts,
    this.rejectedCode,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['client_mutation_id'] = Variable<String>(clientMutationId);
    map['kind'] = Variable<String>(kind);
    map['event_id'] = Variable<String>(eventId);
    if (!nullToAbsent || personId != null) {
      map['person_id'] = Variable<String>(personId);
    }
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<String>(status);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['recorded_at'] = Variable<DateTime>(recordedAt);
    map['attempts'] = Variable<int>(attempts);
    if (!nullToAbsent || rejectedCode != null) {
      map['rejected_code'] = Variable<String>(rejectedCode);
    }
    return map;
  }

  OutboxCompanion toCompanion(bool nullToAbsent) {
    return OutboxCompanion(
      clientMutationId: Value(clientMutationId),
      kind: Value(kind),
      eventId: Value(eventId),
      personId:
          personId == null && nullToAbsent
              ? const Value.absent()
              : Value(personId),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      recordedAt: Value(recordedAt),
      attempts: Value(attempts),
      rejectedCode:
          rejectedCode == null && nullToAbsent
              ? const Value.absent()
              : Value(rejectedCode),
    );
  }

  factory OutboxData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OutboxData(
      clientMutationId: serializer.fromJson<String>(json['clientMutationId']),
      kind: serializer.fromJson<String>(json['kind']),
      eventId: serializer.fromJson<String>(json['eventId']),
      personId: serializer.fromJson<String?>(json['personId']),
      status: serializer.fromJson<String?>(json['status']),
      note: serializer.fromJson<String?>(json['note']),
      recordedAt: serializer.fromJson<DateTime>(json['recordedAt']),
      attempts: serializer.fromJson<int>(json['attempts']),
      rejectedCode: serializer.fromJson<String?>(json['rejectedCode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'clientMutationId': serializer.toJson<String>(clientMutationId),
      'kind': serializer.toJson<String>(kind),
      'eventId': serializer.toJson<String>(eventId),
      'personId': serializer.toJson<String?>(personId),
      'status': serializer.toJson<String?>(status),
      'note': serializer.toJson<String?>(note),
      'recordedAt': serializer.toJson<DateTime>(recordedAt),
      'attempts': serializer.toJson<int>(attempts),
      'rejectedCode': serializer.toJson<String?>(rejectedCode),
    };
  }

  OutboxData copyWith({
    String? clientMutationId,
    String? kind,
    String? eventId,
    Value<String?> personId = const Value.absent(),
    Value<String?> status = const Value.absent(),
    Value<String?> note = const Value.absent(),
    DateTime? recordedAt,
    int? attempts,
    Value<String?> rejectedCode = const Value.absent(),
  }) => OutboxData(
    clientMutationId: clientMutationId ?? this.clientMutationId,
    kind: kind ?? this.kind,
    eventId: eventId ?? this.eventId,
    personId: personId.present ? personId.value : this.personId,
    status: status.present ? status.value : this.status,
    note: note.present ? note.value : this.note,
    recordedAt: recordedAt ?? this.recordedAt,
    attempts: attempts ?? this.attempts,
    rejectedCode: rejectedCode.present ? rejectedCode.value : this.rejectedCode,
  );
  OutboxData copyWithCompanion(OutboxCompanion data) {
    return OutboxData(
      clientMutationId:
          data.clientMutationId.present
              ? data.clientMutationId.value
              : this.clientMutationId,
      kind: data.kind.present ? data.kind.value : this.kind,
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      personId: data.personId.present ? data.personId.value : this.personId,
      status: data.status.present ? data.status.value : this.status,
      note: data.note.present ? data.note.value : this.note,
      recordedAt:
          data.recordedAt.present ? data.recordedAt.value : this.recordedAt,
      attempts: data.attempts.present ? data.attempts.value : this.attempts,
      rejectedCode:
          data.rejectedCode.present
              ? data.rejectedCode.value
              : this.rejectedCode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OutboxData(')
          ..write('clientMutationId: $clientMutationId, ')
          ..write('kind: $kind, ')
          ..write('eventId: $eventId, ')
          ..write('personId: $personId, ')
          ..write('status: $status, ')
          ..write('note: $note, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('attempts: $attempts, ')
          ..write('rejectedCode: $rejectedCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    clientMutationId,
    kind,
    eventId,
    personId,
    status,
    note,
    recordedAt,
    attempts,
    rejectedCode,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OutboxData &&
          other.clientMutationId == this.clientMutationId &&
          other.kind == this.kind &&
          other.eventId == this.eventId &&
          other.personId == this.personId &&
          other.status == this.status &&
          other.note == this.note &&
          other.recordedAt == this.recordedAt &&
          other.attempts == this.attempts &&
          other.rejectedCode == this.rejectedCode);
}

class OutboxCompanion extends UpdateCompanion<OutboxData> {
  final Value<String> clientMutationId;
  final Value<String> kind;
  final Value<String> eventId;
  final Value<String?> personId;
  final Value<String?> status;
  final Value<String?> note;
  final Value<DateTime> recordedAt;
  final Value<int> attempts;
  final Value<String?> rejectedCode;
  final Value<int> rowid;
  const OutboxCompanion({
    this.clientMutationId = const Value.absent(),
    this.kind = const Value.absent(),
    this.eventId = const Value.absent(),
    this.personId = const Value.absent(),
    this.status = const Value.absent(),
    this.note = const Value.absent(),
    this.recordedAt = const Value.absent(),
    this.attempts = const Value.absent(),
    this.rejectedCode = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OutboxCompanion.insert({
    required String clientMutationId,
    required String kind,
    required String eventId,
    this.personId = const Value.absent(),
    this.status = const Value.absent(),
    this.note = const Value.absent(),
    required DateTime recordedAt,
    this.attempts = const Value.absent(),
    this.rejectedCode = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : clientMutationId = Value(clientMutationId),
       kind = Value(kind),
       eventId = Value(eventId),
       recordedAt = Value(recordedAt);
  static Insertable<OutboxData> custom({
    Expression<String>? clientMutationId,
    Expression<String>? kind,
    Expression<String>? eventId,
    Expression<String>? personId,
    Expression<String>? status,
    Expression<String>? note,
    Expression<DateTime>? recordedAt,
    Expression<int>? attempts,
    Expression<String>? rejectedCode,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (clientMutationId != null) 'client_mutation_id': clientMutationId,
      if (kind != null) 'kind': kind,
      if (eventId != null) 'event_id': eventId,
      if (personId != null) 'person_id': personId,
      if (status != null) 'status': status,
      if (note != null) 'note': note,
      if (recordedAt != null) 'recorded_at': recordedAt,
      if (attempts != null) 'attempts': attempts,
      if (rejectedCode != null) 'rejected_code': rejectedCode,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OutboxCompanion copyWith({
    Value<String>? clientMutationId,
    Value<String>? kind,
    Value<String>? eventId,
    Value<String?>? personId,
    Value<String?>? status,
    Value<String?>? note,
    Value<DateTime>? recordedAt,
    Value<int>? attempts,
    Value<String?>? rejectedCode,
    Value<int>? rowid,
  }) {
    return OutboxCompanion(
      clientMutationId: clientMutationId ?? this.clientMutationId,
      kind: kind ?? this.kind,
      eventId: eventId ?? this.eventId,
      personId: personId ?? this.personId,
      status: status ?? this.status,
      note: note ?? this.note,
      recordedAt: recordedAt ?? this.recordedAt,
      attempts: attempts ?? this.attempts,
      rejectedCode: rejectedCode ?? this.rejectedCode,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (clientMutationId.present) {
      map['client_mutation_id'] = Variable<String>(clientMutationId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<String>(eventId.value);
    }
    if (personId.present) {
      map['person_id'] = Variable<String>(personId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (recordedAt.present) {
      map['recorded_at'] = Variable<DateTime>(recordedAt.value);
    }
    if (attempts.present) {
      map['attempts'] = Variable<int>(attempts.value);
    }
    if (rejectedCode.present) {
      map['rejected_code'] = Variable<String>(rejectedCode.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OutboxCompanion(')
          ..write('clientMutationId: $clientMutationId, ')
          ..write('kind: $kind, ')
          ..write('eventId: $eventId, ')
          ..write('personId: $personId, ')
          ..write('status: $status, ')
          ..write('note: $note, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('attempts: $attempts, ')
          ..write('rejectedCode: $rejectedCode, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MetaTable extends Meta with TableInfo<$MetaTable, MetaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MetaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meta';
  @override
  VerificationContext validateIntegrity(
    Insertable<MetaData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  MetaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MetaData(
      key:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}key'],
          )!,
      value:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}value'],
          )!,
    );
  }

  @override
  $MetaTable createAlias(String alias) {
    return $MetaTable(attachedDatabase, alias);
  }
}

class MetaData extends DataClass implements Insertable<MetaData> {
  final String key;
  final String value;
  const MetaData({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  MetaCompanion toCompanion(bool nullToAbsent) {
    return MetaCompanion(key: Value(key), value: Value(value));
  }

  factory MetaData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MetaData(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  MetaData copyWith({String? key, String? value}) =>
      MetaData(key: key ?? this.key, value: value ?? this.value);
  MetaData copyWithCompanion(MetaCompanion data) {
    return MetaData(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MetaData(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MetaData && other.key == this.key && other.value == this.value);
}

class MetaCompanion extends UpdateCompanion<MetaData> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const MetaCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MetaCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<MetaData> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MetaCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return MetaCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MetaCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$OfflineDatabase extends GeneratedDatabase {
  _$OfflineDatabase(QueryExecutor e) : super(e);
  $OfflineDatabaseManager get managers => $OfflineDatabaseManager(this);
  late final $CachedEventsTable cachedEvents = $CachedEventsTable(this);
  late final $CachedPlayersTable cachedPlayers = $CachedPlayersTable(this);
  late final $LocalAttendanceTable localAttendance = $LocalAttendanceTable(
    this,
  );
  late final $OutboxTable outbox = $OutboxTable(this);
  late final $MetaTable meta = $MetaTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    cachedEvents,
    cachedPlayers,
    localAttendance,
    outbox,
    meta,
  ];
}

typedef $$CachedEventsTableCreateCompanionBuilder =
    CachedEventsCompanion Function({
      required String id,
      required String teamId,
      required String teamName,
      required String kind,
      Value<String?> title,
      Value<String?> opponent,
      required DateTime startsAt,
      required DateTime endsAt,
      required bool cancelled,
      required bool editable,
      Value<DateTime?> completedAt,
      Value<int> rowid,
    });
typedef $$CachedEventsTableUpdateCompanionBuilder =
    CachedEventsCompanion Function({
      Value<String> id,
      Value<String> teamId,
      Value<String> teamName,
      Value<String> kind,
      Value<String?> title,
      Value<String?> opponent,
      Value<DateTime> startsAt,
      Value<DateTime> endsAt,
      Value<bool> cancelled,
      Value<bool> editable,
      Value<DateTime?> completedAt,
      Value<int> rowid,
    });

class $$CachedEventsTableFilterComposer
    extends Composer<_$OfflineDatabase, $CachedEventsTable> {
  $$CachedEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get teamId => $composableBuilder(
    column: $table.teamId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get teamName => $composableBuilder(
    column: $table.teamName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get opponent => $composableBuilder(
    column: $table.opponent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startsAt => $composableBuilder(
    column: $table.startsAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endsAt => $composableBuilder(
    column: $table.endsAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get cancelled => $composableBuilder(
    column: $table.cancelled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get editable => $composableBuilder(
    column: $table.editable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedEventsTableOrderingComposer
    extends Composer<_$OfflineDatabase, $CachedEventsTable> {
  $$CachedEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get teamId => $composableBuilder(
    column: $table.teamId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get teamName => $composableBuilder(
    column: $table.teamName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get opponent => $composableBuilder(
    column: $table.opponent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startsAt => $composableBuilder(
    column: $table.startsAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endsAt => $composableBuilder(
    column: $table.endsAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get cancelled => $composableBuilder(
    column: $table.cancelled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get editable => $composableBuilder(
    column: $table.editable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedEventsTableAnnotationComposer
    extends Composer<_$OfflineDatabase, $CachedEventsTable> {
  $$CachedEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get teamId =>
      $composableBuilder(column: $table.teamId, builder: (column) => column);

  GeneratedColumn<String> get teamName =>
      $composableBuilder(column: $table.teamName, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get opponent =>
      $composableBuilder(column: $table.opponent, builder: (column) => column);

  GeneratedColumn<DateTime> get startsAt =>
      $composableBuilder(column: $table.startsAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endsAt =>
      $composableBuilder(column: $table.endsAt, builder: (column) => column);

  GeneratedColumn<bool> get cancelled =>
      $composableBuilder(column: $table.cancelled, builder: (column) => column);

  GeneratedColumn<bool> get editable =>
      $composableBuilder(column: $table.editable, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );
}

class $$CachedEventsTableTableManager
    extends
        RootTableManager<
          _$OfflineDatabase,
          $CachedEventsTable,
          CachedEvent,
          $$CachedEventsTableFilterComposer,
          $$CachedEventsTableOrderingComposer,
          $$CachedEventsTableAnnotationComposer,
          $$CachedEventsTableCreateCompanionBuilder,
          $$CachedEventsTableUpdateCompanionBuilder,
          (
            CachedEvent,
            BaseReferences<_$OfflineDatabase, $CachedEventsTable, CachedEvent>,
          ),
          CachedEvent,
          PrefetchHooks Function()
        > {
  $$CachedEventsTableTableManager(
    _$OfflineDatabase db,
    $CachedEventsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$CachedEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$CachedEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$CachedEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> teamId = const Value.absent(),
                Value<String> teamName = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> opponent = const Value.absent(),
                Value<DateTime> startsAt = const Value.absent(),
                Value<DateTime> endsAt = const Value.absent(),
                Value<bool> cancelled = const Value.absent(),
                Value<bool> editable = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedEventsCompanion(
                id: id,
                teamId: teamId,
                teamName: teamName,
                kind: kind,
                title: title,
                opponent: opponent,
                startsAt: startsAt,
                endsAt: endsAt,
                cancelled: cancelled,
                editable: editable,
                completedAt: completedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String teamId,
                required String teamName,
                required String kind,
                Value<String?> title = const Value.absent(),
                Value<String?> opponent = const Value.absent(),
                required DateTime startsAt,
                required DateTime endsAt,
                required bool cancelled,
                required bool editable,
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedEventsCompanion.insert(
                id: id,
                teamId: teamId,
                teamName: teamName,
                kind: kind,
                title: title,
                opponent: opponent,
                startsAt: startsAt,
                endsAt: endsAt,
                cancelled: cancelled,
                editable: editable,
                completedAt: completedAt,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable<$CachedEventsTable, CachedEvent>(table),
                          BaseReferences<
                            _$OfflineDatabase,
                            $CachedEventsTable,
                            CachedEvent
                          >(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$OfflineDatabase,
      $CachedEventsTable,
      CachedEvent,
      $$CachedEventsTableFilterComposer,
      $$CachedEventsTableOrderingComposer,
      $$CachedEventsTableAnnotationComposer,
      $$CachedEventsTableCreateCompanionBuilder,
      $$CachedEventsTableUpdateCompanionBuilder,
      (
        CachedEvent,
        BaseReferences<_$OfflineDatabase, $CachedEventsTable, CachedEvent>,
      ),
      CachedEvent,
      PrefetchHooks Function()
    >;
typedef $$CachedPlayersTableCreateCompanionBuilder =
    CachedPlayersCompanion Function({
      required String eventId,
      required String personId,
      required String firstName,
      required String lastName,
      Value<int?> jerseyNumber,
      Value<String?> serverStatus,
      Value<String?> serverNote,
      Value<String?> noticeReason,
      Value<bool> hasNotice,
      Value<int> rowid,
    });
typedef $$CachedPlayersTableUpdateCompanionBuilder =
    CachedPlayersCompanion Function({
      Value<String> eventId,
      Value<String> personId,
      Value<String> firstName,
      Value<String> lastName,
      Value<int?> jerseyNumber,
      Value<String?> serverStatus,
      Value<String?> serverNote,
      Value<String?> noticeReason,
      Value<bool> hasNotice,
      Value<int> rowid,
    });

class $$CachedPlayersTableFilterComposer
    extends Composer<_$OfflineDatabase, $CachedPlayersTable> {
  $$CachedPlayersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get eventId => $composableBuilder(
    column: $table.eventId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get personId => $composableBuilder(
    column: $table.personId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get jerseyNumber => $composableBuilder(
    column: $table.jerseyNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverStatus => $composableBuilder(
    column: $table.serverStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverNote => $composableBuilder(
    column: $table.serverNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get noticeReason => $composableBuilder(
    column: $table.noticeReason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasNotice => $composableBuilder(
    column: $table.hasNotice,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedPlayersTableOrderingComposer
    extends Composer<_$OfflineDatabase, $CachedPlayersTable> {
  $$CachedPlayersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get eventId => $composableBuilder(
    column: $table.eventId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get personId => $composableBuilder(
    column: $table.personId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get jerseyNumber => $composableBuilder(
    column: $table.jerseyNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverStatus => $composableBuilder(
    column: $table.serverStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverNote => $composableBuilder(
    column: $table.serverNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get noticeReason => $composableBuilder(
    column: $table.noticeReason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasNotice => $composableBuilder(
    column: $table.hasNotice,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedPlayersTableAnnotationComposer
    extends Composer<_$OfflineDatabase, $CachedPlayersTable> {
  $$CachedPlayersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get eventId =>
      $composableBuilder(column: $table.eventId, builder: (column) => column);

  GeneratedColumn<String> get personId =>
      $composableBuilder(column: $table.personId, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<int> get jerseyNumber => $composableBuilder(
    column: $table.jerseyNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get serverStatus => $composableBuilder(
    column: $table.serverStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get serverNote => $composableBuilder(
    column: $table.serverNote,
    builder: (column) => column,
  );

  GeneratedColumn<String> get noticeReason => $composableBuilder(
    column: $table.noticeReason,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get hasNotice =>
      $composableBuilder(column: $table.hasNotice, builder: (column) => column);
}

class $$CachedPlayersTableTableManager
    extends
        RootTableManager<
          _$OfflineDatabase,
          $CachedPlayersTable,
          CachedPlayer,
          $$CachedPlayersTableFilterComposer,
          $$CachedPlayersTableOrderingComposer,
          $$CachedPlayersTableAnnotationComposer,
          $$CachedPlayersTableCreateCompanionBuilder,
          $$CachedPlayersTableUpdateCompanionBuilder,
          (
            CachedPlayer,
            BaseReferences<
              _$OfflineDatabase,
              $CachedPlayersTable,
              CachedPlayer
            >,
          ),
          CachedPlayer,
          PrefetchHooks Function()
        > {
  $$CachedPlayersTableTableManager(
    _$OfflineDatabase db,
    $CachedPlayersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$CachedPlayersTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$CachedPlayersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$CachedPlayersTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> eventId = const Value.absent(),
                Value<String> personId = const Value.absent(),
                Value<String> firstName = const Value.absent(),
                Value<String> lastName = const Value.absent(),
                Value<int?> jerseyNumber = const Value.absent(),
                Value<String?> serverStatus = const Value.absent(),
                Value<String?> serverNote = const Value.absent(),
                Value<String?> noticeReason = const Value.absent(),
                Value<bool> hasNotice = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedPlayersCompanion(
                eventId: eventId,
                personId: personId,
                firstName: firstName,
                lastName: lastName,
                jerseyNumber: jerseyNumber,
                serverStatus: serverStatus,
                serverNote: serverNote,
                noticeReason: noticeReason,
                hasNotice: hasNotice,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String eventId,
                required String personId,
                required String firstName,
                required String lastName,
                Value<int?> jerseyNumber = const Value.absent(),
                Value<String?> serverStatus = const Value.absent(),
                Value<String?> serverNote = const Value.absent(),
                Value<String?> noticeReason = const Value.absent(),
                Value<bool> hasNotice = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedPlayersCompanion.insert(
                eventId: eventId,
                personId: personId,
                firstName: firstName,
                lastName: lastName,
                jerseyNumber: jerseyNumber,
                serverStatus: serverStatus,
                serverNote: serverNote,
                noticeReason: noticeReason,
                hasNotice: hasNotice,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable<$CachedPlayersTable, CachedPlayer>(table),
                          BaseReferences<
                            _$OfflineDatabase,
                            $CachedPlayersTable,
                            CachedPlayer
                          >(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedPlayersTableProcessedTableManager =
    ProcessedTableManager<
      _$OfflineDatabase,
      $CachedPlayersTable,
      CachedPlayer,
      $$CachedPlayersTableFilterComposer,
      $$CachedPlayersTableOrderingComposer,
      $$CachedPlayersTableAnnotationComposer,
      $$CachedPlayersTableCreateCompanionBuilder,
      $$CachedPlayersTableUpdateCompanionBuilder,
      (
        CachedPlayer,
        BaseReferences<_$OfflineDatabase, $CachedPlayersTable, CachedPlayer>,
      ),
      CachedPlayer,
      PrefetchHooks Function()
    >;
typedef $$LocalAttendanceTableCreateCompanionBuilder =
    LocalAttendanceCompanion Function({
      required String eventId,
      required String personId,
      required String status,
      Value<String?> note,
      required DateTime recordedAt,
      Value<int> rowid,
    });
typedef $$LocalAttendanceTableUpdateCompanionBuilder =
    LocalAttendanceCompanion Function({
      Value<String> eventId,
      Value<String> personId,
      Value<String> status,
      Value<String?> note,
      Value<DateTime> recordedAt,
      Value<int> rowid,
    });

class $$LocalAttendanceTableFilterComposer
    extends Composer<_$OfflineDatabase, $LocalAttendanceTable> {
  $$LocalAttendanceTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get eventId => $composableBuilder(
    column: $table.eventId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get personId => $composableBuilder(
    column: $table.personId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalAttendanceTableOrderingComposer
    extends Composer<_$OfflineDatabase, $LocalAttendanceTable> {
  $$LocalAttendanceTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get eventId => $composableBuilder(
    column: $table.eventId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get personId => $composableBuilder(
    column: $table.personId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalAttendanceTableAnnotationComposer
    extends Composer<_$OfflineDatabase, $LocalAttendanceTable> {
  $$LocalAttendanceTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get eventId =>
      $composableBuilder(column: $table.eventId, builder: (column) => column);

  GeneratedColumn<String> get personId =>
      $composableBuilder(column: $table.personId, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => column,
  );
}

class $$LocalAttendanceTableTableManager
    extends
        RootTableManager<
          _$OfflineDatabase,
          $LocalAttendanceTable,
          LocalAttendanceData,
          $$LocalAttendanceTableFilterComposer,
          $$LocalAttendanceTableOrderingComposer,
          $$LocalAttendanceTableAnnotationComposer,
          $$LocalAttendanceTableCreateCompanionBuilder,
          $$LocalAttendanceTableUpdateCompanionBuilder,
          (
            LocalAttendanceData,
            BaseReferences<
              _$OfflineDatabase,
              $LocalAttendanceTable,
              LocalAttendanceData
            >,
          ),
          LocalAttendanceData,
          PrefetchHooks Function()
        > {
  $$LocalAttendanceTableTableManager(
    _$OfflineDatabase db,
    $LocalAttendanceTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$LocalAttendanceTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$LocalAttendanceTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$LocalAttendanceTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> eventId = const Value.absent(),
                Value<String> personId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> recordedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalAttendanceCompanion(
                eventId: eventId,
                personId: personId,
                status: status,
                note: note,
                recordedAt: recordedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String eventId,
                required String personId,
                required String status,
                Value<String?> note = const Value.absent(),
                required DateTime recordedAt,
                Value<int> rowid = const Value.absent(),
              }) => LocalAttendanceCompanion.insert(
                eventId: eventId,
                personId: personId,
                status: status,
                note: note,
                recordedAt: recordedAt,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable<
                            $LocalAttendanceTable,
                            LocalAttendanceData
                          >(table),
                          BaseReferences<
                            _$OfflineDatabase,
                            $LocalAttendanceTable,
                            LocalAttendanceData
                          >(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalAttendanceTableProcessedTableManager =
    ProcessedTableManager<
      _$OfflineDatabase,
      $LocalAttendanceTable,
      LocalAttendanceData,
      $$LocalAttendanceTableFilterComposer,
      $$LocalAttendanceTableOrderingComposer,
      $$LocalAttendanceTableAnnotationComposer,
      $$LocalAttendanceTableCreateCompanionBuilder,
      $$LocalAttendanceTableUpdateCompanionBuilder,
      (
        LocalAttendanceData,
        BaseReferences<
          _$OfflineDatabase,
          $LocalAttendanceTable,
          LocalAttendanceData
        >,
      ),
      LocalAttendanceData,
      PrefetchHooks Function()
    >;
typedef $$OutboxTableCreateCompanionBuilder =
    OutboxCompanion Function({
      required String clientMutationId,
      required String kind,
      required String eventId,
      Value<String?> personId,
      Value<String?> status,
      Value<String?> note,
      required DateTime recordedAt,
      Value<int> attempts,
      Value<String?> rejectedCode,
      Value<int> rowid,
    });
typedef $$OutboxTableUpdateCompanionBuilder =
    OutboxCompanion Function({
      Value<String> clientMutationId,
      Value<String> kind,
      Value<String> eventId,
      Value<String?> personId,
      Value<String?> status,
      Value<String?> note,
      Value<DateTime> recordedAt,
      Value<int> attempts,
      Value<String?> rejectedCode,
      Value<int> rowid,
    });

class $$OutboxTableFilterComposer
    extends Composer<_$OfflineDatabase, $OutboxTable> {
  $$OutboxTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get clientMutationId => $composableBuilder(
    column: $table.clientMutationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eventId => $composableBuilder(
    column: $table.eventId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get personId => $composableBuilder(
    column: $table.personId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rejectedCode => $composableBuilder(
    column: $table.rejectedCode,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OutboxTableOrderingComposer
    extends Composer<_$OfflineDatabase, $OutboxTable> {
  $$OutboxTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get clientMutationId => $composableBuilder(
    column: $table.clientMutationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventId => $composableBuilder(
    column: $table.eventId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get personId => $composableBuilder(
    column: $table.personId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rejectedCode => $composableBuilder(
    column: $table.rejectedCode,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OutboxTableAnnotationComposer
    extends Composer<_$OfflineDatabase, $OutboxTable> {
  $$OutboxTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get clientMutationId => $composableBuilder(
    column: $table.clientMutationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get eventId =>
      $composableBuilder(column: $table.eventId, builder: (column) => column);

  GeneratedColumn<String> get personId =>
      $composableBuilder(column: $table.personId, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get attempts =>
      $composableBuilder(column: $table.attempts, builder: (column) => column);

  GeneratedColumn<String> get rejectedCode => $composableBuilder(
    column: $table.rejectedCode,
    builder: (column) => column,
  );
}

class $$OutboxTableTableManager
    extends
        RootTableManager<
          _$OfflineDatabase,
          $OutboxTable,
          OutboxData,
          $$OutboxTableFilterComposer,
          $$OutboxTableOrderingComposer,
          $$OutboxTableAnnotationComposer,
          $$OutboxTableCreateCompanionBuilder,
          $$OutboxTableUpdateCompanionBuilder,
          (
            OutboxData,
            BaseReferences<_$OfflineDatabase, $OutboxTable, OutboxData>,
          ),
          OutboxData,
          PrefetchHooks Function()
        > {
  $$OutboxTableTableManager(_$OfflineDatabase db, $OutboxTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$OutboxTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$OutboxTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$OutboxTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> clientMutationId = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String> eventId = const Value.absent(),
                Value<String?> personId = const Value.absent(),
                Value<String?> status = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> recordedAt = const Value.absent(),
                Value<int> attempts = const Value.absent(),
                Value<String?> rejectedCode = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OutboxCompanion(
                clientMutationId: clientMutationId,
                kind: kind,
                eventId: eventId,
                personId: personId,
                status: status,
                note: note,
                recordedAt: recordedAt,
                attempts: attempts,
                rejectedCode: rejectedCode,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String clientMutationId,
                required String kind,
                required String eventId,
                Value<String?> personId = const Value.absent(),
                Value<String?> status = const Value.absent(),
                Value<String?> note = const Value.absent(),
                required DateTime recordedAt,
                Value<int> attempts = const Value.absent(),
                Value<String?> rejectedCode = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OutboxCompanion.insert(
                clientMutationId: clientMutationId,
                kind: kind,
                eventId: eventId,
                personId: personId,
                status: status,
                note: note,
                recordedAt: recordedAt,
                attempts: attempts,
                rejectedCode: rejectedCode,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable<$OutboxTable, OutboxData>(table),
                          BaseReferences<
                            _$OfflineDatabase,
                            $OutboxTable,
                            OutboxData
                          >(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OutboxTableProcessedTableManager =
    ProcessedTableManager<
      _$OfflineDatabase,
      $OutboxTable,
      OutboxData,
      $$OutboxTableFilterComposer,
      $$OutboxTableOrderingComposer,
      $$OutboxTableAnnotationComposer,
      $$OutboxTableCreateCompanionBuilder,
      $$OutboxTableUpdateCompanionBuilder,
      (OutboxData, BaseReferences<_$OfflineDatabase, $OutboxTable, OutboxData>),
      OutboxData,
      PrefetchHooks Function()
    >;
typedef $$MetaTableCreateCompanionBuilder =
    MetaCompanion Function({
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$MetaTableUpdateCompanionBuilder =
    MetaCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

class $$MetaTableFilterComposer
    extends Composer<_$OfflineDatabase, $MetaTable> {
  $$MetaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MetaTableOrderingComposer
    extends Composer<_$OfflineDatabase, $MetaTable> {
  $$MetaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MetaTableAnnotationComposer
    extends Composer<_$OfflineDatabase, $MetaTable> {
  $$MetaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$MetaTableTableManager
    extends
        RootTableManager<
          _$OfflineDatabase,
          $MetaTable,
          MetaData,
          $$MetaTableFilterComposer,
          $$MetaTableOrderingComposer,
          $$MetaTableAnnotationComposer,
          $$MetaTableCreateCompanionBuilder,
          $$MetaTableUpdateCompanionBuilder,
          (MetaData, BaseReferences<_$OfflineDatabase, $MetaTable, MetaData>),
          MetaData,
          PrefetchHooks Function()
        > {
  $$MetaTableTableManager(_$OfflineDatabase db, $MetaTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$MetaTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$MetaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$MetaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MetaCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => MetaCompanion.insert(key: key, value: value, rowid: rowid),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable<$MetaTable, MetaData>(table),
                          BaseReferences<
                            _$OfflineDatabase,
                            $MetaTable,
                            MetaData
                          >(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MetaTableProcessedTableManager =
    ProcessedTableManager<
      _$OfflineDatabase,
      $MetaTable,
      MetaData,
      $$MetaTableFilterComposer,
      $$MetaTableOrderingComposer,
      $$MetaTableAnnotationComposer,
      $$MetaTableCreateCompanionBuilder,
      $$MetaTableUpdateCompanionBuilder,
      (MetaData, BaseReferences<_$OfflineDatabase, $MetaTable, MetaData>),
      MetaData,
      PrefetchHooks Function()
    >;

class $OfflineDatabaseManager {
  final _$OfflineDatabase _db;
  $OfflineDatabaseManager(this._db);
  $$CachedEventsTableTableManager get cachedEvents =>
      $$CachedEventsTableTableManager(_db, _db.cachedEvents);
  $$CachedPlayersTableTableManager get cachedPlayers =>
      $$CachedPlayersTableTableManager(_db, _db.cachedPlayers);
  $$LocalAttendanceTableTableManager get localAttendance =>
      $$LocalAttendanceTableTableManager(_db, _db.localAttendance);
  $$OutboxTableTableManager get outbox =>
      $$OutboxTableTableManager(_db, _db.outbox);
  $$MetaTableTableManager get meta => $$MetaTableTableManager(_db, _db.meta);
}
