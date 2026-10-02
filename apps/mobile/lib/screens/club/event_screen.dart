import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
            ],
          );
        },
      ),
    );
  }
}
