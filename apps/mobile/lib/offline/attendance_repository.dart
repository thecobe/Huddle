import 'dart:async';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../api/api_client.dart';
import '../auth/session.dart';
import '../graphql/attendance.graphql.dart';
import '../graphql/calendar.graphql.dart';
import '../graphql/schema.graphql.dart';
import 'offline_database.dart';

final offlineDatabaseProvider = Provider<OfflineDatabase>((ref) {
  final db = OfflineDatabase();
  ref.onDispose(db.close);
  return db;
});

final attendanceRepositoryProvider = Provider<AttendanceRepository>(
  (ref) => AttendanceRepository(ref.read(offlineDatabaseProvider), ref.read(apiClientProvider)),
);

/// Stati dell'appello (stessi valori dell'enum dell'API).
abstract final class AttendanceStatus {
  static const present = 'PRESENT';
  static const absent = 'ABSENT';
  static const excused = 'EXCUSED';
  static const injured = 'INJURED';
  static const late = 'LATE';
}

class RollCallEntry {
  RollCallEntry({
    required this.personId,
    required this.firstName,
    required this.lastName,
    required this.jerseyNumber,
    required this.status,
    required this.note,
    required this.noticeReason,
    required this.hasNotice,
    required this.pending,
  });

  final String personId;
  final String firstName;
  final String lastName;
  final int? jerseyNumber;

  /// Stato mostrato: modifica locale, altrimenti dato del server, altrimenti proposta (D11: presente;
  /// giustificato se c'è un'assenza annunciata).
  final String status;
  final String? note;
  final String? noticeReason;
  final bool hasNotice;

  /// Modifica locale non ancora confermata dal server.
  final bool pending;
}

class RollCallView {
  RollCallView({required this.event, required this.entries});
  final CachedEvent event;
  final List<RollCallEntry> entries;
}

/// Appello con funzionamento offline: legge e scrive sul database locale, la coda invia al server.
class AttendanceRepository {
  AttendanceRepository(this._db, this._api);
  final OfflineDatabase _db;
  final ApiClient _api;
  final _uuid = const Uuid();

  /// Associa i dati locali all'account: se è cambiato, cancella quelli del precedente.
  Future<void> claim(String userId) async {
    final owner = await _db.owner();
    if (owner != null && owner != userId) await _db.clearAll();
    await _db.setOwner(userId);
  }

  Future<void> clear() => _db.clearAll();

  /// Precarica eventi e rose delle squadre di cui l'utente fa l'appello: da 2 giorni fa a 7 giorni avanti.
  Future<void> prefetch() async {
    final now = DateTime.now();
    final from = DateTime(now.year, now.month, now.day).subtract(const Duration(days: 2));
    final data = await _api.query(
      documentNodeQueryMyAgenda,
      variables: Variables$Query$MyAgenda(
        from: from.toUtc().toIso8601String(),
        to: from.add(const Duration(days: 9)).toUtc().toIso8601String(),
      ).toJson(),
    );
    final events = Query$MyAgenda.fromJson(data).myAgenda.where((e) => e.teamId != null && e.canEdit);
    for (final e in events) {
      try {
        await refresh(e.id);
      } on ApiException catch (err) {
        // Eventi di squadre in cui non si fa l'appello: si ignorano.
        if (err.code == 'NETWORK') rethrow;
      }
    }
  }

