import { Field, InputType, Int, ObjectType, registerEnumType } from '@nestjs/graphql';
import { IsInt, IsOptional, IsString, Max, MaxLength, Min } from 'class-validator';

export enum ImportRowStatus {
  CREATE = 'CREATE',
  UPDATE = 'UPDATE',
  ERROR = 'ERROR',
}
registerEnumType(ImportRowStatus, { name: 'ImportRowStatus' });

/** Riga già letta dal file (CSV o Excel) nel browser; tutti i campi sono testo grezzo. */
@InputType()
export class PersonImportRow {
  @Field(() => String, { nullable: true }) @IsOptional() @IsString() @MaxLength(80) firstName?: string;
  @Field(() => String, { nullable: true }) @IsOptional() @IsString() @MaxLength(80) lastName?: string;
  @Field(() => String, { nullable: true, description: 'YYYY-MM-DD oppure GG/MM/AAAA' }) @IsOptional() @IsString() @MaxLength(20) birthDate?: string;
  @Field(() => String, { nullable: true }) @IsOptional() @IsString() @MaxLength(100) birthPlace?: string;
  @Field(() => String, { nullable: true }) @IsOptional() @IsString() @MaxLength(20) taxCode?: string;
  @Field(() => String, { nullable: true, description: 'F o M' }) @IsOptional() @IsString() @MaxLength(10) gender?: string;
  @Field(() => String, { nullable: true }) @IsOptional() @IsString() @MaxLength(200) email?: string;
  @Field(() => String, { nullable: true }) @IsOptional() @IsString() @MaxLength(30) phone?: string;
  @Field(() => String, { nullable: true }) @IsOptional() @IsString() @MaxLength(200) addressLine?: string;
  @Field(() => String, { nullable: true }) @IsOptional() @IsString() @MaxLength(100) city?: string;
  @Field(() => String, { nullable: true }) @IsOptional() @IsString() @MaxLength(10) province?: string;
  @Field(() => String, { nullable: true }) @IsOptional() @IsString() @MaxLength(10) postalCode?: string;
  @Field(() => String, { nullable: true, description: 'Squadra della stagione aperta in cui inserire la persona come atleta' })
  @IsOptional()
  @IsString()
  @MaxLength(60)
  teamName?: string;
  @Field(() => Int, { nullable: true }) @IsOptional() @IsInt() @Min(0) @Max(99) jerseyNumber?: number;
  @Field(() => String, { nullable: true }) @IsOptional() @IsString() @MaxLength(80) guardianFirstName?: string;
  @Field(() => String, { nullable: true }) @IsOptional() @IsString() @MaxLength(80) guardianLastName?: string;
  @Field(() => String, { nullable: true }) @IsOptional() @IsString() @MaxLength(200) guardianEmail?: string;
  @Field(() => String, { nullable: true }) @IsOptional() @IsString() @MaxLength(30) guardianPhone?: string;
}

@ObjectType()
export class PersonImportResult {
  @Field(() => Int, { description: 'Posizione della riga nel file inviato (da 0)' }) index: number;
  @Field(() => ImportRowStatus) status: ImportRowStatus;
  @Field(() => [String], { description: 'Codici errore: vedi errori di import nel client' }) errors: string[];
  @Field(() => String, { nullable: true }) personId: string | null;
}

@ObjectType()
export class PeopleImportSummary {
  @Field(() => Int) created: number;
  @Field(() => Int) updated: number;
  @Field(() => Int) guardiansLinked: number;
  @Field(() => Int) addedToTeams: number;
}
