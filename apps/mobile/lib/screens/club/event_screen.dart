import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../club/club_repository.dart';
import '../../graphql/schema.graphql.dart';
import '../../ui/l10n_ext.dart';
import '../widgets.dart';
import 'agenda_tab.dart';

class EventScreen extends ConsumerWidget {
  const EventScreen({super.key, required this.eventId});
  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final event = ref.watch(eventProvider(eventId));
    final locale = Localizations.localeOf(context).toLanguageTag();
    return Scaffold(
      appBar: AppBar(title: Text(event.value == null ? '' : eventTitle(l, event.value!))),
      body: event.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ListView(padding: const EdgeInsets.all(16), children: [ErrorBanner(errorMessage(l, e))]),
        data: (e) {
          final start = DateTime.parse(e.startsAt).toLocal();
          final end = DateTime.parse(e.endsAt).toLocal();
          final text = Theme.of(context).textTheme;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(children: [
                Chip(label: Text(e.kind.label(l))),
                const SizedBox(width: 8),
                if (e.status == Enum$EventStatus.CANCELLED)
                  Chip(
                    label: Text(l.cancelled),
                    backgroundColor: Theme.of(context).colorScheme.errorContainer,
                  ),
              ]),
              const SizedBox(height: 8),
              Text(
                toBeginningOfSentenceCase(DateFormat.MMMMEEEEd(locale).format(start)),
                style: text.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              Text('${DateFormat.Hm().format(start)} – ${DateFormat.Hm().format(end)}', style: text.titleMedium),
              const SizedBox(height: 4),
              Text(e.teamName ?? l.clubWide),
              if (e.cancelReason != null) Padding(padding: const EdgeInsets.only(top: 8), child: Text(e.cancelReason!)),
              if (e.kind == Enum$EventKind.MATCH) ...[
                const SizedBox(height: 12),
                Text([
                  if (e.isHome != null) e.isHome! ? l.homeMatch : l.awayMatch,
                  if (e.competition != null) e.competition!,
                ].join(' · ')),
              ],
              if (e.location != null) ...[
                const SizedBox(height: 16),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.place_outlined),
                  title: Text(e.location!),
                  trailing: TextButton(
                    onPressed: () => launchUrl(
                      Uri.https('www.google.com', '/maps/search/', {'api': '1', 'query': e.location!}),
                      mode: LaunchMode.externalApplication,
                    ),
                    child: Text(l.openMap),
                  ),
                ),
              ],
              if (e.notes != null) ...[
                const SizedBox(height: 16),
                Text(l.notes, style: text.titleSmall),
                Text(e.notes!),
              ],
              if (_rollCallOpen(e)) ...[
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: () => context.push('/home/rollcall/${e.id}'),
                  icon: const Icon(Icons.fact_check_outlined),
                  label: Text(l.rollCall),
                ),
              ],
              if (e.teamId != null) _ParticipationSection(eventId: e.id),
            ],
          );
        },
      ),
    );
  }
}

/// D8: lo staff può fare l'appello da 2 ore prima dell'inizio a 7 giorni dopo la fine (il server ricontrolla).
bool _rollCallOpen(AgendaEvent e) {
  if (!e.canEdit || e.teamId == null || e.kind == Enum$EventKind.OTHER || e.status == Enum$EventStatus.CANCELLED) return false;
  final now = DateTime.now();
  return now.isAfter(DateTime.parse(e.startsAt).subtract(const Duration(hours: 2))) &&
      now.isBefore(DateTime.parse(e.endsAt).add(const Duration(days: 7)));
}

/// Per genitori e atleti: presenza e assenza annunciata di sé stessi e dei figli.
class _ParticipationSection extends ConsumerStatefulWidget {
  const _ParticipationSection({required this.eventId});
  final String eventId;

  @override
  ConsumerState<_ParticipationSection> createState() => _ParticipationSectionState();
}

class _ParticipationSectionState extends ConsumerState<_ParticipationSection> {
  bool _busy = false;

  Future<void> _run(Future<void> Function() action, {String? success}) async {
    final l = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _busy = true);
    try {
      await action();
      ref.invalidate(participationProvider(widget.eventId));
      if (success != null) messenger.showSnackBar(SnackBar(content: Text(success)));
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(errorMessage(l, e))));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _report(Participation p) async {
    final l = context.l10n;
    final reason = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${l.reportAbsence} · ${p.firstName}'),
        content: TextField(controller: reason, decoration: InputDecoration(labelText: l.absenceReason)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(MaterialLocalizations.of(context).cancelButtonLabel)),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(l.send)),
        ],
      ),
    );
    if (ok != true) return;
    final text = reason.text.trim();
    await _run(
      () => ref.read(clubRepositoryProvider).reportAbsence(widget.eventId, p.personId, text.isEmpty ? null : text),
      success: l.absenceReported,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final list = ref.watch(participationProvider(widget.eventId)).value ?? const [];
    if (list.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(l.participation, style: Theme.of(context).textTheme.titleSmall),
        for (final p in list)
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('${p.firstName} ${p.lastName}'),
            subtitle: p.status != null
                ? Text(attendanceLabel(l, p.status!.toJson()))
                : p.absenceNotice != null
                    ? Text(l.absenceNotice(p.absenceNotice!.reason ?? ''))
                    : null,
            trailing: !p.canReport
                ? null
                : p.absenceNotice != null
                    ? TextButton(
                        onPressed: _busy ? null : () => _run(() => ref.read(clubRepositoryProvider).withdrawAbsence(p.absenceNotice!.id)),
                        child: Text(l.withdrawAbsence),
                      )
                    : OutlinedButton(onPressed: _busy ? null : () => _report(p), child: Text(l.reportAbsence)),
          ),
      ],
    );
  }
}
