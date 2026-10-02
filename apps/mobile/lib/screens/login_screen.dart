import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/session.dart';
import '../ui/l10n_ext.dart';
import 'widgets.dart';

/// Accesso con link via e-mail (predefinito per famiglie e atleti) o con password.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _usePassword = false;
  bool _busy = false;
  bool _linkSent = false;
  String? _error;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l = context.l10n;
    setState(() {
      _busy = true;
      _error = null;
    });
    final session = ref.read(sessionProvider.notifier);
    try {
      if (_usePassword) {
        await session.login(_email.text, _password.text);
      } else {
        await session.requestMagicLink(_email.text);
        _linkSent = true;
      }
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
      title: l.signIn,
      subtitle: l.tagline,
      children: [
        ErrorBanner(_error),
        if (_linkSent && !_usePassword)
          Padding(padding: const EdgeInsets.only(bottom: 16), child: Text(l.magicLinkSent)),
        TextField(
          controller: _email,
          keyboardType: TextInputType.emailAddress,
          autofillHints: const [AutofillHints.email],
          decoration: InputDecoration(labelText: l.email),
        ),
        if (_usePassword) ...[
          const SizedBox(height: 16),
          TextField(
            controller: _password,
            obscureText: true,
            autofillHints: const [AutofillHints.password],
            decoration: InputDecoration(labelText: l.password),
            onSubmitted: (_) => _submit(),
          ),
        ],
        const SizedBox(height: 24),
        BusyButton(label: _usePassword ? l.signIn : l.signInWithLink, busy: _busy, onPressed: _submit),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () => setState(() {
            _usePassword = !_usePassword;
            _error = null;
          }),
          child: Text(_usePassword ? l.signInWithLink : l.signInWithPassword),
        ),
      ],
    );
  }
}
