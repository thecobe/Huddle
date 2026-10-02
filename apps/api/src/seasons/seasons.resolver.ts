import { Args, ID, Mutation, Query, Resolver } from '@nestjs/graphql';
import { RequirePermission } from '../common/decorators.js';
import { SeasonStatusEnum } from '../common/enums.js';
import { Permission } from '../permissions/permissions.js';
import { Season, SeasonInput } from './season.model.js';
import { SeasonsService } from './seasons.service.js';

@Resolver(() => Season)
export class SeasonsResolver {
  constructor(private readonly service: SeasonsService) {}

  @Query(() => [Season])
  @RequirePermission(Permission.SeasonView)
  seasons(): Promise<Season[]> {
    return this.service.list();
  }

  @Mutation(() => Season)
  @RequirePermission(Permission.SeasonManage)
  createSeason(@Args('input') input: SeasonInput): Promise<Season> {
    return this.service.create(input);
  }

  @Mutation(() => Season)
  @RequirePermission(Permission.SeasonManage)
  setSeasonStatus(
    @Args('id', { type: () => ID }) id: string,
    @Args('status', { type: () => SeasonStatusEnum }) status: SeasonStatusEnum,
  ): Promise<Season> {
    return this.service.setStatus(id, status);
  }
}
