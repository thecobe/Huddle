import { Injectable } from '@nestjs/common';
import type { ExpressionBuilder } from 'kysely';
import type { TenantAccess } from '../common/request-context.js';
import { DbContext } from '../database/db-context.js';
import type { Database } from '../database/types.js';
import { hasPermission, Permission, TEAM_STAFF_ROLES } from '../permissions/permissions.js';

/**
 * Chi vede quali persone e squadre, oltre all'isolamento per società garantito dalla RLS:
 * - amministrazione, segreteria, direttore sportivo: tutto;
 * - staff tecnico: persone e squadre delle proprie squadre, più i tutori degli atleti;
 * - chiunque: la propria scheda e quelle dei minori di cui è tutore, con le loro squadre.
 */
export interface Visibility {
  all: boolean;
  /** Squadre su cui l'utente ha un ruolo di staff. */
  staffTeamIds: string[];
  /** Schede collegate all'account dell'utente (al più una per società). */
  selfPersonIds: string[];
  /** Minori di cui l'utente è tutore. */
  wardPersonIds: string[];
}

@Injectable()
export class VisibilityService {
  constructor(private readonly ctx: DbContext) {}

  async forUser(access: TenantAccess, userId: string): Promise<Visibility> {
    const all = hasPermission(access, Permission.PeopleViewAll);
    const staffTeamIds = access.memberships
      .filter((m) => TEAM_STAFF_ROLES.includes(m.role) && m.teamId)
      .map((m) => m.teamId!);
    const self = await this.ctx.db.selectFrom('people').select('id').where('user_id', '=', userId).execute();
    const selfPersonIds = self.map((p) => p.id);
    const wards = selfPersonIds.length
      ? await this.ctx.db
          .selectFrom('guardianships')
          .select('minor_person_id')
          .where('guardian_person_id', 'in', selfPersonIds)
          .execute()
      : [];
    return { all, staffTeamIds, selfPersonIds, wardPersonIds: wards.map((w) => w.minor_person_id) };
  }

  /** Filtro Kysely sulla tabella `people` (alias `p`). */
  peopleFilter(v: Visibility) {
    return (eb: ExpressionBuilder<Database & { p: Database['people'] }, 'p'>) => {
      if (v.all) return eb.lit(true);
      const own = [...v.selfPersonIds, ...v.wardPersonIds];
      const ors = [];
      if (own.length) ors.push(eb('p.id', 'in', own));
      if (v.staffTeamIds.length) {
        const inTeams = eb
          .selectFrom('team_players')
          .select('person_id')
          .where('team_id', 'in', v.staffTeamIds)
          .union(eb.selectFrom('team_staff').select('person_id').where('team_id', 'in', v.staffTeamIds));
        ors.push(eb('p.id', 'in', inTeams));
        // Tutori degli atleti delle proprie squadre: servono i recapiti.
        ors.push(
          eb(
            'p.id',
            'in',
            eb
              .selectFrom('guardianships as g')
              .innerJoin('team_players as tp', 'tp.person_id', 'g.minor_person_id')
              .select('g.guardian_person_id')
              .where('tp.team_id', 'in', v.staffTeamIds),
          ),
        );
      }
      return ors.length ? eb.or(ors) : eb.lit(false);
    };
  }

  /** Filtro Kysely sulla tabella `teams` (alias `t`). */
  teamsFilter(v: Visibility) {
    return (eb: ExpressionBuilder<Database & { t: Database['teams'] }, 't'>) => {
      if (v.all) return eb.lit(true);
      const own = [...v.selfPersonIds, ...v.wardPersonIds];
      const ors = [];
      if (v.staffTeamIds.length) ors.push(eb('t.id', 'in', v.staffTeamIds));
      if (own.length) {
        ors.push(eb('t.id', 'in', eb.selectFrom('team_players').select('team_id').where('person_id', 'in', own)));
        ors.push(eb('t.id', 'in', eb.selectFrom('team_staff').select('team_id').where('person_id', 'in', own)));
      }
      return ors.length ? eb.or(ors) : eb.lit(false);
    };
  }

  canSeePerson(v: Visibility, personId: string): Promise<boolean> {
    return this.ctx.db
      .selectFrom('people as p')
      .select('p.id')
      .where('p.id', '=', personId)
      .where(this.peopleFilter(v))
      .executeTakeFirst()
      .then((r) => !!r);
  }
}
