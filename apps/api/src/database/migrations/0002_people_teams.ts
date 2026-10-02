import { type Kysely, sql } from 'kysely';

/**
 * M1: anagrafiche (separate dagli account), tutori, squadre e rose.
 * Tutte le tabelle sono per società con le stesse policy RLS della Fase 0.
 */
export async function up(db: Kysely<unknown>): Promise<void> {
  await sql
    .raw(
      `
ALTER TABLE clubs ADD COLUMN timezone text NOT NULL DEFAULT 'Europe/Rome';

CREATE TYPE person_gender AS ENUM ('F', 'M');
CREATE TYPE person_category AS ENUM ('ATHLETE', 'STAFF', 'MANAGER', 'VOLUNTEER', 'GUARDIAN');
CREATE TYPE guardian_relation AS ENUM ('MOTHER', 'FATHER', 'GUARDIAN', 'OTHER');
CREATE TYPE player_availability AS ENUM ('AVAILABLE', 'INJURED', 'SUSPENDED', 'OTHER');
CREATE TYPE staff_role AS ENUM ('HEAD_COACH', 'ASSISTANT_COACH', 'FITNESS_COACH', 'GOALKEEPER_COACH', 'TEAM_MANAGER');

-- Anagrafica della società. Una persona può non avere un account (minori sotto i 14 anni, volontari...).
CREATE TABLE people (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
  first_name text NOT NULL,
  last_name text NOT NULL,
  birth_date date,
  birth_place text,
  tax_code text,
  gender person_gender,
  categories person_category[] NOT NULL DEFAULT '{}',
  email citext,
  phone text,
  address_line text,
  city text,
  province text,
  postal_code text,
  notes text,
  user_id uuid REFERENCES users(id) ON DELETE SET NULL,
  archived_at timestamptz,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
CREATE TRIGGER people_touch BEFORE UPDATE ON people FOR EACH ROW EXECUTE FUNCTION touch_updated_at();
CREATE UNIQUE INDEX people_tax_code_idx ON people(tenant_id, upper(tax_code)) WHERE tax_code IS NOT NULL;
CREATE UNIQUE INDEX people_user_idx ON people(tenant_id, user_id) WHERE user_id IS NOT NULL;
CREATE INDEX people_name_idx ON people(tenant_id, lower(last_name), lower(first_name));

CREATE TABLE guardianships (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
  minor_person_id uuid NOT NULL REFERENCES people(id) ON DELETE CASCADE,
  guardian_person_id uuid NOT NULL REFERENCES people(id) ON DELETE CASCADE,
  relation guardian_relation NOT NULL DEFAULT 'GUARDIAN',
  created_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE (minor_person_id, guardian_person_id),
  CHECK (minor_person_id <> guardian_person_id)
);
CREATE INDEX guardianships_guardian_idx ON guardianships(guardian_person_id);

CREATE TABLE teams (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
  season_id uuid NOT NULL REFERENCES seasons(id) ON DELETE CASCADE,
  name text NOT NULL,
  category text,
  birth_year_from int,
  birth_year_to int,
  color text,
  archived_at timestamptz,
  created_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE (season_id, name),
  CHECK (birth_year_from IS NULL OR birth_year_to IS NULL OR birth_year_from <= birth_year_to)
);

CREATE TABLE team_players (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
  team_id uuid NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
  person_id uuid NOT NULL REFERENCES people(id) ON DELETE CASCADE,
  jersey_number int CHECK (jersey_number BETWEEN 0 AND 99),
  position text,
  availability player_availability NOT NULL DEFAULT 'AVAILABLE',
  availability_note text,
  created_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE (team_id, person_id)
);
CREATE UNIQUE INDEX team_players_jersey_idx ON team_players(team_id, jersey_number) WHERE jersey_number IS NOT NULL;
CREATE INDEX team_players_person_idx ON team_players(person_id);

CREATE TABLE team_staff (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
  team_id uuid NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
  person_id uuid NOT NULL REFERENCES people(id) ON DELETE CASCADE,
  role staff_role NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE (team_id, person_id, role)
);
CREATE INDEX team_staff_person_idx ON team_staff(person_id);

-- L'ambito squadra delle appartenenze ora punta a una squadra reale.
ALTER TABLE memberships
  ADD CONSTRAINT memberships_team_fk FOREIGN KEY (team_id) REFERENCES teams(id) ON DELETE CASCADE;

-- Inviti legati a una scheda: all'accettazione l'account si collega alla persona.
ALTER TABLE invitations ADD COLUMN person_id uuid REFERENCES people(id) ON DELETE CASCADE;

DROP FUNCTION find_invitation_by_token_hash(text);
CREATE FUNCTION find_invitation_by_token_hash(p_token_hash text)
RETURNS TABLE (
  id uuid, tenant_id uuid, club_name text, email citext, role membership_role, team_id uuid, person_id uuid,
  expires_at timestamptz, accepted_at timestamptz, revoked_at timestamptz
)
LANGUAGE sql STABLE SECURITY DEFINER SET search_path = public AS $$
  SELECT i.id, i.tenant_id, c.name, i.email, i.role, i.team_id, i.person_id, i.expires_at, i.accepted_at, i.revoked_at
  FROM invitations i JOIN clubs c ON c.id = i.tenant_id
  WHERE i.token_hash = p_token_hash
$$;
REVOKE ALL ON FUNCTION find_invitation_by_token_hash(text) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION find_invitation_by_token_hash(text) TO huddle_app;

ALTER TABLE people ENABLE ROW LEVEL SECURITY;
ALTER TABLE guardianships ENABLE ROW LEVEL SECURITY;
ALTER TABLE teams ENABLE ROW LEVEL SECURITY;
ALTER TABLE team_players ENABLE ROW LEVEL SECURITY;
ALTER TABLE team_staff ENABLE ROW LEVEL SECURITY;

CREATE POLICY people_tenant ON people FOR ALL
  USING (tenant_id = app_current_tenant()) WITH CHECK (tenant_id = app_current_tenant());
CREATE POLICY guardianships_tenant ON guardianships FOR ALL
  USING (tenant_id = app_current_tenant()) WITH CHECK (tenant_id = app_current_tenant());
CREATE POLICY teams_tenant ON teams FOR ALL
  USING (tenant_id = app_current_tenant()) WITH CHECK (tenant_id = app_current_tenant());
CREATE POLICY team_players_tenant ON team_players FOR ALL
  USING (tenant_id = app_current_tenant()) WITH CHECK (tenant_id = app_current_tenant());
CREATE POLICY team_staff_tenant ON team_staff FOR ALL
  USING (tenant_id = app_current_tenant()) WITH CHECK (tenant_id = app_current_tenant());

GRANT SELECT, INSERT, UPDATE, DELETE ON people, guardianships, teams, team_players, team_staff TO huddle_app;
`,
    )
    .execute(db);
}

export async function down(db: Kysely<unknown>): Promise<void> {
  await sql
    .raw(
      `
DROP FUNCTION find_invitation_by_token_hash(text);
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
REVOKE ALL ON FUNCTION find_invitation_by_token_hash(text) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION find_invitation_by_token_hash(text) TO huddle_app;
ALTER TABLE invitations DROP COLUMN person_id;
ALTER TABLE memberships DROP CONSTRAINT memberships_team_fk;
DROP TABLE team_staff, team_players, teams, guardianships, people;
DROP TYPE staff_role, player_availability, guardian_relation, person_category, person_gender;
ALTER TABLE clubs DROP COLUMN timezone;
`,
    )
    .execute(db);
}
