import type { ColumnType, Generated, Selectable } from 'kysely';

export type MembershipRole =
  | 'ADMIN'
  | 'SECRETARY'
  | 'SPORTS_DIRECTOR'
  | 'COACH'
  | 'TEAM_MANAGER'
  | 'ATHLETE'
  | 'PARENT';
export type SeasonStatus = 'PLANNED' | 'OPEN' | 'CLOSED';
export type AuthTokenPurpose = 'MAGIC_LINK' | 'PASSWORD_RESET' | 'TWO_FACTOR_CHALLENGE';
export type DevicePlatform = 'IOS' | 'ANDROID' | 'WEB';
export type ConsentKind = 'PRIVACY_POLICY' | 'TERMS_OF_SERVICE' | 'IMAGE_RELEASE' | 'MARKETING';
export type PersonGender = 'F' | 'M';
export type PersonCategory = 'ATHLETE' | 'STAFF' | 'MANAGER' | 'VOLUNTEER' | 'GUARDIAN';
export type GuardianRelation = 'MOTHER' | 'FATHER' | 'GUARDIAN' | 'OTHER';
export type PlayerAvailability = 'AVAILABLE' | 'INJURED' | 'SUSPENDED' | 'OTHER';
export type EventKind = 'TRAINING' | 'MATCH' | 'OTHER';
export type EventStatus = 'SCHEDULED' | 'CANCELLED';
export type AttendanceStatus = 'PRESENT' | 'ABSENT' | 'EXCUSED' | 'INJURED' | 'LATE';
export type AttendanceOutcome = 'APPLIED' | 'DUPLICATE' | 'SUPERSEDED';
export type StaffRole = 'HEAD_COACH' | 'ASSISTANT_COACH' | 'FITNESS_COACH' | 'GOALKEEPER_COACH' | 'TEAM_MANAGER';

type Timestamp = ColumnType<Date, Date | string | undefined, Date | string>;
type CreatedAt = ColumnType<Date, never, never>;
// Le colonne `date` vengono restituite come stringa ISO (vedi parser in database.module).
type DateOnly = ColumnType<string, string, string>;

export interface UsersTable {
  id: Generated<string>;
  email: string;
  password_hash: string | null;
  full_name: string;
  locale: Generated<string>;
  totp_secret_enc: string | null;
  totp_enabled_at: Timestamp | null;
  totp_recovery_hashes: Generated<string[]>;
  created_at: CreatedAt;
  updated_at: CreatedAt;
}

export interface RefreshTokensTable {
  id: Generated<string>;
  user_id: string;
  family_id: string;
  token_hash: string;
  expires_at: Timestamp;
  revoked_at: Timestamp | null;
  replaced_by: string | null;
  user_agent: string | null;
  created_at: CreatedAt;
}

export interface AuthTokensTable {
  id: Generated<string>;
  user_id: string;
  purpose: AuthTokenPurpose;
  token_hash: string;
  expires_at: Timestamp;
  consumed_at: Timestamp | null;
  created_at: CreatedAt;
}

export interface DeviceTokensTable {
  id: Generated<string>;
  user_id: string;
  platform: DevicePlatform;
  token: string;
  app_version: string | null;
  last_seen_at: Generated<Timestamp>;
  created_at: CreatedAt;
}

export interface ClubsTable {
  id: string;
  name: string;
  legal_name: string | null;
  tax_code: string | null;
  vat_number: string | null;
  sport: Generated<string>;
  email: string | null;
  phone: string | null;
  address_line: string | null;
  city: string | null;
  province: string | null;
  postal_code: string | null;
  country: Generated<string>;
  federations: Generated<string[]>;
  timezone: Generated<string>;
  created_at: CreatedAt;
  updated_at: CreatedAt;
}

export interface MembershipsTable {
  id: Generated<string>;
  tenant_id: string;
  user_id: string;
  role: MembershipRole;
  team_id: string | null;
  created_at: CreatedAt;
}

export interface SeasonsTable {
  id: Generated<string>;
  tenant_id: string;
  name: string;
  starts_on: DateOnly;
  ends_on: DateOnly;
  status: Generated<SeasonStatus>;
  created_at: CreatedAt;
}

export interface InvitationsTable {
  id: Generated<string>;
  tenant_id: string;
  email: string;
  role: MembershipRole;
  team_id: string | null;
  person_id: string | null;
  token_hash: string;
  invited_by: string;
  expires_at: Timestamp;
  accepted_at: Timestamp | null;
  revoked_at: Timestamp | null;
  created_at: CreatedAt;
}

export interface AuditEventsTable {
  id: Generated<string>;
  tenant_id: string | null;
  actor_user_id: string | null;
  action: string;
  entity_type: string | null;
  entity_id: string | null;
  metadata: Generated<Record<string, unknown>>;
  ip: string | null;
  user_agent: string | null;
  created_at: CreatedAt;
}

export interface ConsentsTable {
  id: Generated<string>;
  tenant_id: string | null;
  user_id: string;
  kind: ConsentKind;
  version: string;
  granted: boolean;
  recorded_by: string | null;
  ip: string | null;
  created_at: CreatedAt;
}

