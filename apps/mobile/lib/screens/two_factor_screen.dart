import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/session.dart';
import '../ui/l10n_ext.dart';
import 'widgets.dart';

class TwoFactorScreen extends ConsumerStatefulWidget {
  const TwoFactorScreen({super.key});

  @override
  ConsumerState<TwoFactorScreen> createState() => _TwoFactorScreenState();
}

class _TwoFactorScreenState extends ConsumerState<TwoFactorScreen> {
  final _code = TextEditingController();
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l = context.l10n;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ref.read(sessionProvider.notifier).verifyTwoFactor(_code.text);
    } catch (e) {
      _error = errorMessage(l, e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return AuthScaffold(
      title: l.twoFactorTitle,
      subtitle: l.twoFactorHint,
      children: [
        ErrorBanner(_error),
        TextField(
          controller: _code,
          autofocus: true,
          keyboardType: TextInputType.number,
          autofillHints: const [AutofillHints.oneTimeCode],
          decoration: InputDecoration(labelText: l.code),
          onSubmitted: (_) => _submit(),
        ),
        const SizedBox(height: 24),
        BusyButton(label: l.verify, busy: _busy, onPressed: _submit),
      ],
    );
  }
}
