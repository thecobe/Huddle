import { type Kysely, sql } from 'kysely';

/**
 * Schema iniziale: identità globali (users, token) e dati per società con Row Level Security.
 *
 * Il ruolo applicativo `huddle_app` è soggetto a RLS. Ogni richiesta apre una transazione e imposta
 * `app.tenant_id` e `app.user_id` (vedi DbContext); le policy leggono quei valori.
 */
export async function up(db: Kysely<unknown>): Promise<void> {
  await sql
    .raw(
      `
CREATE EXTENSION IF NOT EXISTS citext;

CREATE TYPE membership_role AS ENUM
  ('ADMIN', 'SECRETARY', 'SPORTS_DIRECTOR', 'COACH', 'TEAM_MANAGER', 'ATHLETE', 'PARENT');
CREATE TYPE season_status AS ENUM ('PLANNED', 'OPEN', 'CLOSED');
CREATE TYPE auth_token_purpose AS ENUM ('MAGIC_LINK', 'PASSWORD_RESET', 'TWO_FACTOR_CHALLENGE');
CREATE TYPE device_platform AS ENUM ('IOS', 'ANDROID', 'WEB');
CREATE TYPE consent_kind AS ENUM ('PRIVACY_POLICY', 'TERMS_OF_SERVICE', 'IMAGE_RELEASE', 'MARKETING');

CREATE FUNCTION app_current_tenant() RETURNS uuid LANGUAGE sql STABLE AS
  $$ SELECT nullif(current_setting('app.tenant_id', true), '')::uuid $$;
CREATE FUNCTION app_current_user() RETURNS uuid LANGUAGE sql STABLE AS
  $$ SELECT nullif(current_setting('app.user_id', true), '')::uuid $$;

CREATE FUNCTION touch_updated_at() RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END $$;

-- Identità globali (una persona può appartenere a più società) ------------------------------

CREATE TABLE users (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  email citext NOT NULL UNIQUE,
  password_hash text,
  full_name text NOT NULL,
  locale text NOT NULL DEFAULT 'it',
  totp_secret_enc text,
  totp_enabled_at timestamptz,
  totp_recovery_hashes text[] NOT NULL DEFAULT '{}',
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
CREATE TRIGGER users_touch BEFORE UPDATE ON users FOR EACH ROW EXECUTE FUNCTION touch_updated_at();

CREATE TABLE refresh_tokens (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  family_id uuid NOT NULL,
  token_hash text NOT NULL UNIQUE,
  expires_at timestamptz NOT NULL,
  revoked_at timestamptz,
  replaced_by uuid,
  user_agent text,
  created_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX refresh_tokens_family_idx ON refresh_tokens(family_id);

CREATE TABLE auth_tokens (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  purpose auth_token_purpose NOT NULL,
  token_hash text NOT NULL UNIQUE,
  expires_at timestamptz NOT NULL,
  consumed_at timestamptz,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE device_tokens (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  platform device_platform NOT NULL,
  token text NOT NULL UNIQUE,
  app_version text,
  last_seen_at timestamptz NOT NULL DEFAULT now(),
  created_at timestamptz NOT NULL DEFAULT now()
);

-- Dati per società (tenant) ----------------------------------------------------------------

CREATE TABLE clubs (
  id uuid PRIMARY KEY,
  name text NOT NULL,
  legal_name text,
  tax_code text,
  vat_number text,
  sport text NOT NULL DEFAULT 'FOOTBALL',
  email text,
  phone text,
  address_line text,
  city text,
  province text,
  postal_code text,
  country text NOT NULL DEFAULT 'IT',
  federations text[] NOT NULL DEFAULT '{}',
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
CREATE TRIGGER clubs_touch BEFORE UPDATE ON clubs FOR EACH ROW EXECUTE FUNCTION touch_updated_at();

CREATE TABLE memberships (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
  user_id uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  role membership_role NOT NULL,
  -- Ambito squadra: valorizzato per ruoli limitati a una squadra (FK aggiunta con la tabella teams).
  team_id uuid,
  created_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE NULLS NOT DISTINCT (tenant_id, user_id, role, team_id)
);
CREATE INDEX memberships_user_idx ON memberships(user_id);

CREATE TABLE seasons (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
  name text NOT NULL,
  starts_on date NOT NULL,
  ends_on date NOT NULL,
  status season_status NOT NULL DEFAULT 'PLANNED',
  created_at timestamptz NOT NULL DEFAULT now(),
  CHECK (ends_on > starts_on),
  UNIQUE (tenant_id, name)
);
CREATE UNIQUE INDEX seasons_one_open_idx ON seasons(tenant_id) WHERE status = 'OPEN';

CREATE TABLE invitations (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
  email citext NOT NULL,
  role membership_role NOT NULL,
  team_id uuid,
  token_hash text NOT NULL UNIQUE,
  invited_by uuid NOT NULL REFERENCES users(id),
  expires_at timestamptz NOT NULL,
  accepted_at timestamptz,
  revoked_at timestamptz,
  created_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX invitations_tenant_idx ON invitations(tenant_id);

-- Registro append-only delle operazioni sensibili.
CREATE TABLE audit_events (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  tenant_id uuid REFERENCES clubs(id) ON DELETE CASCADE,
  actor_user_id uuid REFERENCES users(id) ON DELETE SET NULL,
  action text NOT NULL,
  entity_type text,
  entity_id text,
  metadata jsonb NOT NULL DEFAULT '{}',
  ip text,
  user_agent text,
  created_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX audit_events_tenant_idx ON audit_events(tenant_id, id DESC);

-- Registro append-only dei consensi: vale l'ultima riga per (utente, società, tipo).
CREATE TABLE consents (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES clubs(id) ON DELETE CASCADE,
  user_id uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  kind consent_kind NOT NULL,
  version text NOT NULL,
  granted boolean NOT NULL,
  recorded_by uuid REFERENCES users(id) ON DELETE SET NULL,
  ip text,
  created_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX consents_user_idx ON consents(user_id, kind, created_at DESC);

-- Row Level Security ------------------------------------------------------------------------

ALTER TABLE clubs ENABLE ROW LEVEL SECURITY;
ALTER TABLE memberships ENABLE ROW LEVEL SECURITY;
ALTER TABLE seasons ENABLE ROW LEVEL SECURITY;
ALTER TABLE invitations ENABLE ROW LEVEL SECURITY;
ALTER TABLE audit_events ENABLE ROW LEVEL SECURITY;
ALTER TABLE consents ENABLE ROW LEVEL SECURITY;

-- Un utente vede le proprie appartenenze in ogni società, tutte quelle della società corrente.
CREATE POLICY memberships_select ON memberships FOR SELECT
  USING (tenant_id = app_current_tenant() OR user_id = app_current_user());
CREATE POLICY memberships_write ON memberships FOR ALL
  USING (tenant_id = app_current_tenant()) WITH CHECK (tenant_id = app_current_tenant());

CREATE POLICY clubs_select ON clubs FOR SELECT
  USING (id = app_current_tenant()
         OR id IN (SELECT tenant_id FROM memberships WHERE user_id = app_current_user()));
CREATE POLICY clubs_write ON clubs FOR ALL
  USING (id = app_current_tenant()) WITH CHECK (id = app_current_tenant());

CREATE POLICY seasons_tenant ON seasons FOR ALL
  USING (tenant_id = app_current_tenant()) WITH CHECK (tenant_id = app_current_tenant());

CREATE POLICY invitations_tenant ON invitations FOR ALL
  USING (tenant_id = app_current_tenant()) WITH CHECK (tenant_id = app_current_tenant());

CREATE POLICY audit_select ON audit_events FOR SELECT
  USING (tenant_id = app_current_tenant());
CREATE POLICY audit_insert ON audit_events FOR INSERT
  WITH CHECK (tenant_id IS NULL OR tenant_id = app_current_tenant());

CREATE POLICY consents_select ON consents FOR SELECT
  USING (user_id = app_current_user() OR tenant_id = app_current_tenant());
CREATE POLICY consents_insert ON consents FOR INSERT
  WITH CHECK (user_id = app_current_user() AND (tenant_id IS NULL OR tenant_id = app_current_tenant()));

-- L'invito si apre dal link ricevuto via e-mail, prima di conoscere la società:
-- lookup per hash del token, fuori dalla RLS ma limitato a una sola riga.
CREATE FUNCTION find_invitation_by_token_hash(p_token_hash text)
RETURNS TABLE (
  id uuid, tenant_id uuid, club_name text, email citext, role membership_role, team_id uuid,
  expires_at timestamptz, accepted_at timestamptz, revoked_at timestamptz
)
LANGUAGE sql STABLE SECURITY DEFINER SET search_path = public AS $$
  SELECT i.id, i.tenant_id, c.name, i.email, i.role, i.team_id, i.expires_at, i.accepted_at, i.revoked_at
  FROM invitations i JOIN clubs c ON c.id = i.tenant_id
  WHERE i.token_hash = p_token_hash
$$;

-- Permessi del ruolo applicativo ------------------------------------------------------------

GRANT USAGE ON SCHEMA public TO huddle_app;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO huddle_app;
REVOKE UPDATE, DELETE ON audit_events, consents FROM huddle_app;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA public TO huddle_app;
REVOKE ALL ON FUNCTION find_invitation_by_token_hash(text) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION find_invitation_by_token_hash(text) TO huddle_app;
`,
    )
    .execute(db);
}

export async function down(db: Kysely<unknown>): Promise<void> {
  await sql
    .raw(
      `
DROP FUNCTION IF EXISTS find_invitation_by_token_hash(text);
DROP TABLE IF EXISTS consents, audit_events, invitations, seasons, memberships, clubs,
  device_tokens, auth_tokens, refresh_tokens, users;
DROP FUNCTION IF EXISTS touch_updated_at(), app_current_user(), app_current_tenant();
DROP TYPE IF EXISTS consent_kind, device_platform, auth_token_purpose, season_status, membership_role;
`,
    )
    .execute(db);
}
