import { Args, Field, GraphQLISODateTime, ID, Mutation, ObjectType, Query, Resolver } from '@nestjs/graphql';
import { CurrentUserId, GqlRequest } from '../common/decorators.js';
import { ConsentKindEnum } from '../common/enums.js';
import type { GqlContext } from '../common/request-context.js';
import { ConsentsService, type ConsentState } from './consents.service.js';

@ObjectType()
export class Consent {
  @Field(() => ConsentKindEnum) kind: ConsentKindEnum;
  @Field(() => ID, { nullable: true, description: 'Null per i consensi validi su tutta la piattaforma' })
  clubId: string | null;
  @Field(() => String) version: string;
  @Field(() => Boolean) granted: boolean;
  @Field(() => GraphQLISODateTime) recordedAt: Date;
}

const toModel = (c: ConsentState): Consent => ({ ...c, kind: c.kind as ConsentKindEnum });

@Resolver(() => Consent)
export class ConsentsResolver {
  constructor(private readonly consents: ConsentsService) {}

  @Query(() => [Consent])
  async myConsents(@CurrentUserId() userId: string): Promise<Consent[]> {
    return (await this.consents.current(userId)).map(toModel);
  }

  @Mutation(() => Consent, {
    description: 'Registra un consenso. IMAGE_RELEASE e MARKETING richiedono la società corrente.',
  })
  async recordConsent(
    @CurrentUserId() userId: string,
    @GqlRequest() gql: GqlContext,
    @Args('kind', { type: () => ConsentKindEnum }) kind: ConsentKindEnum,
    @Args('granted', { type: () => Boolean }) granted: boolean,
  ): Promise<Consent> {
    const state = await this.consents.record(userId, gql.tenant?.tenantId ?? null, kind, granted, gql.req.ip ?? null);
    return toModel(state);
  }
}