  /// Aggiorna dal server evento e rosa; le modifiche locali restano sovrapposte finché non vengono inviate.
  Future<void> refresh(String eventId) async {
    final data = await _api.query(documentNodeQueryRollCall, variables: Variables$Query$RollCall(eventId: eventId).toJson());
    final rc = Query$RollCall.fromJson(data).rollCall;
    await _db.transaction(() async {
      await _db.into(_db.cachedEvents).insertOnConflictUpdate(CachedEventsCompanion.insert(
            id: rc.eventId,
            teamId: rc.teamId,
            teamName: rc.teamName,
            kind: rc.kind.toJson(),
            title: Value(rc.title),
            opponent: Value(rc.opponent),
            startsAt: DateTime.parse(rc.startsAt),
            endsAt: DateTime.parse(rc.endsAt),
            cancelled: rc.cancelled,
            editable: rc.editable,
            completedAt: Value(rc.completedAt == null ? null : DateTime.parse(rc.completedAt!)),
          ));
      await (_db.delete(_db.cachedPlayers)..where((p) => p.eventId.equals(eventId))).go();
      for (final p in rc.players) {
        await _db.into(_db.cachedPlayers).insert(CachedPlayersCompanion.insert(
              eventId: eventId,
              personId: p.personId,
              firstName: p.firstName,
              lastName: p.lastName,
              jerseyNumber: Value(p.jerseyNumber),
              serverStatus: Value(p.status?.toJson()),
              serverNote: Value(p.note),
              noticeReason: Value(p.absenceNotice?.reason),
              hasNotice: Value(p.absenceNotice != null),
            ));
      }
      // Le modifiche locali già confermate dal server non servono più.
      final pending = await (_db.select(_db.outbox)..where((o) => o.eventId.equals(eventId) & o.kind.equals('attendance'))).get();
      final pendingPeople = pending.map((o) => o.personId).toSet();
      await (_db.delete(_db.localAttendance)
            ..where((l) => l.eventId.equals(eventId) & l.personId.isNotIn(pendingPeople.whereType<String>())))
          .go();
    });
  }

  /// Appello dal database locale, aggiornato a ogni modifica.
  Stream<RollCallView?> watch(String eventId) {
    final event = (_db.select(_db.cachedEvents)..where((e) => e.id.equals(eventId))).watchSingleOrNull();
    return event.asyncMap((ev) async {
      if (ev == null) return null;
      final players = await (_db.select(_db.cachedPlayers)..where((p) => p.eventId.equals(eventId))).get();
      final local = {
        for (final l in await (_db.select(_db.localAttendance)..where((l) => l.eventId.equals(eventId))).get()) l.personId: l,
      };
      final entries = players.map((p) {
        final l = local[p.personId];
        return RollCallEntry(
          personId: p.personId,
          firstName: p.firstName,
          lastName: p.lastName,
          jerseyNumber: p.jerseyNumber,
          status: l?.status ?? p.serverStatus ?? (p.hasNotice ? AttendanceStatus.excused : AttendanceStatus.present),
          note: l != null ? l.note : (p.serverNote ?? p.noticeReason),
          noticeReason: p.noticeReason,
          hasNotice: p.hasNotice,
          pending: l != null,
        );
      }).toList()
        ..sort((a, b) => (a.jerseyNumber ?? 999).compareTo(b.jerseyNumber ?? 999) != 0
            ? (a.jerseyNumber ?? 999).compareTo(b.jerseyNumber ?? 999)
            : a.lastName.compareTo(b.lastName));
      return RollCallView(event: ev, entries: entries);
    });
  }

  /// Modifica di un atleta: salvata subito in locale e accodata per l'invio.
  Future<void> setStatus(String eventId, String personId, String status, {String? note}) async {
    final now = DateTime.now();
    await _db.transaction(() async {
      await _db.into(_db.localAttendance).insertOnConflictUpdate(LocalAttendanceCompanion.insert(
            eventId: eventId,
            personId: personId,
            status: status,
            note: Value(note),
            recordedAt: now,
          ));
      await _db.into(_db.outbox).insert(OutboxCompanion.insert(
            clientMutationId: _uuid.v4(),
            kind: 'attendance',
            eventId: eventId,
            personId: Value(personId),
            status: Value(status),
            note: Value(note),
            recordedAt: now,
          ));
    });
  }

  /// Conferma l'appello (D11): chi non è stato toccato viene registrato come mostrato (presente, o
  /// giustificato con assenza annunciata), poi si accoda la conferma.
  Future<void> complete(String eventId) async {
    final view = await watch(eventId).first;
    if (view == null) return;
    final onServer = {
      for (final p in await (_db.select(_db.cachedPlayers)..where((p) => p.eventId.equals(eventId))).get())
        if (p.serverStatus != null) p.personId,
    };
    for (final e in view.entries) {
      // Senza dato sul server né modifica locale: si registra lo stato proposto.
      if (!e.pending && !onServer.contains(e.personId)) {
        await setStatus(eventId, e.personId, e.status, note: e.hasNotice ? e.noticeReason : null);
      }
    }
    await _db.into(_db.outbox).insert(OutboxCompanion.insert(
          clientMutationId: _uuid.v4(),
          kind: 'complete',
          eventId: eventId,
          recordedAt: DateTime.now(),
        ));
    await (_db.update(_db.cachedEvents)..where((e) => e.id.equals(eventId)))
        .write(CachedEventsCompanion(completedAt: Value(DateTime.now())));
  }

