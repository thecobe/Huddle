import { Field, GraphQLISODateTime, ID, InputType, ObjectType } from '@nestjs/graphql';
import { IsArray, IsEmail, IsOptional, IsString, Length, Matches } from 'class-validator';

@ObjectType()
export class Club {
  @Field(() => ID) id: string;
  @Field(() => String) name: string;
  @Field(() => String, { nullable: true }) legalName: string | null;
  @Field(() => String, { nullable: true, description: 'Codice fiscale' }) taxCode: string | null;
  @Field(() => String, { nullable: true, description: 'Partita IVA' }) vatNumber: string | null;
  @Field(() => String) sport: string;
  @Field(() => String, { nullable: true }) email: string | null;
  @Field(() => String, { nullable: true }) phone: string | null;
  @Field(() => String, { nullable: true }) addressLine: string | null;
  @Field(() => String, { nullable: true }) city: string | null;
  @Field(() => String, { nullable: true }) province: string | null;
  @Field(() => String, { nullable: true }) postalCode: string | null;
  @Field(() => String) country: string;
  @Field(() => [String], { description: 'Federazioni ed enti di promozione sportiva di affiliazione' })
  federations: string[];
  @Field(() => String, { description: 'Fuso orario della società (IANA), per date e orari' }) timezone: string;
  @Field(() => GraphQLISODateTime) createdAt: Date;
}

@InputType()
export class ClubInput {
  @Field(() => String) @IsString() @Length(2, 120) name: string;
  @Field(() => String, { nullable: true }) @IsOptional() @IsString() @Length(2, 200) legalName?: string | null;
  @Field(() => String, { nullable: true })
  @IsOptional()
  @Matches(/^([0-9]{11}|[A-Z0-9]{16})$/i, { message: 'Codice fiscale non valido' })
  taxCode?: string | null;
  @Field(() => String, { nullable: true })
  @IsOptional()
  @Matches(/^[0-9]{11}$/, { message: 'Partita IVA non valida' })
  vatNumber?: string | null;
  @Field(() => String, { nullable: true }) @IsOptional() @IsString() sport?: string;
  @Field(() => String, { nullable: true }) @IsOptional() @IsEmail() email?: string | null;
  @Field(() => String, { nullable: true }) @IsOptional() @IsString() @Length(4, 30) phone?: string | null;
  @Field(() => String, { nullable: true }) @IsOptional() @IsString() addressLine?: string | null;
  @Field(() => String, { nullable: true }) @IsOptional() @IsString() city?: string | null;
  @Field(() => String, { nullable: true }) @IsOptional() @Matches(/^[A-Z]{2}$/i) province?: string | null;
  @Field(() => String, { nullable: true }) @IsOptional() @Matches(/^[0-9]{5}$/) postalCode?: string | null;
  @Field(() => [String], { nullable: true }) @IsOptional() @IsArray() @IsString({ each: true }) federations?: string[];
}
