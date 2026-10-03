import { Args, GraphQLISODateTime, ID, Int, Mutation, Query, Resolver } from '@nestjs/graphql';
import { CurrentTenant, CurrentUserId, RequirePermission } from '../common/decorators.js';
import { EventKindEnum } from '../common/enums.js';
import type { TenantAccess } from '../common/request-context.js';
import { Permission } from '../permissions/permissions.js';
import {
  AttendanceEntryInput,
  AttendanceEntryResult,
  AttendanceRegister,
  Participation,
  PersonAttendance,
  RollCall,
} from './attendance.model.js';
import { AttendanceService } from './attendance.service.js';


@Resolver()
export class AttendanceResolver {
  constructor(private readonly service: AttendanceService) {}

  @Query(() => RollCall, { description: "Appello di un evento: rosa, presenze registrate e assenze annunciate." })
  @RequirePermission(Permission.ClubView)
  rollCall(@CurrentTenant() access: TenantAccess, @CurrentUserId() userId: string, @Args('eventId', { type: () => ID }) eventId: string) {
    return this.service.rollCall(access, userId, eventId);
  }

  @Mutation(() => [AttendanceEntryResult], {
    description: 'Registra presenze (anche da coda offline). Idempotente per clientMutationId; esito riga per riga.',
  })
  @RequirePermission(Permission.ClubView)
  recordAttendance(
    @CurrentTenant() access: TenantAccess,
    @CurrentUserId() userId: string,
    @Args('entries', { type: () => [AttendanceEntryInput] }) entries: AttendanceEntryInput[],
  ) {
    return this.service.record(access, userId, entries);
  }

  @Mutation(() => RollCall)
  @RequirePermission(Permission.ClubView)
  completeRollCall(@CurrentTenant() access: TenantAccess, @CurrentUserId() userId: string, @Args('eventId', { type: () => ID }) eventId: string) {
    return this.service.complete(access, userId, eventId);
  }

  @Query(() => AttendanceRegister)
  @RequirePermission(Permission.ClubView)
  attendanceRegister(
    @CurrentTenant() access: TenantAccess,
    @CurrentUserId() userId: string,
    @Args('teamId', { type: () => ID }) teamId: string,
    @Args('from', { type: () => GraphQLISODateTime }) from: Date,
    @Args('to', { type: () => GraphQLISODateTime }) to: Date,
    @Args('kind', { type: () => EventKindEnum, nullable: true }) kind: EventKindEnum | null,
  ) {
    return this.service.register(access, userId, teamId, from, to, kind);
  }

  @Query(() => [Participation], { description: "Partecipazione all'evento dell'utente e dei suoi figli." })
  @RequirePermission(Permission.ClubView)
  myParticipation(@CurrentTenant() access: TenantAccess, @CurrentUserId() userId: string, @Args('eventId', { type: () => ID }) eventId: string) {
    return this.service.participation(access, userId, eventId);
  }

  @Mutation(() => [Participation])
  @RequirePermission(Permission.ClubView)
  reportAbsence(
    @CurrentTenant() access: TenantAccess,
    @CurrentUserId() userId: string,
    @Args('eventId', { type: () => ID }) eventId: string,
    @Args('personId', { type: () => ID }) personId: string,
    @Args('reason', { type: () => String, nullable: true }) reason: string | null,
  ) {
    return this.service.reportAbsence(access, userId, eventId, personId, reason);
  }

  @Mutation(() => [Participation])
  @RequirePermission(Permission.ClubView)
  withdrawAbsence(@CurrentTenant() access: TenantAccess, @CurrentUserId() userId: string, @Args('noticeId', { type: () => ID }) noticeId: string) {
    return this.service.withdrawAbsence(access, userId, noticeId);
  }

  @Query(() => [PersonAttendance], { description: 'Presenze recenti della persona stessa o di un figlio.' })
  @RequirePermission(Permission.ClubView)
  personAttendance(
    @CurrentTenant() access: TenantAccess,
    @CurrentUserId() userId: string,
    @Args('personId', { type: () => ID }) personId: string,
    @Args('limit', { type: () => Int, defaultValue: 20 }) limit: number,
  ) {
    return this.service.personHistory(access, userId, personId, limit);
  }
}
