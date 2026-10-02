import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../club/club_repository.dart';
import '../../ui/l10n_ext.dart';
import '../widgets.dart';

/// Scheda "Squadra" dello staff: le squadre in cui allena o accompagna.
class TeamsTab extends ConsumerWidget {
  const TeamsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final teams = ref.watch(myTeamsProvider);
    return RefreshIndicator(
      onRefresh: () => ref.refresh(myTeamsProvider.future),
      child: teams.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ListView(padding: const EdgeInsets.all(16), children: [ErrorBanner(errorMessage(l, e))]),
        data: (list) => list.isEmpty
            ? ListView(padding: const EdgeInsets.all(24), children: [Text(l.noTeamsYet)])
            : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: list.length,
                separatorBuilder: (_, _) => const SizedBox(height: 8),
                itemBuilder: (context, i) {
                  final t = list[i];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(backgroundColor: _color(t.color, context), radius: 8),
                      title: Text(t.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text('${t.seasonName} · ${t.playerCount} ${l.players.toLowerCase()}'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.push('/home/team/${t.id}'),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

Color _color(String? hex, BuildContext context) {
  final value = hex == null ? null : int.tryParse(hex.replaceFirst('#', ''), radix: 16);
  return value == null ? Theme.of(context).colorScheme.primary : Color(0xFF000000 | value);
}
