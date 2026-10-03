import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../club/club_repository.dart';
import '../../graphql/schema.graphql.dart';
import '../../l10n/app_localizations.dart';
import '../../ui/l10n_ext.dart';
import '../widgets.dart';

/// Titolo di un evento: titolo esplicito, "vs avversario" per le gare, altrimenti il tipo.
String eventTitle(AppLocalizations l, AgendaEvent e) => eventKindTitle(l, e.kind, e.title, e.opponent);

String eventKindTitle(AppLocalizations l, Enum$EventKind kind, String? title, String? opponent) {
  if (title != null && title.isNotEmpty) return title;
  if (kind == Enum$EventKind.MATCH && opponent != null) return l.versus(opponent);
  return kind.label(l);
}

Color teamColor(BuildContext context, String? hex) {
  final value = hex == null ? null : int.tryParse(hex.replaceFirst('#', ''), radix: 16);
  return value == null ? Theme.of(context).colorScheme.primary : Color(0xFF000000 | value);
}

/// Agenda personale: allenamenti e gare delle proprie squadre (e di quelle dei figli), eventi di società.
class AgendaTab extends ConsumerWidget {
  const AgendaTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final agenda = ref.watch(agendaProvider);
    final locale = Localizations.localeOf(context).toLanguageTag();
    return RefreshIndicator(
      onRefresh: () => ref.refresh(agendaProvider.future),
      child: agenda.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ListView(padding: const EdgeInsets.all(16), children: [ErrorBanner(errorMessage(l, e))]),
        data: (events) {
          if (events.isEmpty) return ListView(padding: const EdgeInsets.all(24), children: [Text(l.noEvents)]);
          final children = <Widget>[];
          String? lastDay;
          for (final e in events) {
            final start = DateTime.parse(e.startsAt).toLocal();
            final day = DateFormat.MMMMEEEEd(locale).format(start);
            if (day != lastDay) {
              children.add(Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 6),
                child: Text(toBeginningOfSentenceCase(day), style: Theme.of(context).textTheme.titleSmall),
              ));
              lastDay = day;
            }
            children.add(_EventTile(event: e));
          }
          return ListView(padding: const EdgeInsets.only(bottom: 24), children: children);
        },
      ),
    );
  }
}

class _EventTile extends StatelessWidget {
  const _EventTile({required this.event});
  final AgendaEvent event;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final time = DateFormat.Hm();
    final start = DateTime.parse(event.startsAt).toLocal();
    final end = DateTime.parse(event.endsAt).toLocal();
    final cancelled = event.status == Enum$EventStatus.CANCELLED;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push('/home/event/${event.id}'),
        child: Container(
          decoration: BoxDecoration(border: Border(left: BorderSide(color: teamColor(context, event.teamColor), width: 4))),
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 56,
                child: Text('${time.format(start)}\n${time.format(end)}', style: Theme.of(context).textTheme.bodySmall),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      eventTitle(l, event),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        decoration: cancelled ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    Text(
                      [event.teamName ?? l.clubWide, if (event.location != null) event.location!].join(' · '),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    if (cancelled)
                      Text(
                        [l.cancelled, if (event.cancelReason != null) event.cancelReason!].join(': '),
                        style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 12),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
