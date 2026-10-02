import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../api/models.dart';
import '../auth/session.dart';
import '../ui/l10n_ext.dart';
import 'widgets.dart';

/// Accettazione invito dall'app: per le famiglie basta il nome, senza password.
class AcceptInvitationScreen extends ConsumerStatefulWidget {
  const AcceptInvitationScreen({super.key, required this.token});
  final String token;

  @override
  ConsumerState<AcceptInvitationScreen> createState() => _AcceptInvitationScreenState();
}

class _AcceptInvitationScreenState extends ConsumerState<AcceptInvitationScreen> {
  late final Future<InvitationPreview> _preview =
      ref.read(sessionProvider.notifier).invitationPreview(widget.token);
  final _name = TextEditingController();
  bool _accepted = false;
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _submit(InvitationPreview invitation) async {
    final l = context.l10n;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ref.read(sessionProvider.notifier).acceptInvitation(
            token: widget.token,
            clubId: invitation.clubId,
            fullName: invitation.accountExists ? null : _name.text.trim(),
          );
      if (mounted) context.go('/home');
    } catch (e) {
      _error = errorMessage(l, e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return FutureBuilder<InvitationPreview>(
      future: _preview,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasError) {
          return AuthScaffold(title: l.invitationTitle, children: [ErrorBanner(errorMessage(l, snapshot.error!))]);
        }
        final invitation = snapshot.data!;
        final canSubmit = _accepted && (invitation.accountExists || _name.text.trim().length >= 2);
        return AuthScaffold(
          title: l.invitationTitle,
          subtitle: l.invitationBody(invitation.clubName, invitation.role?.label(l) ?? ''),
          children: [
            ErrorBanner(_error),
            if (!invitation.accountExists) ...[
              Text(invitation.email),
              const SizedBox(height: 16),
              TextField(
                controller: _name,
                autofillHints: const [AutofillHints.name],
                decoration: InputDecoration(labelText: l.fullName),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 8),
            ],
            CheckboxListTile(
              value: _accepted,
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(l.acceptTerms),
              onChanged: (v) => setState(() => _accepted = v ?? false),
            ),
            const SizedBox(height: 16),
            BusyButton(
              label: l.acceptInvitation,
              busy: _busy,
              onPressed: canSubmit ? () => _submit(invitation) : () {},
            ),
          ],
        );
      },
    );
  }
}
