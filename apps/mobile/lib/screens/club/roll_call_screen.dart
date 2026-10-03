import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/api_client.dart';
import '../../offline/attendance_repository.dart';
import '../../offline/sync_providers.dart';
import '../../ui/l10n_ext.dart';
import '../widgets.dart';
import 'sync_indicator.dart';

/// Appello: tutti presenti per impostazione predefinita (D11); un tocco alterna presente/assente,
/// tocco lungo per gli altri stati e la nota. Funziona senza rete: le modifiche vanno in coda.
class RollCallScreen extends ConsumerStatefulWidget {
  const RollCallScreen({super.key, required this.eventId});
  final String eventId;

  @override
  ConsumerState<RollCallScreen> createState() => _RollCallScreenState();
}

class _RollCallScreenState extends ConsumerState<RollCallScreen> {
  late final Stream<RollCallView?> _view = ref.read(attendanceRepositoryProvider).watch(widget.eventId);
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    try {
      await ref.read(attendanceRepositoryProvider).refresh(widget.eventId);
    } on ApiException catch (e) {
      // Senza rete si usano i dati salvati; gli altri errori si mostrano.
      if (e.code != 'NETWORK' && mounted) setState(() => _error = errorMessage(context.l10n, e));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _set(RollCallEntry e, String status, {String? note}) async {
    await ref.read(attendanceRepositoryProvider).setStatus(widget.eventId, e.personId, status, note: note ?? e.note);
    ref.read(attendanceSyncProvider).trigger();
  }

  Future<void> _more(RollCallEntry e) async {
    final l = context.l10n;
    final note = TextEditingController(text: e.note ?? '');
    final status = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('${e.firstName} ${e.lastName}', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            TextField(controller: note, decoration: InputDecoration(labelText: l.noteLabel)),
            const SizedBox(height: 12),
            for (final s in const ['PRESENT', 'ABSENT', 'EXCUSED', 'INJURED', 'LATE'])
              ListTile(
                title: Text(attendanceLabel(l, s)),
                leading: Icon(_icon(s), color: _color(context, s)),
                selected: e.status == s,
                onTap: () => Navigator.pop(context, s),
              ),
          ],
        ),
      ),
    );
    if (status != null) await _set(e, status, note: note.text.trim().isEmpty ? null : note.text.trim());
  }

  Future<void> _complete() async {
    await ref.read(attendanceRepositoryProvider).complete(widget.eventId);
    ref.read(attendanceSyncProvider).trigger();
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.rollCallDone)));
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return StreamBuilder<RollCallView?>(
      stream: _view,
      builder: (context, snapshot) {
        final view = snapshot.data;
        return Scaffold(
          appBar: AppBar(title: Text(view == null ? l.rollCall : '${l.rollCall} · ${view.event.teamName}'), actions: const [SyncIndicator()]),
          body: view == null
              ? (_loading ? const Center(child: CircularProgressIndicator()) : ListView(padding: const EdgeInsets.all(16), children: [ErrorBanner(_error ?? l.offlineNotCached)]))
              : _body(context, view),
          bottomNavigationBar: view != null && view.event.editable
              ? SafeArea(
                  minimum: const EdgeInsets.all(16),
                  child: FilledButton.icon(
                    onPressed: _complete,
                    icon: Icon(view.event.completedAt != null ? Icons.check_circle : Icons.check),
                    label: Text(view.event.completedAt != null ? l.rollCallDone : l.confirmRollCall),
                  ),
                )
              : null,
        );
      },
    );
  }

  Widget _body(BuildContext context, RollCallView view) {
    final l = context.l10n;
    final editable = view.event.editable;
    final present = view.entries.where((e) => e.status == 'PRESENT' || e.status == 'LATE').length;
    return Column(
      children: [
        if (_error != null) Padding(padding: const EdgeInsets.all(16), child: ErrorBanner(_error)),
        _RejectedBanner(),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Row(
            children: [
              Expanded(child: Text(editable ? l.rollCallHint : l.rollCallReadOnly, style: Theme.of(context).textTheme.bodySmall)),
              const SizedBox(width: 12),
              Text('$present/${view.entries.length}', style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: view.entries.length,
            itemBuilder: (context, i) {
              final e = view.entries[i];
              return ListTile(
                key: ValueKey(e.personId),
                leading: CircleAvatar(child: Text(e.jerseyNumber?.toString() ?? '–')),
                title: Text('${e.lastName} ${e.firstName}'),
                subtitle: e.hasNotice
                    ? Text(l.absenceNotice(e.noticeReason ?? ''))
                    : (e.note == null ? null : Text(e.note!)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (e.pending) const Padding(padding: EdgeInsets.only(right: 6), child: Icon(Icons.schedule, size: 16)),
                    Chip(
                      avatar: Icon(_icon(e.status), size: 18, color: _color(context, e.status)),
                      label: Text(attendanceLabel(l, e.status)),
                    ),
                  ],
                ),
                enabled: editable,
                onTap: editable ? () => _set(e, e.status == 'PRESENT' ? 'ABSENT' : 'PRESENT') : null,
                onLongPress: editable ? () => _more(e) : null,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _RejectedBanner extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    return StreamBuilder(
      stream: ref.read(attendanceRepositoryProvider).watchRejected(),
      builder: (context, snapshot) {
        final rejected = snapshot.data ?? const [];
        if (rejected.isEmpty) return const SizedBox.shrink();
        return MaterialBanner(
          content: Text('${l.rejectedChanges} ${errorMessage(l, ApiException(rejected.first.rejectedCode!))}'),
          actions: [TextButton(onPressed: () => ref.read(attendanceRepositoryProvider).dismissRejected(), child: Text(l.dismiss))],
        );
      },
    );
  }
}

IconData _icon(String status) => switch (status) {
      'PRESENT' => Icons.check_circle,
      'ABSENT' => Icons.cancel,
      'EXCUSED' => Icons.event_busy,
      'INJURED' => Icons.healing,
      'LATE' => Icons.schedule,
      _ => Icons.help_outline,
    };

Color _color(BuildContext context, String status) {
  final scheme = Theme.of(context).colorScheme;
  return switch (status) {
    'PRESENT' => scheme.primary,
    'ABSENT' => scheme.error,
    _ => scheme.tertiary,
  };
}
