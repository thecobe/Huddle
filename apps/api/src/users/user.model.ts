import { Field, ID, ObjectType } from '@nestjs/graphql';
import { MembershipRoleEnum } from '../common/enums.js';

@ObjectType()
export class MembershipSummary {
  @Field(() => ID) id: string;
  @Field(() => MembershipRoleEnum) role: MembershipRoleEnum;
  @Field(() => ID, { nullable: true }) teamId: string | null;
  @Field(() => ID) clubId: string;
  @Field(() => String) clubName: string;
}

@ObjectType()
export class Me {
  @Field(() => ID) id: string;
  @Field(() => String) email: string;
  @Field(() => String) fullName: string;
  @Field(() => String) locale: string;
  @Field(() => Boolean) twoFactorEnabled: boolean;
  @Field(() => [MembershipSummary]) memberships: MembershipSummary[];
}
