import { Args, GraphQLISODateTime, ID, Int, Mutation, Query, Resolver } from '@nestjs/graphql';
import { CurrentTenant, CurrentUserId, RequirePermission } from '../common/decorators.js';
import type { TenantAccess } from '../common/request-context.js';
import { Permission } from '../permissions/permissions.js';
import { CalendarFeedService } from './calendar-feed.service.js';
import { CalendarEvent, CalendarFeed, CancelRangeInput, EventInput, EventSeries, SeriesInput } from './calendar.model.js';
import { CalendarService } from './calendar.service.js';

@Resolver(() => CalendarEvent)
export class CalendarResolver {
  constructor(
    private readonly service: CalendarService,
    private readonly feeds: CalendarFeedService,
  ) {}

  @Query(() => [CalendarEvent], { description: 'Eventi delle squadre visibili e di società; al massimo 120 giorni.' })
  @RequirePermission(Permission.ClubView)
  events(
    @CurrentTenant() access: TenantAccess,
    @CurrentUserId() userId: string,
    @Args('from', { type: () => GraphQLISODateTime }) from: Date,
    @Args('to', { type: () => GraphQLISODateTime }) to: Date,
    @Args('teamId', { type: () => ID, nullable: true }) teamId: string | null,
  ) {
    return this.service.events(access, userId, from, to, teamId);
  }

  @Query(() => [CalendarEvent], { description: 'Agenda personale: proprie squadre, squadre dei figli, eventi di società.' })
  @RequirePermission(Permission.ClubView)
  myAgenda(
    @CurrentTenant() access: TenantAccess,
    @CurrentUserId() userId: string,
    @Args('from', { type: () => GraphQLISODateTime }) from: Date,
    @Args('to', { type: () => GraphQLISODateTime }) to: Date,
  ) {
    return this.service.agenda(access, userId, from, to);
  }

  @Query(() => CalendarEvent)
  @RequirePermission(Permission.ClubView)
  event(@CurrentTenant() access: TenantAccess, @CurrentUserId() userId: string, @Args('id', { type: () => ID }) id: string) {
    return this.service.event(access, userId, id);
  }

  @Query(() => [EventSeries], { description: 'Serie ricorrenti attive (non ancora terminate).' })
  @RequirePermission(Permission.ClubView)
  eventSeries(
    @CurrentTenant() access: TenantAccess,
    @CurrentUserId() userId: string,
    @Args('teamId', { type: () => ID, nullable: true }) teamId: string | null,
  ) {
    return this.service.seriesList(access, userId, teamId);
  }

  @Query(() => [ID], { description: 'Squadre di cui può gestire il calendario; vuoto se nessuna.' })
  @RequirePermission(Permission.ClubView)
  async manageableTeamIds(@CurrentTenant() access: TenantAccess, @CurrentUserId() userId: string) {
    const teams = await this.service.manageableTeams(access, userId);
    return teams === 'ALL' ? this.service.visibleTeamIds(access, userId) : teams;
  }

  @Mutation(() => EventSeries)
  @RequirePermission(Permission.ClubView)
  createEventSeries(@CurrentTenant() access: TenantAccess, @CurrentUserId() userId: string, @Args('input') input: SeriesInput) {
    return this.service.createSeries(access, userId, input);
  }

  @Mutation(() => EventSeries, { description: 'Modifica la serie da `fromDate` (mai prima di oggi); le date modificate a mano restano.' })
  @RequirePermission(Permission.ClubView)
  updateEventSeries(
    @CurrentTenant() access: TenantAccess,
    @CurrentUserId() userId: string,
    @Args('id', { type: () => ID }) id: string,
    @Args('input') input: SeriesInput,
    @Args('fromDate', { type: () => String, nullable: true }) fromDate: string | null,
  ) {
    return this.service.updateSeries(access, userId, id, input, fromDate);
  }

  @Mutation(() => Boolean)
  @RequirePermission(Permission.ClubView)
  endEventSeries(
    @CurrentTenant() access: TenantAccess,
    @CurrentUserId() userId: string,
    @Args('id', { type: () => ID }) id: string,
    @Args('fromDate') fromDate: string,
  ) {
    return this.service.endSeries(access, userId, id, fromDate);
  }

  @Mutation(() => CalendarEvent)
  @RequirePermission(Permission.ClubView)
  createEvent(@CurrentTenant() access: TenantAccess, @CurrentUserId() userId: string, @Args('input') input: EventInput) {
    return this.service.createEvent(access, userId, input);
  }

  @Mutation(() => CalendarEvent, { description: 'Modifica una singola occorrenza, che smette di seguire la serie.' })
  @RequirePermission(Permission.ClubView)
  updateEvent(
    @CurrentTenant() access: TenantAccess,
    @CurrentUserId() userId: string,
    @Args('id', { type: () => ID }) id: string,
    @Args('input') input: EventInput,
  ) {
    return this.service.updateEvent(access, userId, id, input);
  }

  @Mutation(() => CalendarEvent)
  @RequirePermission(Permission.ClubView)
  setEventCancelled(
    @CurrentTenant() access: TenantAccess,
    @CurrentUserId() userId: string,
    @Args('id', { type: () => ID }) id: string,
    @Args('cancelled', { type: () => Boolean }) cancelled: boolean,
    @Args('reason', { type: () => String, nullable: true }) reason: string | null,
  ) {
    return this.service.setCancelled(access, userId, id, cancelled, reason);
  }

  @Mutation(() => Boolean, { description: 'Solo eventi singoli; le occorrenze di una serie si annullano.' })
  @RequirePermission(Permission.ClubView)
  deleteEvent(@CurrentTenant() access: TenantAccess, @CurrentUserId() userId: string, @Args('id', { type: () => ID }) id: string) {
    return this.service.deleteEvent(access, userId, id);
  }

  @Mutation(() => Int, { description: 'Annulla gli eventi in un periodo; restituisce quanti.' })
  @RequirePermission(Permission.ClubView)
  cancelEventsInRange(@CurrentTenant() access: TenantAccess, @CurrentUserId() userId: string, @Args('input') input: CancelRangeInput) {
    return this.service.cancelRange(access, userId, input);
  }

  @Mutation(() => CalendarFeed, { description: 'Nuovo link iCal (personale o di squadra); revoca il precedente.' })
  @RequirePermission(Permission.ClubView)
  async createCalendarFeed(
    @CurrentTenant() access: TenantAccess,
    @CurrentUserId() userId: string,
    @Args('teamId', { type: () => ID, nullable: true }) teamId: string | null,
  ): Promise<CalendarFeed> {
    return { url: await this.feeds.create(access, userId, teamId) };
  }

  @Mutation(() => Boolean)
  @RequirePermission(Permission.ClubView)
  async revokeCalendarFeed(@CurrentUserId() userId: string, @Args('teamId', { type: () => ID, nullable: true }) teamId: string | null) {
    await this.feeds.revoke(userId, teamId);
    return true;
  }
}
