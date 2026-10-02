import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../auth/session.dart';
import '../club/club_repository.dart';
import 'club/agenda_tab.dart';
import 'club/teams_tab.dart';
import '../push/push_service.dart';
import '../ui/l10n_ext.dart';

/// Contenitore a schede. L'interfaccia si adatta ai ruoli nella società selezionata:
/// le schede operative (calendario, squadra) si popolano in Fase 1.
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _tab = 0;

  @override
  void initState() {
    super.initState();
    ref.read(pushRegistrarProvider).register().catchError((_) {});
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final session = ref.watch(sessionProvider);
    final club = session.currentClub;
    if (club == null) return const SizedBox.shrink();
    final isStaff = club.roles.any((r) => r.isStaff || r.isOffice);

    final tabs = <({IconData icon, String label, Widget body})>[
      (icon: Icons.home_outlined, label: l.home, body: _Overview(clubName: club.name)),
      (icon: Icons.calendar_month_outlined, label: l.calendar, body: const AgendaTab()),
      if (isStaff) (icon: Icons.groups_outlined, label: l.team, body: const TeamsTab()),
      (icon: Icons.person_outline, label: l.profile, body: const _Profile()),
    ];
    final index = _tab.clamp(0, tabs.length - 1);

    return Scaffold(
      appBar: AppBar(
        title: Text(club.name),
        actions: [
          if ((session.user?.clubs.length ?? 0) > 1)
            IconButton(
              tooltip: l.switchClub,
              icon: const Icon(Icons.swap_horiz),
              onPressed: () async {
                await ref.read(sessionProvider.notifier).selectClub(null);
                if (context.mounted) context.go('/clubs');
              },
            ),
        ],
      ),
      body: tabs[index].body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => setState(() => _tab = i),
        destinations: [for (final t in tabs) NavigationDestination(icon: Icon(t.icon), label: t.label)],
      ),
    );
  }
}

class _Overview extends ConsumerWidget {
  const _Overview({required this.clubName});
  final String clubName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final session = ref.watch(sessionProvider);
    final roles = session.currentClub?.roles ?? const [];
    final firstName = session.user?.fullName.split(' ').first ?? '';
    final text = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(l.welcome(firstName), style: text.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        Text(l.comingSoon, style: text.bodyMedium),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l.yourRoles, style: text.titleSmall),
                const SizedBox(height: 8),
                Wrap(spacing: 8, runSpacing: 8, children: [for (final r in roles) Chip(label: Text(r.label(l)))]),
                if (roles.any((r) => r.isOffice)) ...[
                  const SizedBox(height: 12),
                  Text(l.officeHint, style: text.bodySmall),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Profile extends ConsumerWidget {
  const _Profile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final user = ref.watch(sessionProvider).user;
    final people = ref.watch(myPeopleProvider);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ListTile(title: Text(user?.fullName ?? ''), subtitle: Text(user?.email ?? '')),
        const Divider(),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
          child: Text(l.myData, style: Theme.of(context).textTheme.titleSmall),
        ),
        ...switch (people) {
          AsyncData(:final value) => [
              for (final p in value)
                ListTile(
                  leading: const Icon(Icons.person_outline),
                  title: Text('${p.firstName} ${p.lastName}'),
                  subtitle: Text(p.teams.map((t) => t.teamName).join(', ')),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/home/person/${p.id}'),
                ),
            ],
          AsyncError(:final error) => [ListTile(title: Text(errorMessage(l, error)))],
          _ => [const Padding(padding: EdgeInsets.all(16), child: LinearProgressIndicator())],
        },
        const Divider(),
        ListTile(
          leading: const Icon(Icons.logout),
          title: Text(l.signOut),
          onTap: () async {
            await ref.read(pushRegistrarProvider).unregister();
            await ref.read(sessionProvider.notifier).logout();
          },
        ),
      ],
    );
  }
}
