import { Field, GraphQLISODateTime, ID, InputType, ObjectType } from '@nestjs/graphql';
import { Equals, IsEmail, IsEnum, IsOptional, IsString, IsUUID, Length, MinLength } from 'class-validator';
import { MembershipRoleEnum } from '../common/enums.js';
import { MIN_PASSWORD_LENGTH } from '../auth/password.service.js';

@ObjectType()
export class Member {
  @Field(() => ID) membershipId: string;
  @Field(() => ID) userId: string;
  @Field(() => String) fullName: string;
  @Field(() => String) email: string;
  @Field(() => MembershipRoleEnum) role: MembershipRoleEnum;
  @Field(() => ID, { nullable: true }) teamId: string | null;
  @Field(() => GraphQLISODateTime) createdAt: Date;
}

@ObjectType()
export class Invitation {
  @Field(() => ID) id: string;
  @Field(() => String) email: string;
  @Field(() => MembershipRoleEnum) role: MembershipRoleEnum;
  @Field(() => ID, { nullable: true }) teamId: string | null;
  @Field(() => GraphQLISODateTime) expiresAt: Date;
  @Field(() => GraphQLISODateTime, { nullable: true }) acceptedAt: Date | null;
  @Field(() => GraphQLISODateTime, { nullable: true }) revokedAt: Date | null;
  @Field(() => GraphQLISODateTime) createdAt: Date;
}

@ObjectType({ description: "Anteprima pubblica di un invito, mostrata prima dell'accettazione." })
export class InvitationPreview {
  @Field(() => ID) clubId: string;
  @Field(() => String) clubName: string;
  @Field(() => String) email: string;
  @Field(() => MembershipRoleEnum) role: MembershipRoleEnum;
  @Field(() => GraphQLISODateTime) expiresAt: Date;
  @Field(() => Boolean, { description: "Esiste già un account con questa e-mail" }) accountExists: boolean;
}

@InputType()
export class InviteMemberInput {
  @Field(() => String) @IsEmail() email: string;
  @Field(() => MembershipRoleEnum) @IsEnum(MembershipRoleEnum) role: MembershipRoleEnum;
  @Field(() => ID, { nullable: true }) @IsOptional() @IsUUID() teamId?: string | null;
  @Field(() => ID, {
    nullable: true,
    description: "Scheda da collegare all'account. Obbligatoria per il ruolo ATHLETE (dai 14 anni).",
  })
  @IsOptional()
  @IsUUID()
  personId?: string | null;
}

@InputType()
export class AcceptInvitationInput {
  @Field(() => String) @IsString() token: string;
  @Field(() => String, { nullable: true, description: 'Obbligatorio se non esiste ancora un account' })
  @IsOptional()
  @IsString()
  @Length(2, 120)
  fullName?: string;
  @Field(() => String, { nullable: true, description: 'Facoltativa: le famiglie possono accedere solo con magic link' })
  @IsOptional()
  @IsString()
  @MinLength(MIN_PASSWORD_LENGTH)
  password?: string;
  @Field(() => Boolean) @Equals(true) acceptTerms: boolean;
}
