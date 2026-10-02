import { Args, ID, Int, Mutation, Query, Resolver } from '@nestjs/graphql';
import { CurrentTenant, CurrentUserId, RequirePermission } from '../common/decorators.js';
import { GuardianRelationEnum, MembershipRoleEnum } from '../common/enums.js';
import { appError } from '../common/errors.js';
import type { TenantAccess } from '../common/request-context.js';
import { Invitation } from '../members/member.model.js';
import { MembersService } from '../members/members.service.js';
import { hasPermission, Permission } from '../permissions/permissions.js';
import { PeopleFilter, PeoplePage, Person, PersonContactsInput, PersonInput } from './person.model.js';
import { PeopleService } from './people.service.js';
import { VisibilityService } from './visibility.service.js';

@Resolver(() => Person)
export class PeopleResolver {
  constructor(
    private readonly service: PeopleService,
    private readonly members: MembersService,
    private readonly visibility: VisibilityService,
  ) {}

  @Query(() => PeoplePage, { description: 'Persone visibili: tutte per la segreteria, quelle delle proprie squadre per lo staff.' })
  @RequirePermission(Permission.ClubView)
  people(
    @CurrentTenant() access: TenantAccess,
    @CurrentUserId() userId: string,
    @Args('filter', { type: () => PeopleFilter, nullable: true }) filter: PeopleFilter | null,
    @Args('limit', { type: () => Int, defaultValue: 50 }) limit: number,
    @Args('offset', { type: () => Int, defaultValue: 0 }) offset: number,
  ): Promise<PeoplePage> {
    return this.service.list(access, userId, filter ?? {}, limit, offset);
  }

  @Query(() => Person)
  @RequirePermission(Permission.ClubView)
  person(
    @CurrentTenant() access: TenantAccess,
    @CurrentUserId() userId: string,
    @Args('id', { type: () => ID }) id: string,
  ): Promise<Person> {
    return this.service.get(access, userId, id);
  }

  @Query(() => [Person], { description: "Scheda dell'utente e dei minori di cui è tutore." })
  @RequirePermission(Permission.ClubView)
  myPeople(@CurrentTenant() access: TenantAccess, @CurrentUserId() userId: string): Promise<Person[]> {
    return this.service.mine(access, userId);
  }

  @Mutation(() => Person)
  @RequirePermission(Permission.PeopleManage)
  createPerson(
    @CurrentTenant() access: TenantAccess,
    @CurrentUserId() userId: string,
    @Args('input') input: PersonInput,
  ): Promise<Person> {
    return this.service.create(access, userId, input);
  }

  @Mutation(() => Person)
  @RequirePermission(Permission.PeopleManage)
  updatePerson(
    @CurrentTenant() access: TenantAccess,
    @CurrentUserId() userId: string,
    @Args('id', { type: () => ID }) id: string,
    @Args('input') input: PersonInput,
  ): Promise<Person> {
    return this.service.update(access, userId, id, input);
  }

  @Mutation(() => Person, { description: 'Recapiti: modificabili anche dalla persona stessa e dai suoi tutori.' })
  @RequirePermission(Permission.ClubView)
  updatePersonContacts(
    @CurrentTenant() access: TenantAccess,
    @CurrentUserId() userId: string,
    @Args('id', { type: () => ID }) id: string,
    @Args('input') input: PersonContactsInput,
  ): Promise<Person> {
    return this.service.updateContacts(access, userId, id, input);
  }

  @Mutation(() => Person)
  @RequirePermission(Permission.PeopleManage)
  setPersonArchived(
    @CurrentTenant() access: TenantAccess,
    @CurrentUserId() userId: string,
    @Args('id', { type: () => ID }) id: string,
    @Args('archived', { type: () => Boolean }) archived: boolean,
  ): Promise<Person> {
    return this.service.setArchived(access, userId, id, archived);
  }

  @Mutation(() => Person, { description: 'Restituisce la scheda del minore aggiornata.' })
  @RequirePermission(Permission.PeopleManage)
  addGuardian(
    @CurrentTenant() access: TenantAccess,
    @CurrentUserId() userId: string,
    @Args('minorId', { type: () => ID }) minorId: string,
    @Args('guardianId', { type: () => ID }) guardianId: string,
    @Args('relation', { type: () => GuardianRelationEnum, defaultValue: GuardianRelationEnum.GUARDIAN })
    relation: GuardianRelationEnum,
  ): Promise<Person> {
    return this.service.addGuardian(access, userId, minorId, guardianId, relation);
  }

  @Mutation(() => Person, { description: 'Restituisce la scheda del minore aggiornata.' })
  @RequirePermission(Permission.PeopleManage)
  removeGuardian(
    @CurrentTenant() access: TenantAccess,
    @CurrentUserId() userId: string,
    @Args('guardianshipId', { type: () => ID }) guardianshipId: string,
  ): Promise<Person> {
    return this.service.removeGuardian(access, userId, guardianshipId);
  }

  @Mutation(() => Invitation, {
    description:
      "Invita la persona ad attivare un account collegato alla scheda. La segreteria può usare ogni ruolo " +
      "consentito; un tutore può solo attivare l'account ATHLETE di un figlio dai 14 anni.",
  })
  @RequirePermission(Permission.ClubView)
  async invitePersonAccount(
    @CurrentTenant() access: TenantAccess,
    @CurrentUserId() userId: string,
    @Args('personId', { type: () => ID }) personId: string,
    @Args('email') email: string,
    @Args('role', { type: () => MembershipRoleEnum }) role: MembershipRoleEnum,
  ): Promise<Invitation> {
    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) throw appError('BAD_USER_INPUT', 'E-mail non valida');
    const input = { email, role, personId };
    if (hasPermission(access, Permission.PeopleManage)) return this.members.invite(access, userId, input);
    const v = await this.visibility.forUser(access, userId);
    if (role === MembershipRoleEnum.ATHLETE && v.wardPersonIds.includes(personId)) {
      return this.members.createInvitation(access, userId, input);
    }
    throw appError('FORBIDDEN');
  }
}