  Stream<int> watchPendingCount() =>
      (_db.selectOnly(_db.outbox)
            ..addColumns([_db.outbox.clientMutationId.count()])
            ..where(_db.outbox.rejectedCode.isNull()))
          .map((r) => r.read(_db.outbox.clientMutationId.count()) ?? 0)
          .watchSingle();

  Stream<List<OutboxData>> watchRejected() =>
      (_db.select(_db.outbox)..where((o) => o.rejectedCode.isNotNull())).watch();

  Future<void> dismissRejected() async {
    final rejected = await (_db.select(_db.outbox)..where((o) => o.rejectedCode.isNotNull())).get();
    await _db.transaction(() async {
      for (final r in rejected) {
        await (_db.delete(_db.outbox)..where((o) => o.clientMutationId.equals(r.clientMutationId))).go();
        if (r.personId != null) {
          await (_db.delete(_db.localAttendance)
                ..where((l) => l.eventId.equals(r.eventId) & l.personId.equals(r.personId!)))
              .go();
        }
      }
    });
  }

  /// Invia la coda. Toglie le righe con esito definitivo, segna quelle rifiutate, si ferma al primo errore di rete.
  /// Restituisce true se la coda è vuota (a parte le righe rifiutate).
  Future<bool> flush() async {
    final items = await (_db.select(_db.outbox)
          ..where((o) => o.rejectedCode.isNull())
          ..orderBy([(o) => OrderingTerm.asc(o.recordedAt)]))
        .get();
    final rows = items.where((o) => o.kind == 'attendance').toList();
    for (var i = 0; i < rows.length; i += 200) {
      final batch = rows.sublist(i, (i + 200).clamp(0, rows.length));
      final data = await _api.mutate(
        documentNodeMutationRecordAttendance,
        variables: Variables$Mutation$RecordAttendance(
          entries: [
            for (final o in batch)
              Input$AttendanceEntryInput(
                clientMutationId: o.clientMutationId,
                eventId: o.eventId,
                personId: o.personId!,
                status: fromJson$Enum$AttendanceStatus(o.status!),
                note: o.note,
                recordedAt: o.recordedAt.toUtc().toIso8601String(),
              ),
          ],
        ).toJson(),
      );
      final results = Mutation$RecordAttendance.fromJson(data).recordAttendance;
      await _db.transaction(() async {
        for (final r in results) {
          if (r.result == Enum$AttendanceResult.REJECTED) {
            await (_db.update(_db.outbox)..where((o) => o.clientMutationId.equals(r.clientMutationId)))
                .write(OutboxCompanion(rejectedCode: Value(r.code ?? 'UNKNOWN')));
          } else {
            await (_db.delete(_db.outbox)..where((o) => o.clientMutationId.equals(r.clientMutationId))).go();
          }
        }
      });
    }
    for (final o in items.where((o) => o.kind == 'complete')) {
      try {
        await _api.mutate(documentNodeMutationCompleteRollCall, variables: Variables$Mutation$CompleteRollCall(eventId: o.eventId).toJson());
        await (_db.delete(_db.outbox)..where((x) => x.clientMutationId.equals(o.clientMutationId))).go();
      } on ApiException catch (e) {
        if (e.code == 'NETWORK' || e.code == 'UNAUTHENTICATED') rethrow;
        await (_db.update(_db.outbox)..where((x) => x.clientMutationId.equals(o.clientMutationId)))
            .write(OutboxCompanion(rejectedCode: Value(e.code)));
      }
    }
    // Riallinea dal server gli eventi appena inviati.
    for (final eventId in items.map((o) => o.eventId).toSet()) {
      await refresh(eventId);
    }
    final left = await (_db.select(_db.outbox)..where((o) => o.rejectedCode.isNull())).get();
    return left.isEmpty;
  }
}
