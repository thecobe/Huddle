import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../auth/session.dart';
import '../ui/l10n_ext.dart';
import 'widgets.dart';

/// Aperta dal link ricevuto via e-mail (huddle://auth/magic?token=…).
class MagicLinkScreen extends ConsumerStatefulWidget {
  const MagicLinkScreen({super.key, required this.token});
  final String token;

  @override
  ConsumerState<MagicLinkScreen> createState() => _MagicLinkScreenState();
}

class _MagicLinkScreenState extends ConsumerState<MagicLinkScreen> {
  String? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _consume());
  }

  Future<void> _consume() async {
    final l = context.l10n;
    try {
      await ref.read(sessionProvider.notifier).consumeMagicLink(widget.token);
      // Il redirect del router sceglie poi la destinazione (verifica 2FA, scelta società o home).
      if (mounted) context.go('/home');
    } catch (e) {
      if (mounted) setState(() => _error = errorMessage(l, e));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return AuthScaffold(
      title: l.signIn,
      children: [
        if (_error == null)
          Row(children: [
            const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)),
            const SizedBox(width: 12),
            Text(l.verifyingLink),
          ])
        else ...[
          ErrorBanner(_error),
          OutlinedButton(onPressed: () => context.go('/login'), child: Text(l.signIn)),
        ],
      ],
    );
  }
}
