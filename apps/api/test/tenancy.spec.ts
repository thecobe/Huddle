import { afterAll, beforeAll, describe, expect, it } from 'vitest';
import { createAdminWithClub, createTestApp, registerUser, type TestApp, tokenFromMail } from './helpers.js';

const INVITE = `mutation ($i: InviteMemberInput!) { inviteMember(input: $i) { id email role } }`;
const ACCEPT = `mutation ($i: AcceptInvitationInput!) { acceptInvitation(input: $i) { status accessToken user { memberships { clubId role } } } }`;

describe('società, permessi e inviti', () => {
  let t: TestApp;
  beforeAll(async () => {
    t = await createTestApp();
  });
  afterAll(() => t.app.close());

  it('l’amministratore senza 2FA deve attivarlo prima di operare sulla società', async () => {
    const u = await registerUser(t, 'no2fa');
    const created = await t.gql<{ createClub: { id: string } }>(
      `mutation { createClub(input: { name: "ASD Senza 2FA" }) { id } }`,
      {},
      { token: u.token },
    );
    const clubId = created.data!.createClub.id;
    const res = await t.gql(`{ club { name } }`, {}, { token: u.token, tenantId: clubId });
    expect(res.errors?.[0]?.extensions?.code).toBe('TWO_FACTOR_SETUP_REQUIRED');
    // Il profilo resta accessibile per completare la configurazione.
    const me = await t.gql<{ me: { memberships: { role: string }[] } }>(`{ me { memberships { role } } }`, {}, { token: u.token, tenantId: clubId });
    expect(me.data?.me.memberships[0]?.role).toBe('ADMIN');
  });

  it('un utente esterno non accede a una società altrui', async () => {
    const admin = await createAdminWithClub(t);
    const outsider = await registerUser(t, 'outsider');
    const res = await t.gql(`{ club { name } }`, {}, { token: outsider.token, tenantId: admin.clubId });
    expect(res.errors?.[0]?.extensions?.code).toBe('FORBIDDEN');
  });

  it('operazioni di società senza X-Tenant-Id', async () => {
    const admin = await createAdminWithClub(t);
    const res = await t.gql(`{ club { name } }`, {}, { token: admin.token });
    expect(res.errors?.[0]?.extensions?.code).toBe('TENANT_REQUIRED');
  });

  it('aggiorna il profilo della società con validazione', async () => {
    const admin = await createAdminWithClub(t);
    const opts = { token: admin.token, tenantId: admin.clubId };
    const bad = await t.gql(`mutation { updateClub(input: { name: "ASD", vatNumber: "123" }) { id } }`, {}, opts);
    expect(bad.errors).toBeDefined();
    const ok = await t.gql<{ updateClub: { vatNumber: string; province: string } }>(
      `mutation { updateClub(input: { name: "ASD Aggiornata", vatNumber: "01234567890", province: "mi", federations: ["FIGC", "CSI"] }) { vatNumber province federations } }`,
      {},
      opts,
    );
    expect(ok.data?.updateClub).toMatchObject({ vatNumber: '01234567890', province: 'MI' });
  });

  it('invito di un allenatore: account creato senza password, accesso limitato', async () => {
    const admin = await createAdminWithClub(t, 'ASD Inviti');
    const coachEmail = `coach.${Date.now()}@example.test`;
    const inv = await t.gql(INVITE, { i: { email: coachEmail, role: 'COACH' } }, { token: admin.token, tenantId: admin.clubId });
    expect(inv.errors).toBeUndefined();

    const token = tokenFromMail(t.mail.outbox.findLast((m) => m.to === coachEmail)!.text);
    const preview = await t.gql<{ invitationPreview: { clubName: string; accountExists: boolean } }>(
      `query ($t: String!) { invitationPreview(token: $t) { clubName role accountExists } }`,
      { t: token },
    );
    expect(preview.data?.invitationPreview).toMatchObject({ clubName: 'ASD Inviti', accountExists: false });

    const accepted = await t.gql<{ acceptInvitation: { accessToken: string; user: { memberships: { clubId: string; role: string }[] } } }>(
      ACCEPT,
      { i: { token, fullName: 'Mario Rossi', acceptTerms: true } },
    );
    const coach = accepted.data!.acceptInvitation;
    expect(coach.user.memberships).toEqual([{ clubId: admin.clubId, role: 'COACH' }]);

    const opts = { token: coach.accessToken, tenantId: admin.clubId };
    const club = await t.gql<{ club: { name: string } }>(`{ club { name } }`, {}, opts);
    expect(club.data?.club.name).toBe('ASD Inviti');
    const members = await t.gql(`{ members { email } }`, {}, opts);
    expect(members.errors?.[0]?.extensions?.code).toBe('FORBIDDEN');

    const again = await t.gql(ACCEPT, { i: { token, acceptTerms: true } });
    expect(again.errors?.[0]?.extensions?.code).toBe('INVALID_TOKEN');

    const list = await t.gql<{ members: { email: string; role: string }[] }>(`{ members { email role } }`, {}, {
      token: admin.token,
      tenantId: admin.clubId,
    });
    expect(list.data?.members.map((m) => m.role).sort()).toEqual(['ADMIN', 'COACH']);
  });

  it('la segreteria non può assegnare ruoli amministrativi', async () => {
    const admin = await createAdminWithClub(t);
    const secEmail = `sec.${Date.now()}@example.test`;
    await t.gql(INVITE, { i: { email: secEmail, role: 'SECRETARY' } }, { token: admin.token, tenantId: admin.clubId });
    const token = tokenFromMail(t.mail.outbox.findLast((m) => m.to === secEmail)!.text);
    const acc = await t.gql<{ acceptInvitation: { accessToken: string } }>(ACCEPT, {
      i: { token, fullName: 'Segreteria', password: 'password-sicura-123', acceptTerms: true },
    });
    const secToken = acc.data!.acceptInvitation.accessToken;

    // La segreteria deve attivare il 2FA prima di operare.
    const blocked = await t.gql(INVITE, { i: { email: 'x@example.test', role: 'PARENT' } }, { token: secToken, tenantId: admin.clubId });
    expect(blocked.errors?.[0]?.extensions?.code).toBe('TWO_FACTOR_SETUP_REQUIRED');

    const { enableTwoFactor } = await import('./helpers.js');
    await enableTwoFactor(t, secToken);
    const parent = await t.gql(INVITE, { i: { email: `p.${Date.now()}@example.test`, role: 'PARENT' } }, { token: secToken, tenantId: admin.clubId });
    expect(parent.errors).toBeUndefined();
    const asAdmin = await t.gql(INVITE, { i: { email: `a.${Date.now()}@example.test`, role: 'ADMIN' } }, { token: secToken, tenantId: admin.clubId });
    expect(asAdmin.errors?.[0]?.extensions?.code).toBe('FORBIDDEN');
  });

  it('un utente esistente accetta l’invito di una seconda società', async () => {
    const adminA = await createAdminWithClub(t, 'Club A');
    const adminB = await createAdminWithClub(t, 'Club B');
    await t.gql(INVITE, { i: { email: adminA.email, role: 'PARENT' } }, { token: adminB.token, tenantId: adminB.clubId });
    const token = tokenFromMail(t.mail.outbox.findLast((m) => m.to === adminA.email)!.text);
    const acc = await t.gql<{ acceptInvitation: { status: string } }>(ACCEPT, { i: { token, acceptTerms: true } });
    // L'utente ha il 2FA attivo: l'invito non lo aggira.
    expect(acc.data?.acceptInvitation.status).toBe('TWO_FACTOR_REQUIRED');
    const me = await t.gql<{ me: { memberships: { clubName: string }[] } }>(`{ me { memberships { clubName role } } }`, {}, { token: adminA.token });
    expect(me.data?.me.memberships.map((m) => m.clubName).sort()).toEqual(['Club A', 'Club B']);
  });

  it('stagioni: una sola aperta per società', async () => {
    const admin = await createAdminWithClub(t);
    const opts = { token: admin.token, tenantId: admin.clubId };
    const CREATE = `mutation ($i: SeasonInput!) { createSeason(input: $i) { id status } }`;
    const s1 = await t.gql<{ createSeason: { id: string } }>(CREATE, { i: { name: '2025/26', startsOn: '2025-09-01', endsOn: '2026-06-30' } }, opts);
    const s2 = await t.gql<{ createSeason: { id: string } }>(CREATE, { i: { name: '2026/27', startsOn: '2026-09-01', endsOn: '2027-06-30' } }, opts);
    const SET = `mutation ($id: ID!, $s: SeasonStatus!) { setSeasonStatus(id: $id, status: $s) { status } }`;
    expect((await t.gql(SET, { id: s1.data!.createSeason.id, s: 'OPEN' }, opts)).errors).toBeUndefined();
    const second = await t.gql(SET, { id: s2.data!.createSeason.id, s: 'OPEN' }, opts);
    expect(second.errors?.[0]?.extensions?.code).toBe('SEASON_ALREADY_OPEN');
    await t.gql(SET, { id: s1.data!.createSeason.id, s: 'CLOSED' }, opts);
    expect((await t.gql(SET, { id: s2.data!.createSeason.id, s: 'OPEN' }, opts)).errors).toBeUndefined();

    const invalid = await t.gql(CREATE, { i: { name: 'X', startsOn: '2027-01-01', endsOn: '2026-01-01' } }, opts);
    expect(invalid.errors?.[0]?.extensions?.code).toBe('BAD_USER_INPUT');
  });

  it('non si può rimuovere l’ultimo amministratore; le operazioni finiscono in audit', async () => {
    const admin = await createAdminWithClub(t);
    const opts = { token: admin.token, tenantId: admin.clubId };
    const members = await t.gql<{ members: { membershipId: string }[] }>(`{ members { membershipId } }`, {}, opts);
    const res = await t.gql(`mutation ($id: ID!) { removeMembership(membershipId: $id) }`, { id: members.data!.members[0]!.membershipId }, opts);
    expect(res.errors?.[0]?.extensions?.code).toBe('LAST_ADMIN');

    const audit = await t.gql<{ auditEvents: { action: string }[] }>(`{ auditEvents { action actorName } }`, {}, opts);
    expect(audit.data?.auditEvents.map((e) => e.action)).toContain('club.created');
  });

  it('consenso liberatoria immagini per società', async () => {
    const admin = await createAdminWithClub(t);
    const noTenant = await t.gql(`mutation { recordConsent(kind: IMAGE_RELEASE, granted: true) { kind } }`, {}, { token: admin.token });
    expect(noTenant.errors?.[0]?.extensions?.code).toBe('TENANT_REQUIRED');
    const ok = await t.gql<{ recordConsent: { clubId: string } }>(
      `mutation { recordConsent(kind: IMAGE_RELEASE, granted: true) { kind clubId granted } }`,
      {},
      { token: admin.token, tenantId: admin.clubId },
    );
    expect(ok.data?.recordConsent.clubId).toBe(admin.clubId);
  });

  it('esportazione dati personali', async () => {
    const admin = await createAdminWithClub(t);
    const res = await t.gql<{ myDataExport: { profile: { email: string }; consents: unknown[] } }>(`{ myDataExport }`, {}, { token: admin.token });
    expect(res.data?.myDataExport.profile.email).toBe(admin.email);
    expect(res.data?.myDataExport.consents.length).toBeGreaterThanOrEqual(2);
  });
});
