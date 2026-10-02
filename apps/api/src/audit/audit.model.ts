import { Field, GraphQLISODateTime, ID, ObjectType } from '@nestjs/graphql';
import { GraphQLJSON } from '../common/json.scalar.js';

@ObjectType()
export class AuditEvent {
  @Field(() => ID) id: string;
  @Field(() => String) action: string;
  @Field(() => String, { nullable: true }) actorUserId: string | null;
  @Field(() => String, { nullable: true }) actorName: string | null;
  @Field(() => String, { nullable: true }) entityType: string | null;
  @Field(() => String, { nullable: true }) entityId: string | null;
  @Field(() => GraphQLJSON) metadata: Record<string, unknown>;
  @Field(() => GraphQLISODateTime) createdAt: Date;
}