export interface PeopleTable {
  id: Generated<string>;
  tenant_id: string;
  first_name: string;
  last_name: string;
  birth_date: DateOnly | null;
  birth_place: string | null;
  tax_code: string | null;
  gender: PersonGender | null;
  categories: Generated<PersonCategory[]>;
  email: string | null;
  phone: string | null;
  address_line: string | null;
  city: string | null;
  province: string | null;
  postal_code: string | null;
  notes: string | null;
  user_id: string | null;
  archived_at: Timestamp | null;
  created_at: CreatedAt;
  updated_at: CreatedAt;
}

export interface GuardianshipsTable {
  id: Generated<string>;
  tenant_id: string;
  minor_person_id: string;
  guardian_person_id: string;
  relation: Generated<GuardianRelation>;
  created_at: CreatedAt;
}

export interface TeamsTable {
  id: Generated<string>;
  tenant_id: string;
  season_id: string;
  name: string;
  category: string | null;
  birth_year_from: number | null;
  birth_year_to: number | null;
  color: string | null;
  archived_at: Timestamp | null;
  created_at: CreatedAt;
}

export interface TeamPlayersTable {
  id: Generated<string>;
  tenant_id: string;
  team_id: string;
  person_id: string;
  jersey_number: number | null;
  position: string | null;
  availability: Generated<PlayerAvailability>;
  availability_note: string | null;
  created_at: CreatedAt;
}

export interface TeamStaffTable {
  id: Generated<string>;
  tenant_id: string;
  team_id: string;
  person_id: string;
  role: StaffRole;
  created_at: CreatedAt;
}

export interface EventSeriesTable {
  id: Generated<string>;
  tenant_id: string;
  team_id: string;
  kind: Generated<EventKind>;
  title: string | null;
  weekdays: number[];
  /** HH:MM:SS */
  start_time: string;
  duration_minutes: number;
  location: string | null;
  starts_on: DateOnly;
  ends_on: DateOnly;
  created_by: string | null;
  created_at: CreatedAt;
  updated_at: CreatedAt;
}

export interface EventsTable {
  id: Generated<string>;
  tenant_id: string;
  team_id: string | null;
  series_id: string | null;
  series_date: DateOnly | null;
  detached: Generated<boolean>;
  kind: EventKind;
  title: string | null;
  starts_at: Timestamp;
  ends_at: Timestamp;
  location: string | null;
  notes: string | null;
  status: Generated<EventStatus>;
  cancel_reason: string | null;
  opponent: string | null;
  is_home: boolean | null;
  competition: string | null;
  roll_call_at: Timestamp | null;
  roll_call_by: string | null;
  created_by: string | null;
  created_at: CreatedAt;
  updated_at: CreatedAt;
}

export interface AttendanceTable {
  id: Generated<string>;
  tenant_id: string;
  event_id: string;
  person_id: string;
  status: AttendanceStatus;
  note: string | null;
  recorded_by: string | null;
  recorded_at: Timestamp;
  updated_at: Generated<Timestamp>;
}

export interface AttendanceWritesTable {
  id: Generated<string>;
  tenant_id: string;
  client_mutation_id: string;
  event_id: string;
  person_id: string;
  status: AttendanceStatus;
  note: string | null;
  recorded_by: string | null;
  recorded_at: Timestamp;
  received_at: Generated<Timestamp>;
  outcome: AttendanceOutcome;
}

export interface AbsenceNoticesTable {
  id: Generated<string>;
  tenant_id: string;
  event_id: string;
  person_id: string;
  reason: string | null;
  created_by: string | null;
  created_at: CreatedAt;
  withdrawn_at: Timestamp | null;
}

export interface CalendarFeedsTable {
  id: Generated<string>;
  tenant_id: string;
  user_id: string;
  team_id: string | null;
  token_hash: string;
  created_at: CreatedAt;
  revoked_at: Timestamp | null;
}

export interface Database {
  users: UsersTable;
  refresh_tokens: RefreshTokensTable;
  auth_tokens: AuthTokensTable;
  device_tokens: DeviceTokensTable;
  clubs: ClubsTable;
  memberships: MembershipsTable;
  seasons: SeasonsTable;
  invitations: InvitationsTable;
  audit_events: AuditEventsTable;
  consents: ConsentsTable;
  people: PeopleTable;
  guardianships: GuardianshipsTable;
  teams: TeamsTable;
  team_players: TeamPlayersTable;
  team_staff: TeamStaffTable;
  event_series: EventSeriesTable;
  events: EventsTable;
  calendar_feeds: CalendarFeedsTable;
  attendance: AttendanceTable;
  attendance_writes: AttendanceWritesTable;
  absence_notices: AbsenceNoticesTable;
}

export type UserRow = Selectable<UsersTable>;
export type ClubRow = Selectable<ClubsTable>;
export type SeasonRow = Selectable<SeasonsTable>;
export type InvitationRow = Selectable<InvitationsTable>;
export type PersonRow = Selectable<PeopleTable>;
export type TeamRow = Selectable<TeamsTable>;
export type EventRow = Selectable<EventsTable>;
export type EventSeriesRow = Selectable<EventSeriesTable>;
