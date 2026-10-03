import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'offline_database.g.dart';

// Database locale per l'appello senza rete. Contiene solo il minimo (D9): eventi dei prossimi giorni delle
// proprie squadre, nome e maglia degli atleti, appelli non ancora inviati. Niente recapiti né dati sanitari.
// Viene svuotato al logout e al cambio di account.

/// Eventi delle proprie squadre (finestra: da 2 giorni fa a 7 giorni avanti).
class CachedEvents extends Table {
  TextColumn get id => text()();
  TextColumn get teamId => text()();
  TextColumn get teamName => text()();
  TextColumn get kind => text()();
  TextColumn get title => text().nullable()();
  TextColumn get opponent => text().nullable()();
  DateTimeColumn get startsAt => dateTime()();
  DateTimeColumn get endsAt => dateTime()();
  BoolColumn get cancelled => boolean()();
  BoolColumn get editable => boolean()();
  DateTimeColumn get completedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Rosa dell'evento come l'ha restituita il server, con lo stato registrato e l'eventuale assenza annunciata.
class CachedPlayers extends Table {
  TextColumn get eventId => text()();
  TextColumn get personId => text()();
  TextColumn get firstName => text()();
  TextColumn get lastName => text()();
  IntColumn get jerseyNumber => integer().nullable()();
  TextColumn get serverStatus => text().nullable()();
  TextColumn get serverNote => text().nullable()();
  TextColumn get noticeReason => text().nullable()();
  BoolColumn get hasNotice => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {eventId, personId};
}

/// Ultima modifica locale per atleta: è quella mostrata finché il server non conferma.
class LocalAttendance extends Table {
  TextColumn get eventId => text()();
  TextColumn get personId => text()();
  TextColumn get status => text()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get recordedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {eventId, personId};
}

/// Coda delle operazioni da inviare. `kind`: 'attendance' (una riga di appello) o 'complete' (conferma appello).
class Outbox extends Table {
  TextColumn get clientMutationId => text()();
  TextColumn get kind => text()();
  TextColumn get eventId => text()();
  TextColumn get personId => text().nullable()();
  TextColumn get status => text().nullable()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get recordedAt => dateTime()();
  IntColumn get attempts => integer().withDefault(const Constant(0))();
  TextColumn get rejectedCode => text().nullable()();

  @override
  Set<Column> get primaryKey => {clientMutationId};
}

/// Proprietario dei dati locali: se cambia account, il database viene svuotato.
class Meta extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}

@DriftDatabase(tables: [CachedEvents, CachedPlayers, LocalAttendance, Outbox, Meta])
class OfflineDatabase extends _$OfflineDatabase {
  OfflineDatabase([QueryExecutor? executor]) : super(executor ?? driftDatabase(name: 'huddle_offline'));

  @override
  int get schemaVersion => 1;

  /// Cancella tutto (logout o cambio account).
  Future<void> clearAll() => transaction(() async {
        for (final table in allTables) {
          await delete(table).go();
        }
      });

  Future<String?> owner() async =>
      (await (select(meta)..where((m) => m.key.equals('owner'))).getSingleOrNull())?.value;

  Future<void> setOwner(String userId) =>
      into(meta).insertOnConflictUpdate(MetaCompanion.insert(key: 'owner', value: userId));
}
