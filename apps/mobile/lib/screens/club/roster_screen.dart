import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../club/club_repository.dart';
import '../../ui/l10n_ext.dart';
import '../widgets.dart';
import 'contact_actions.dart';

/// Rosa per lo staff: atleti con disponibilità e recapiti dei tutori, poi lo staff.
class RosterScreen extends ConsumerWidget {
  const RosterScreen({super.key, required this.teamId});
  final String teamId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final roster = ref.watch(rosterProvider(teamId));
    return Scaffold(
      appBar: AppBar(title: Text(roster.value?.name ?? '')),
      body: roster.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ListView(padding: const EdgeInsets.all(16), children: [ErrorBanner(errorMessage(l, e))]),
        data: (team) => RefreshIndicator(
          onRefresh: () => ref.refresh(rosterProvider(teamId).future),
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 8),
            children: [
              _Section('${l.players} (${team.players.length})'),
              for (final p in team.players)
                ExpansionTile(
                  leading: CircleAvatar(child: Text(p.jerseyNumber?.toString() ?? '–')),
                  title: Text('${p.lastName} ${p.firstName}'),
                  subtitle: availabilityLabel(l, p.availability) == null
                      ? null
                      : Text(
                          availabilityLabel(l, p.availability)!,
                          style: TextStyle(color: Theme.of(context).colorScheme.error),
                        ),
                  children: [
                    if (p.guardians.isEmpty && (p.phone != null || p.email != null))
                      ListTile(
                        title: Text('${p.firstName} ${p.lastName}'),
                        trailing: ContactActions(phone: p.phone, email: p.email),
                      ),
                    for (final g in p.guardians)
                      ListTile(
                        title: Text(g.name),
                        subtitle: Text(l.guardiansLabel),
                        trailing: ContactActions(phone: g.phone, email: g.email),
                      ),
                  ],
                ),
              _Section('${l.staff} (${team.staff.length})'),
              for (final s in team.staff)
                ListTile(
                  title: Text('${s.firstName} ${s.lastName}'),
                  subtitle: Text(s.role.label(l)),
                  trailing: ContactActions(phone: s.phone, email: s.email),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section(this.title);
  final String title;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Text(title, style: Theme.of(context).textTheme.titleSmall),
      );
}
