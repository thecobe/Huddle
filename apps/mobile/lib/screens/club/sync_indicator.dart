import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../offline/sync_providers.dart';
import '../../ui/l10n_ext.dart';

/// Icona nella barra: nuvola barrata con il numero di modifiche da inviare; un tocco forza l'invio.
class SyncIndicator extends ConsumerWidget {
  const SyncIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final pending = ref.watch(pendingChangesProvider).value ?? 0;
    if (pending == 0) return const SizedBox.shrink();
    return IconButton(
      tooltip: l.pendingChanges(pending),
      onPressed: () => ref.read(attendanceSyncProvider).trigger(),
      icon: Badge(label: Text('$pending'), child: const Icon(Icons.cloud_off_outlined)),
    );
  }
}
