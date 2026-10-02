import { Field, GraphQLISODateTime, ID, InputType, Int, ObjectType } from '@nestjs/graphql';
import {
  ArrayUnique,
  IsArray,
  IsEmail,
  IsEnum,
  IsISO8601,
  IsOptional,
  IsString,
  Length,
  Matches,
  MaxLength,
} from 'class-validator';
import {
  GuardianRelationEnum,
  PersonCategoryEnum,
  PersonGenderEnum,
  StaffRoleEnum,
} from '../common/enums.js';

@ObjectType({ description: 'Riferimento sintetico a una persona.' })
export class PersonRef {
  @Field(() => ID) id: string;
  @Field(() => String) firstName: string;
  @Field(() => String) lastName: string;
  @Field(() => String, { nullable: true }) email: string | null;
  @Field(() => String, { nullable: true }) phone: string | null;
}

@ObjectType()
export class GuardianLink {
  @Field(() => ID, { description: 'Id del legame di tutela' }) id: string;
  @Field(() => GuardianRelationEnum) relation: GuardianRelationEnum;
  @Field(() => PersonRef) person: PersonRef;
}

@ObjectType({ description: 'Squadra in cui la persona gioca o fa parte dello staff.' })
export class PersonTeam {
  @Field(() => ID) teamId: string;
  @Field(() => String) teamName: string;
  @Field(() => String) seasonName: string;
  @Field(() => Boolean) asPlayer: boolean;
  @Field(() => StaffRoleEnum, { nullable: true }) staffRole: StaffRoleEnum | null;
  @Field(() => Int, { nullable: true }) jerseyNumber: number | null;
}

@ObjectType({
  description:
    'Scheda anagrafica. Codice fiscale, luogo di nascita, indirizzo e note sono visibili solo a chi gestisce ' +
    "l'anagrafica, alla persona stessa e ai suoi tutori; per gli altri sono null.",
})
export class Person {
  @Field(() => ID) id: string;
  @Field(() => String) firstName: string;
  @Field(() => String) lastName: string;
  @Field(() => String, { nullable: true, description: 'Data ISO (YYYY-MM-DD)' }) birthDate: string | null;
  @Field(() => String, { nullable: true }) birthPlace: string | null;
  @Field(() => String, { nullable: true }) taxCode: string | null;
  @Field(() => PersonGenderEnum, { nullable: true }) gender: PersonGenderEnum | null;
  @Field(() => [PersonCategoryEnum]) categories: PersonCategoryEnum[];
  @Field(() => String, { nullable: true }) email: string | null;
  @Field(() => String, { nullable: true }) phone: string | null;
  @Field(() => String, { nullable: true }) addressLine: string | null;
  @Field(() => String, { nullable: true }) city: string | null;
  @Field(() => String, { nullable: true }) province: string | null;
  @Field(() => String, { nullable: true }) postalCode: string | null;
  @Field(() => String, { nullable: true }) notes: string | null;
  @Field(() => Int, { nullable: true }) age: number | null;
  @Field(() => Boolean) isMinor: boolean;
  @Field(() => Boolean, { description: 'Collegata a un account Huddle' }) hasAccount: boolean;
  @Field(() => GraphQLISODateTime, { nullable: true }) archivedAt: Date | null;
  @Field(() => [GuardianLink]) guardians: GuardianLink[];
  @Field(() => [GuardianLink], { description: 'Minori di cui è tutore' }) wards: GuardianLink[];
  @Field(() => [PersonTeam]) teams: PersonTeam[];
}

@ObjectType()
export class PeoplePage {
  @Field(() => [Person]) items: Person[];
  @Field(() => Int) total: number;
}

@InputType()
export class PeopleFilter {
  @Field(() => String, { nullable: true }) @IsOptional() @IsString() @MaxLength(100) search?: string;
  @Field(() => PersonCategoryEnum, { nullable: true }) @IsOptional() @IsEnum(PersonCategoryEnum) category?: PersonCategoryEnum;
  @Field(() => ID, { nullable: true }) @IsOptional() @IsString() teamId?: string;
  @Field(() => Boolean, { nullable: true }) @IsOptional() includeArchived?: boolean;
}

@InputType()
export class PersonContactsInput {
  @Field(() => String, { nullable: true }) @IsOptional() @IsEmail() email?: string | null;
  @Field(() => String, { nullable: true }) @IsOptional() @IsString() @Length(4, 30) phone?: string | null;
  @Field(() => String, { nullable: true }) @IsOptional() @IsString() @MaxLength(200) addressLine?: string | null;
  @Field(() => String, { nullable: true }) @IsOptional() @IsString() @MaxLength(100) city?: string | null;
  @Field(() => String, { nullable: true }) @IsOptional() @Matches(/^[A-Z]{2}$/i) province?: string | null;
  @Field(() => String, { nullable: true }) @IsOptional() @Matches(/^[0-9]{5}$/) postalCode?: string | null;
}

@InputType()
export class PersonInput extends PersonContactsInput {
  @Field(() => String) @IsString() @Length(1, 80) firstName: string;
  @Field(() => String) @IsString() @Length(1, 80) lastName: string;
  @Field(() => String, { nullable: true }) @IsOptional() @IsISO8601({ strict: true }) birthDate?: string | null;
  @Field(() => String, { nullable: true }) @IsOptional() @IsString() @MaxLength(100) birthPlace?: string | null;
  @Field(() => String, { nullable: true, description: 'Validato con il carattere di controllo' })
  @IsOptional()
  @IsString()
  taxCode?: string | null;
  @Field(() => PersonGenderEnum, { nullable: true }) @IsOptional() @IsEnum(PersonGenderEnum) gender?: PersonGenderEnum | null;
  @Field(() => [PersonCategoryEnum], { nullable: true })
  @IsOptional()
  @IsArray()
  @ArrayUnique()
  @IsEnum(PersonCategoryEnum, { each: true })
  categories?: PersonCategoryEnum[];
  @Field(() => String, { nullable: true }) @IsOptional() @IsString() @MaxLength(2000) notes?: string | null;
}
