import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/session.dart';
import '../ui/l10n_ext.dart';

class ClubsScreen extends ConsumerWidget {
  const ClubsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final session = ref.watch(sessionProvider);
    final clubs = session.user?.clubs ?? const [];
    return Scaffold(
      appBar: AppBar(
        title: Text(l.clubsTitle),
        actions: [
          IconButton(
            tooltip: l.signOut,
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(sessionProvider.notifier).logout(),
          ),
        ],
      ),
      body: clubs.isEmpty
          ? Padding(padding: const EdgeInsets.all(24), child: Text(l.noClubs))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: clubs.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, i) {
                final club = clubs[i];
                return Card(
                  child: ListTile(
                    title: Text(club.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text(club.roles.map((r) => r.label(l)).join(' · ')),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => ref.read(sessionProvider.notifier).selectClub(club.id),
                  ),
                );
              },
            ),
    );
  }
}
