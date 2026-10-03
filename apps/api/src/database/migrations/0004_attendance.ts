import { type Kysely, sql } from 'kysely';

/**
 * M3: presenze. `attendance` contiene lo stato attuale per (evento, persona); `attendance_writes` è il registro
 * append-only di ogni scrittura ricevuta, che rende idempotente l'invio offline (client_mutation_id univoco)
 * e conserva le versioni scartate nei conflitti.
 */
export async function up(db: Kysely<unknown>): Promise<void> {
  await sql
    .raw(
      `
CREATE TYPE attendance_status AS ENUM ('PRESENT', 'ABSENT', 'EXCUSED', 'INJURED', 'LATE');
CREATE TYPE attendance_outcome AS ENUM ('APPLIED', 'DUPLICATE', 'SUPERSEDED');

CREATE TABLE attendance (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
  event_id uuid NOT NULL REFERENCES events(id) ON DELETE CASCADE,
  person_id uuid NOT NULL REFERENCES people(id) ON DELETE CASCADE,
  status attendance_status NOT NULL,
  note text,
  recorded_by uuid REFERENCES users(id) ON DELETE SET NULL,
  recorded_at timestamptz NOT NULL,
  updated_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE (event_id, person_id)
);
CREATE INDEX attendance_person_idx ON attendance(person_id);

CREATE TABLE attendance_writes (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  tenant_id uuid NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
  client_mutation_id uuid NOT NULL UNIQUE,
  event_id uuid NOT NULL REFERENCES events(id) ON DELETE CASCADE,
  person_id uuid NOT NULL REFERENCES people(id) ON DELETE CASCADE,
  status attendance_status NOT NULL,
  note text,
  recorded_by uuid REFERENCES users(id) ON DELETE SET NULL,
  recorded_at timestamptz NOT NULL,
  received_at timestamptz NOT NULL DEFAULT now(),
  outcome attendance_outcome NOT NULL
);
CREATE INDEX attendance_writes_event_idx ON attendance_writes(event_id);

CREATE TABLE absence_notices (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
  event_id uuid NOT NULL REFERENCES events(id) ON DELETE CASCADE,
  person_id uuid NOT NULL REFERENCES people(id) ON DELETE CASCADE,
  reason text,
  created_by uuid REFERENCES users(id) ON DELETE SET NULL,
  created_at timestamptz NOT NULL DEFAULT now(),
  withdrawn_at timestamptz
);
-- Al più un'assenza annunciata attiva per (evento, persona).
CREATE UNIQUE INDEX absence_notices_active_idx ON absence_notices(event_id, person_id) WHERE withdrawn_at IS NULL;

ALTER TABLE events ADD COLUMN roll_call_at timestamptz;
ALTER TABLE events ADD COLUMN roll_call_by uuid REFERENCES users(id) ON DELETE SET NULL;

ALTER TABLE attendance ENABLE ROW LEVEL SECURITY;
ALTER TABLE attendance_writes ENABLE ROW LEVEL SECURITY;
ALTER TABLE absence_notices ENABLE ROW LEVEL SECURITY;
CREATE POLICY attendance_tenant ON attendance FOR ALL
  USING (tenant_id = app_current_tenant()) WITH CHECK (tenant_id = app_current_tenant());
CREATE POLICY attendance_writes_tenant ON attendance_writes FOR ALL
  USING (tenant_id = app_current_tenant()) WITH CHECK (tenant_id = app_current_tenant());
CREATE POLICY absence_notices_tenant ON absence_notices FOR ALL
  USING (tenant_id = app_current_tenant()) WITH CHECK (tenant_id = app_current_tenant());

GRANT SELECT, INSERT, UPDATE, DELETE ON attendance, absence_notices TO huddle_app;
-- Registro delle scritture: solo inserimento e lettura.
GRANT SELECT, INSERT ON attendance_writes TO huddle_app;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA public TO huddle_app;
`,
    )
    .execute(db);
}

export async function down(db: Kysely<unknown>): Promise<void> {
  await sql
    .raw(
      `
ALTER TABLE events DROP COLUMN roll_call_by, DROP COLUMN roll_call_at;
DROP TABLE IF EXISTS absence_notices, attendance_writes, attendance;
DROP TYPE IF EXISTS attendance_outcome, attendance_status;
`,
    )
    .execute(db);
}
