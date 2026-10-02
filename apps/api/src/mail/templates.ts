export type MailTemplate =
  | { kind: 'magic-link'; webUrl: string; appUrl: string }
  | { kind: 'password-reset'; webUrl: string }
  | { kind: 'invitation'; clubName: string; roleLabel: string; webUrl: string; appUrl: string };

type Locale = 'it' | 'en';

const copy = {
  it: {
    'magic-link': (t: Extract<MailTemplate, { kind: 'magic-link' }>) => ({
      subject: 'Il tuo link di accesso a Huddle',
      text: `Ciao,\n\nusa questo link per accedere a Huddle. È valido 15 minuti e può essere usato una sola volta.\n\nDal browser: ${t.webUrl}\nDall'app: ${t.appUrl}\n\nSe non hai richiesto l'accesso, ignora questo messaggio.`,
    }),
    'password-reset': (t: Extract<MailTemplate, { kind: 'password-reset' }>) => ({
      subject: 'Reimposta la password di Huddle',
      text: `Ciao,\n\nper scegliere una nuova password apri questo link (valido 30 minuti):\n\n${t.webUrl}\n\nSe non hai richiesto il reset, ignora questo messaggio.`,
    }),
    invitation: (t: Extract<MailTemplate, { kind: 'invitation' }>) => ({
      subject: `Invito a ${t.clubName} su Huddle`,
      text: `Ciao,\n\n${t.clubName} ti ha invitato su Huddle con il ruolo di ${t.roleLabel}.\n\nAccetta l'invito dal browser: ${t.webUrl}\nOppure dall'app: ${t.appUrl}\n\nL'invito scade tra 7 giorni.`,
    }),
  },
  en: {
    'magic-link': (t: Extract<MailTemplate, { kind: 'magic-link' }>) => ({
      subject: 'Your Huddle sign-in link',
      text: `Hi,\n\nuse this link to sign in to Huddle. It is valid for 15 minutes and can be used once.\n\nBrowser: ${t.webUrl}\nApp: ${t.appUrl}\n\nIf you did not request it, ignore this email.`,
    }),
    'password-reset': (t: Extract<MailTemplate, { kind: 'password-reset' }>) => ({
      subject: 'Reset your Huddle password',
      text: `Hi,\n\nopen this link to choose a new password (valid for 30 minutes):\n\n${t.webUrl}\n\nIf you did not request it, ignore this email.`,
    }),
    invitation: (t: Extract<MailTemplate, { kind: 'invitation' }>) => ({
      subject: `Invitation to ${t.clubName} on Huddle`,
      text: `Hi,\n\n${t.clubName} invited you to Huddle as ${t.roleLabel}.\n\nAccept in the browser: ${t.webUrl}\nOr in the app: ${t.appUrl}\n\nThe invitation expires in 7 days.`,
    }),
  },
} as const;

export function renderMail(locale: string, template: MailTemplate): { subject: string; text: string } {
  const l: Locale = locale === 'en' ? 'en' : 'it';
  const render = copy[l][template.kind] as (t: MailTemplate) => { subject: string; text: string };
  return render(template);
}

const roleLabels: Record<Locale, Record<string, string>> = {
  it: {
    ADMIN: 'amministratore',
    SECRETARY: 'segreteria',
    SPORTS_DIRECTOR: 'direttore sportivo',
    COACH: 'allenatore',
    TEAM_MANAGER: 'dirigente accompagnatore',
    ATHLETE: 'atleta',
    PARENT: 'genitore/tutore',
  },
  en: {
    ADMIN: 'administrator',
    SECRETARY: 'secretary',
    SPORTS_DIRECTOR: 'sports director',
    COACH: 'coach',
    TEAM_MANAGER: 'team manager',
    ATHLETE: 'athlete',
    PARENT: 'parent/guardian',
  },
};

export function roleLabel(locale: string, role: string): string {
  return roleLabels[locale === 'en' ? 'en' : 'it'][role] ?? role;
}
