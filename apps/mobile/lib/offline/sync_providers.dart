import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/session.dart';
import 'attendance_repository.dart';
import 'attendance_sync.dart';

final attendanceSyncProvider = Provider<AttendanceSync>((ref) {
  final sync = AttendanceSync(ref.read(attendanceRepositoryProvider));
  ref.onDispose(sync.stop);
  return sync;
});

final pendingChangesProvider = StreamProvider<int>((ref) => ref.watch(attendanceRepositoryProvider).watchPendingCount());

/// Collega i dati offline alla sessione: all'accesso li associa all'utente, avvia l'invio della coda e
/// precarica gli appelli; al logout li cancella (D9).
void bindOfflineToSession(WidgetRef ref) {
  var started = false;
  ref.listenManual<String?>(sessionProvider.select((s) => s.user?.id), (previous, userId) async {
    final repo = ref.read(attendanceRepositoryProvider);
    final sync = ref.read(attendanceSyncProvider);
    if (userId == null) {
      if (previous != null) await repo.clear();
      return;
    }
    await repo.claim(userId);
    if (!started) {
      sync.start();
      started = true;
    }
    try {
      await repo.prefetch();
    } catch (_) {
      // Senza rete si lavora con i dati già salvati.
    }
    await sync.trigger();
  }, fireImmediately: true);
}
