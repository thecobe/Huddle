import { Args, Mutation, Query, Resolver } from '@nestjs/graphql';
import { CurrentUserId } from '../common/decorators.js';
import { GraphQLJSON } from '../common/json.scalar.js';
import { Me } from './user.model.js';
import { UpdateMeInput } from './user.inputs.js';
import { UsersService } from './users.service.js';

@Resolver(() => Me)
export class UsersResolver {
  constructor(private readonly users: UsersService) {}

  @Query(() => Me)
  me(@CurrentUserId() userId: string): Promise<Me> {
    return this.users.getMe(userId);
  }

  @Mutation(() => Me)
  updateMe(@CurrentUserId() userId: string, @Args('input') input: UpdateMeInput): Promise<Me> {
    return this.users.update(userId, input);
  }

  @Query(() => GraphQLJSON, { description: 'Esportazione dei dati personali (GDPR art. 15)' })
  myDataExport(@CurrentUserId() userId: string): Promise<Record<string, unknown>> {
    return this.users.exportData(userId);
  }
}
