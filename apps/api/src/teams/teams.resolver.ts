import { Args, ID, Mutation, Query, Resolver } from '@nestjs/graphql';
import { CurrentTenant, CurrentUserId, RequirePermission } from '../common/decorators.js';
import { StaffRoleEnum } from '../common/enums.js';
import type { TenantAccess } from '../common/request-context.js';
import { Permission } from '../permissions/permissions.js';
import { CopyTeamsInput, PlayerInput, Team, TeamDetail, TeamInput } from './team.model.js';
import { TeamsService } from './teams.service.js';

@Resolver(() => Team)
export class TeamsResolver {
  constructor(private readonly service: TeamsService) {}

  @Query(() => [Team], { description: 'Squadre visibili: tutte per la direzione, le proprie per staff, atleti e famiglie.' })
  @RequirePermission(Permission.TeamView)
  teams(
    @CurrentTenant() access: TenantAccess,
    @CurrentUserId() userId: string,
    @Args('seasonId', { type: () => ID, nullable: true }) seasonId: string | null,
    @Args('includeArchived', { type: () => Boolean, defaultValue: false }) includeArchived: boolean,
  ): Promise<Team[]> {
    return this.service.list(access, userId, seasonId, includeArchived);
  }

  @Query(() => TeamDetail)
  @RequirePermission(Permission.TeamView)
  team(
    @CurrentTenant() access: TenantAccess,
    @CurrentUserId() userId: string,
    @Args('id', { type: () => ID }) id: string,
  ): Promise<TeamDetail> {
    return this.service.get(access, userId, id);
  }

  @Mutation(() => TeamDetail)
  @RequirePermission(Permission.TeamManage)
  createTeam(@CurrentTenant() access: TenantAccess, @CurrentUserId() userId: string, @Args('input') input: TeamInput) {
    return this.service.create(access, userId, input);
  }

  @Mutation(() => TeamDetail)
  @RequirePermission(Permission.TeamManage)
  updateTeam(
    @CurrentTenant() access: TenantAccess,
    @CurrentUserId() userId: string,
    @Args('id', { type: () => ID }) id: string,
    @Args('input') input: TeamInput,
  ) {
    return this.service.update(access, userId, id, input);
  }

  @Mutation(() => TeamDetail)
  @RequirePermission(Permission.TeamManage)
  setTeamArchived(
    @CurrentTenant() access: TenantAccess,
    @CurrentUserId() userId: string,
    @Args('id', { type: () => ID }) id: string,
    @Args('archived', { type: () => Boolean }) archived: boolean,
  ) {
    return this.service.setArchived(access, userId, id, archived);
  }

  @Mutation(() => [Team], { description: 'Passaggio di stagione: copia squadre e staff, a richiesta anche gli atleti.' })
  @RequirePermission(Permission.TeamManage)
  copyTeams(@CurrentTenant() access: TenantAccess, @CurrentUserId() userId: string, @Args('input') input: CopyTeamsInput) {
    return this.service.copy(access, userId, input);
  }

  @Mutation(() => TeamDetail)
  @RequirePermission(Permission.TeamManage)
  addPlayer(
    @CurrentTenant() access: TenantAccess,
    @CurrentUserId() userId: string,
    @Args('teamId', { type: () => ID }) teamId: string,
    @Args('personId', { type: () => ID }) personId: string,
    @Args('input', { type: () => PlayerInput, nullable: true }) input: PlayerInput | null,
  ) {
    return this.service.addPlayer(access, userId, teamId, personId, input ?? {});
  }

  @Mutation(() => TeamDetail)
  @RequirePermission(Permission.TeamManage)
  updatePlayer(
    @CurrentTenant() access: TenantAccess,
    @CurrentUserId() userId: string,
    @Args('rosterId', { type: () => ID }) rosterId: string,
    @Args('input') input: PlayerInput,
  ) {
    return this.service.updatePlayer(access, userId, rosterId, input);
  }

  @Mutation(() => TeamDetail)
  @RequirePermission(Permission.TeamManage)
  removePlayer(
    @CurrentTenant() access: TenantAccess,
    @CurrentUserId() userId: string,
    @Args('rosterId', { type: () => ID }) rosterId: string,
  ) {
    return this.service.removePlayer(access, userId, rosterId);
  }

  @Mutation(() => TeamDetail, { description: "Se la persona ha un account, riceve l'accesso alla squadra." })
  @RequirePermission(Permission.TeamManage)
  addStaff(
    @CurrentTenant() access: TenantAccess,
    @CurrentUserId() userId: string,
    @Args('teamId', { type: () => ID }) teamId: string,
    @Args('personId', { type: () => ID }) personId: string,
    @Args('role', { type: () => StaffRoleEnum }) role: StaffRoleEnum,
  ) {
    return this.service.addStaff(access, userId, teamId, personId, role);
  }

  @Mutation(() => TeamDetail)
  @RequirePermission(Permission.TeamManage)
  removeStaff(
    @CurrentTenant() access: TenantAccess,
    @CurrentUserId() userId: string,
    @Args('staffId', { type: () => ID }) staffId: string,
  ) {
    return this.service.removeStaff(access, userId, staffId);
  }
}
