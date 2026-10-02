import { type Kysely, sql } from 'kysely';

/**
 * M2: calendario. Gli allenamenti ricorrenti (`event_series`) vengono materializzati in `events`, una riga
 * per data: presenze, convocazioni e annullamenti si agganciano a una data precisa. `series_date` identifica
 * lo slot della serie; un evento modificato singolarmente diventa `detached` e non viene più rigenerato.
 */
export async function up(db: Kysely<unknown>): Promise<void> {
  await sql
    .raw(
      `
CREATE TYPE event_kind AS ENUM ('TRAINING', 'MATCH', 'OTHER');
CREATE TYPE event_status AS ENUM ('SCHEDULED', 'CANCELLED');

CREATE TABLE event_series (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
  team_id uuid NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
  kind event_kind NOT NULL DEFAULT 'TRAINING',
  title text,
  -- Giorni ISO: 1 = lunedì ... 7 = domenica.
  weekdays smallint[] NOT NULL CHECK (cardinality(weekdays) > 0 AND weekdays <@ ARRAY[1,2,3,4,5,6,7]::smallint[]),
  start_time time NOT NULL,
  duration_minutes int NOT NULL CHECK (duration_minutes BETWEEN 15 AND 600),
  location text,
  starts_on date NOT NULL,
  ends_on date NOT NULL,
  created_by uuid REFERENCES users(id) ON DELETE SET NULL,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  CHECK (ends_on >= starts_on)
);
CREATE TRIGGER event_series_touch BEFORE UPDATE ON event_series FOR EACH ROW EXECUTE FUNCTION touch_updated_at();

CREATE TABLE events (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
  -- NULL: evento di tutta la società (es. festa di fine stagione).
  team_id uuid REFERENCES teams(id) ON DELETE CASCADE,
  series_id uuid REFERENCES event_series(id) ON DELETE SET NULL,
  series_date date,
  detached boolean NOT NULL DEFAULT false,
  kind event_kind NOT NULL,
  title text,
  starts_at timestamptz NOT NULL,
  ends_at timestamptz NOT NULL,
  location text,
  notes text,
  status event_status NOT NULL DEFAULT 'SCHEDULED',
  cancel_reason text,
  opponent text,
  is_home boolean,
  competition text,
  created_by uuid REFERENCES users(id) ON DELETE SET NULL,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  CHECK (ends_at > starts_at),
  UNIQUE (series_id, series_date)
);
CREATE TRIGGER events_touch BEFORE UPDATE ON events FOR EACH ROW EXECUTE FUNCTION touch_updated_at();
CREATE INDEX events_tenant_time_idx ON events(tenant_id, starts_at);
CREATE INDEX events_team_time_idx ON events(team_id, starts_at);

-- Link iCal: personali (team_id NULL) o di squadra. Si salva solo l'hash del token.
CREATE TABLE calendar_feeds (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
  user_id uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  team_id uuid REFERENCES teams(id) ON DELETE CASCADE,
  token_hash text NOT NULL UNIQUE,
  created_at timestamptz NOT NULL DEFAULT now(),
  revoked_at timestamptz
);
CREATE INDEX calendar_feeds_user_idx ON calendar_feeds(user_id);

-- Il link iCal arriva senza sessione: lookup per hash fuori dalla RLS, limitato a una riga valida.
CREATE FUNCTION find_calendar_feed(p_token_hash text)
RETURNS TABLE (id uuid, tenant_id uuid, user_id uuid, team_id uuid)
LANGUAGE sql STABLE SECURITY DEFINER SET search_path = public AS $$
  SELECT f.id, f.tenant_id, f.user_id, f.team_id
  FROM calendar_feeds f
  WHERE f.token_hash = p_token_hash AND f.revoked_at IS NULL
$$;
REVOKE ALL ON FUNCTION find_calendar_feed(text) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION find_calendar_feed(text) TO huddle_app;

ALTER TABLE event_series ENABLE ROW LEVEL SECURITY;
ALTER TABLE events ENABLE ROW LEVEL SECURITY;
ALTER TABLE calendar_feeds ENABLE ROW LEVEL SECURITY;
CREATE POLICY event_series_tenant ON event_series FOR ALL
  USING (tenant_id = app_current_tenant()) WITH CHECK (tenant_id = app_current_tenant());
CREATE POLICY events_tenant ON events FOR ALL
  USING (tenant_id = app_current_tenant()) WITH CHECK (tenant_id = app_current_tenant());
CREATE POLICY calendar_feeds_owner ON calendar_feeds FOR ALL
  USING (tenant_id = app_current_tenant() AND user_id = app_current_user())
  WITH CHECK (tenant_id = app_current_tenant() AND user_id = app_current_user());

GRANT SELECT, INSERT, UPDATE, DELETE ON event_series, events, calendar_feeds TO huddle_app;
`,
    )
    .execute(db);
}

export async function down(db: Kysely<unknown>): Promise<void> {
  await sql
    .raw(
      `
DROP FUNCTION IF EXISTS find_calendar_feed(text);
DROP TABLE IF EXISTS calendar_feeds, events, event_series;
DROP TYPE IF EXISTS event_status, event_kind;
`,
    )
    .execute(db);
}
