import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../ui/l10n_ext.dart';

/// Pulsanti per chiamare o scrivere con un tocco; nascosti se il recapito manca.
class ContactActions extends StatelessWidget {
  const ContactActions({super.key, this.phone, this.email});
  final String? phone;
  final String? email;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (phone != null && phone!.isNotEmpty)
          IconButton(
            tooltip: '${l.call} $phone',
            icon: const Icon(Icons.call_outlined),
            onPressed: () => launchUrl(Uri(scheme: 'tel', path: phone!.replaceAll(' ', ''))),
          ),
        if (email != null && email!.isNotEmpty)
          IconButton(
            tooltip: '${l.sendEmail} $email',
            icon: const Icon(Icons.mail_outline),
            onPressed: () => launchUrl(Uri(scheme: 'mailto', path: email)),
          ),
      ],
    );
  }
}
