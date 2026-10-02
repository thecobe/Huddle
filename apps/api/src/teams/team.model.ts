import { Field, GraphQLISODateTime, ID, InputType, Int, ObjectType } from '@nestjs/graphql';
import { IsInt, IsOptional, IsString, IsUUID, Length, Matches, Max, MaxLength, Min } from 'class-validator';
import { GuardianRelationEnum, PlayerAvailabilityEnum, StaffRoleEnum } from '../common/enums.js';

@ObjectType()
export class Team {
  @Field(() => ID) id: string;
  @Field(() => ID) seasonId: string;
  @Field(() => String) seasonName: string;
  @Field(() => String) name: string;
  @Field(() => String, { nullable: true }) category: string | null;
  @Field(() => Int, { nullable: true }) birthYearFrom: number | null;
  @Field(() => Int, { nullable: true }) birthYearTo: number | null;
  @Field(() => String, { nullable: true }) color: string | null;
  @Field(() => Int) playerCount: number;
  @Field(() => Int) staffCount: number;
  @Field(() => GraphQLISODateTime, { nullable: true }) archivedAt: Date | null;
}

@ObjectType({ description: 'Recapito di un tutore, per chi gestisce la squadra.' })
export class GuardianContact {
  @Field(() => ID) personId: string;
  @Field(() => String) name: string;
  @Field(() => GuardianRelationEnum) relation: GuardianRelationEnum;
  @Field(() => String, { nullable: true }) email: string | null;
  @Field(() => String, { nullable: true }) phone: string | null;
}

@ObjectType()
export class RosterPlayer {
  @Field(() => ID, { description: 'Id della riga di rosa' }) id: string;
  @Field(() => ID) personId: string;
  @Field(() => String) firstName: string;
  @Field(() => String) lastName: string;
  @Field(() => String, { nullable: true }) birthDate: string | null;
  @Field(() => Int, { nullable: true }) jerseyNumber: number | null;
  @Field(() => String, { nullable: true }) position: string | null;
  @Field(() => PlayerAvailabilityEnum) availability: PlayerAvailabilityEnum;
  @Field(() => String, { nullable: true }) availabilityNote: string | null;
  @Field(() => String, { nullable: true }) email: string | null;
  @Field(() => String, { nullable: true }) phone: string | null;
  @Field(() => [GuardianContact]) guardians: GuardianContact[];
}

@ObjectType()
export class RosterStaff {
  @Field(() => ID, { description: 'Id della riga di staff' }) id: string;
  @Field(() => ID) personId: string;
  @Field(() => String) firstName: string;
  @Field(() => String) lastName: string;
  @Field(() => StaffRoleEnum) role: StaffRoleEnum;
  @Field(() => String, { nullable: true }) email: string | null;
  @Field(() => String, { nullable: true }) phone: string | null;
  @Field(() => Boolean) hasAccount: boolean;
}

@ObjectType()
export class TeamDetail extends Team {
  @Field(() => [RosterPlayer]) players: RosterPlayer[];
  @Field(() => [RosterStaff]) staff: RosterStaff[];
}

@InputType()
export class TeamInput {
  @Field(() => ID) @IsUUID() seasonId: string;
  @Field(() => String) @IsString() @Length(1, 60) name: string;
  @Field(() => String, { nullable: true }) @IsOptional() @IsString() @MaxLength(60) category?: string | null;
  @Field(() => Int, { nullable: true }) @IsOptional() @IsInt() @Min(1900) @Max(2100) birthYearFrom?: number | null;
  @Field(() => Int, { nullable: true }) @IsOptional() @IsInt() @Min(1900) @Max(2100) birthYearTo?: number | null;
  @Field(() => String, { nullable: true }) @IsOptional() @Matches(/^#[0-9a-f]{6}$/i) color?: string | null;
}

@InputType()
export class PlayerInput {
  @Field(() => Int, { nullable: true }) @IsOptional() @IsInt() @Min(0) @Max(99) jerseyNumber?: number | null;
  @Field(() => String, { nullable: true }) @IsOptional() @IsString() @MaxLength(40) position?: string | null;
}

@InputType()
export class CopyTeamsInput {
  @Field(() => ID) @IsUUID() fromSeasonId: string;
  @Field(() => ID) @IsUUID() toSeasonId: string;
  @Field(() => Boolean, { description: 'Copia anche gli atleti (lo staff viene sempre copiato)' }) includePlayers: boolean;
}

