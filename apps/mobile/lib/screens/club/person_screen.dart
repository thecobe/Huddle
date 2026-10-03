import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../club/club_repository.dart';
import '../../graphql/schema.graphql.dart';
import '../../ui/l10n_ext.dart';
import '../widgets.dart';
import 'agenda_tab.dart' show eventKindTitle;

/// Età minima per l'account di un atleta (D1). La regola vera è sul server.
const minAthleteAccountAge = 14;

/// Scheda propria o di un figlio: recapiti modificabili, squadre, attivazione dell'account del figlio.
class PersonScreen extends ConsumerStatefulWidget {
  const PersonScreen({super.key, required this.personId});
  final String personId;

  @override
  ConsumerState<PersonScreen> createState() => _PersonScreenState();
}

class _PersonScreenState extends ConsumerState<PersonScreen> {
  final _form = GlobalKey<FormState>();
  final _c = <String, TextEditingController>{
    for (final k in ['email', 'phone', 'addressLine', 'city', 'province', 'postalCode']) k: TextEditingController(),
  };
  final _inviteEmail = TextEditingController();
  String? _loadedId;
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    for (final c in _c.values) {
      c.dispose();
    }
    _inviteEmail.dispose();
    super.dispose();
  }

  void _load(MyPerson p) {
    if (_loadedId == p.id) return;
    _loadedId = p.id;
    _c['email']!.text = p.email ?? '';
    _c['phone']!.text = p.phone ?? '';
    _c['addressLine']!.text = p.addressLine ?? '';
    _c['city']!.text = p.city ?? '';
    _c['province']!.text = p.province ?? '';
    _c['postalCode']!.text = p.postalCode ?? '';
  }

  String? _v(String key) => _c[key]!.text.trim().isEmpty ? null : _c[key]!.text.trim();

  Future<void> _run(Future<void> Function() action, String successMessage) async {
    final l = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await action();
      // SnackBar: l'esito resta visibile anche se il pulsante è in fondo alla pagina.
      messenger.showSnackBar(SnackBar(content: Text(successMessage)));
      ref.invalidate(myPeopleProvider);
    } catch (e) {
      _error = errorMessage(l, e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    await _run(
      () => ref.read(clubRepositoryProvider).updateContacts(
            widget.personId,
            Input$PersonContactsInput(
              email: _v('email'),
              phone: _v('phone'),
              addressLine: _v('addressLine'),
              city: _v('city'),
              province: _v('province')?.toUpperCase(),
              postalCode: _v('postalCode'),
            ),
          ),
      context.l10n.saved,
    );
  }

  Future<void> _invite() async {
    final email = _inviteEmail.text.trim();
    await _run(
      () => ref.read(clubRepositoryProvider).inviteAthleteAccount(widget.personId, email),
      context.l10n.invitationSent(email),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final people = ref.watch(myPeopleProvider);
    final person = people.value?.where((p) => p.id == widget.personId).firstOrNull;
    if (person == null) {
      return Scaffold(
        appBar: AppBar(),
        body: people.hasError ? ErrorBanner(errorMessage(l, people.error!)) : const Center(child: CircularProgressIndicator()),
      );
    }
    _load(person);
    final text = Theme.of(context).textTheme;
    // Un figlio senza account, dai 14 anni: il tutore può attivarlo.
    final canActivate = person.guardians.isNotEmpty && !person.hasAccount && (person.age ?? 0) >= minAthleteAccountAge;

    return Scaffold(
      appBar: AppBar(title: Text('${person.firstName} ${person.lastName}')),
      body: SafeArea(
        child: Form(
          key: _form,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (person.age != null) Text(l.yearsOld(person.age!), style: text.bodyMedium),
              const SizedBox(height: 8),
              ErrorBanner(_error),
              Text(l.teamsLabel, style: text.titleSmall),
              for (final t in person.teams)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(t.teamName),
                  subtitle: Text([
                    t.seasonName,
                    if (t.asPlayer) l.athlete,
                    if (t.staffRole != null) t.staffRole!.label(l),
                    if (t.jerseyNumber != null) l.jerseyNumber(t.jerseyNumber!),
                  ].join(' · ')),
                ),
              if (person.teams.isEmpty) Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: Text(l.noTeamsYet)),
              _RecentAttendance(personId: person.id),
              const SizedBox(height: 16),
              Text(l.contacts, style: text.titleSmall),
              const SizedBox(height: 8),
              _field('email', l.email, keyboard: TextInputType.emailAddress, validator: (v) {
                if (v == null || v.trim().isEmpty) return null;
                return RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(v.trim()) ? null : l.errorBAD_USER_INPUT;
              }),
              _field('phone', l.phone, keyboard: TextInputType.phone),
              _field('addressLine', l.address),
              _field('city', l.city),
              Row(children: [
                Expanded(child: _field('province', l.province, maxLength: 2)),
                const SizedBox(width: 12),
                Expanded(child: _field('postalCode', l.postalCode, keyboard: TextInputType.number, maxLength: 5)),
              ]),
              BusyButton(label: l.save, busy: _busy, onPressed: _save),
              if (person.guardians.isNotEmpty) ...[
                const SizedBox(height: 24),
                Text(l.activateAccountTitle(person.firstName), style: text.titleSmall),
                const SizedBox(height: 8),
                if (person.hasAccount)
                  Text(l.accountActive)
                else if (canActivate) ...[
                  Text(l.activateAccountHint),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _inviteEmail,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: l.email),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(onPressed: _busy ? null : _invite, child: Text(l.activateAccount)),
                ] else
                  Text(l.errorATHLETE_TOO_YOUNG),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(String key, String label, {TextInputType? keyboard, int? maxLength, String? Function(String?)? validator}) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: TextFormField(
          controller: _c[key],
          keyboardType: keyboard,
          maxLength: maxLength,
          validator: validator,
          decoration: InputDecoration(labelText: label, counterText: ''),
        ),
      );
}

/// D10: presenze recenti della persona (o del figlio), in sola lettura.
class _RecentAttendance extends ConsumerWidget {
  const _RecentAttendance({required this.personId});
  final String personId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final items = ref.watch(attendanceHistoryProvider(personId)).value;
    if (items == null) return const SizedBox.shrink();
    final locale = Localizations.localeOf(context).toLanguageTag();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(l.recentAttendance, style: Theme.of(context).textTheme.titleSmall),
        if (items.isEmpty) Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: Text(l.noAttendanceYet)),
        for (final a in items.take(10))
          ListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            title: Text(eventKindTitle(l, a.kind, a.title, a.opponent)),
            subtitle: Text('${DateFormat.MMMEd(locale).format(DateTime.parse(a.startsAt).toLocal())} · ${a.teamName}'),
            trailing: Text(attendanceLabel(l, a.status.toJson())),
          ),
      ],
    );
  }
}
