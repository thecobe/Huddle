import { Args, Mutation, Query, Resolver } from '@nestjs/graphql';
import { CurrentUserId, RequirePermission } from '../common/decorators.js';
import { Permission } from '../permissions/permissions.js';
import { Club, ClubInput } from './club.model.js';
import { ClubsService } from './clubs.service.js';

@Resolver(() => Club)
export class ClubsResolver {
  constructor(private readonly clubs: ClubsService) {}

  @Mutation(() => Club, { description: "Crea una società; l'utente ne diventa amministratore." })
  createClub(@CurrentUserId() userId: string, @Args('input') input: ClubInput): Promise<Club> {
    return this.clubs.create(userId, input);
  }

  @Query(() => Club, { description: 'Società corrente (header X-Tenant-Id).' })
  @RequirePermission(Permission.ClubView)
  club(): Promise<Club> {
    return this.clubs.get();
  }

  @Mutation(() => Club)
  @RequirePermission(Permission.ClubManage)
  updateClub(@Args('input') input: ClubInput): Promise<Club> {
    return this.clubs.update(input);
  }
}
