import { Field, GraphQLISODateTime, ID, InputType, Int, ObjectType } from '@nestjs/graphql';
import { IsDate, IsEnum, IsOptional, IsString, IsUUID, MaxLength } from 'class-validator';
import { AttendanceResultEnum, AttendanceStatusEnum, EventKindEnum } from '../common/enums.js';

@InputType()
export class AttendanceEntryInput {
  @Field(() => ID, { description: 'UUID generato dal client: rende idempotente il reinvio' }) @IsUUID() clientMutationId: string;
  @Field(() => ID) @IsUUID() eventId: string;
  @Field(() => ID) @IsUUID() personId: string;
  @Field(() => AttendanceStatusEnum) @IsEnum(AttendanceStatusEnum) status: AttendanceStatusEnum;
  @Field(() => String, { nullable: true }) @IsOptional() @IsString() @MaxLength(500) note?: string | null;
  @Field(() => GraphQLISODateTime, { description: 'Momento della registrazione sul dispositivo' }) @IsDate() recordedAt: Date;
}

@ObjectType()
export class AttendanceEntryResult {
  @Field(() => ID) clientMutationId: string;
  @Field(() => AttendanceResultEnum) result: AttendanceResultEnum;
  @Field(() => String, { nullable: true, description: 'Codice errore se REJECTED' }) code: string | null;
}

@ObjectType()
export class AbsenceNotice {
  @Field(() => ID) id: string;
  @Field(() => String, { nullable: true }) reason: string | null;
  @Field(() => GraphQLISODateTime) createdAt: Date;
}

@ObjectType()
export class RollCallPlayer {
  @Field(() => ID) personId: string;
  @Field(() => String) firstName: string;
  @Field(() => String) lastName: string;
  @Field(() => Int, { nullable: true }) jerseyNumber: number | null;
  @Field(() => AttendanceStatusEnum, { nullable: true, description: 'Null se non ancora registrato' }) status: AttendanceStatusEnum | null;
  @Field(() => String, { nullable: true }) note: string | null;
  @Field(() => AbsenceNotice, { nullable: true }) absenceNotice: AbsenceNotice | null;
  @Field(() => Boolean, { description: 'Non più in rosa ma con una presenza registrata' }) formerPlayer: boolean;
}

@ObjectType()
export class RollCall {
  @Field(() => ID) eventId: string;
  @Field(() => ID) teamId: string;
  @Field(() => String) teamName: string;
  @Field(() => EventKindEnum) kind: EventKindEnum;
  @Field(() => String, { nullable: true }) title: string | null;
  @Field(() => String, { nullable: true }) opponent: string | null;
  @Field(() => GraphQLISODateTime) startsAt: Date;
  @Field(() => GraphQLISODateTime) endsAt: Date;
  @Field(() => Boolean) cancelled: boolean;
  @Field(() => GraphQLISODateTime, { nullable: true }) completedAt: Date | null;
  @Field(() => Boolean, { description: "L'utente può modificare l'appello adesso" }) editable: boolean;
  @Field(() => GraphQLISODateTime, { nullable: true, description: 'Fine della finestra di modifica per lo staff' })
  editableUntil: Date | null;
  @Field(() => [RollCallPlayer]) players: RollCallPlayer[];
}

@ObjectType()
export class RegisterEvent {
  @Field(() => ID) id: string;
  @Field(() => GraphQLISODateTime) startsAt: Date;
  @Field(() => EventKindEnum) kind: EventKindEnum;
  @Field(() => String, { nullable: true }) title: string | null;
  @Field(() => String, { nullable: true }) opponent: string | null;
  @Field(() => Boolean) rollCallDone: boolean;
}

@ObjectType()
export class RegisterCell {
  @Field(() => ID) eventId: string;
  @Field(() => ID) personId: string;
  @Field(() => AttendanceStatusEnum) status: AttendanceStatusEnum;
  @Field(() => String, { nullable: true }) note: string | null;
}

@ObjectType()
export class RegisterPlayer {
  @Field(() => ID) personId: string;
  @Field(() => String) firstName: string;
  @Field(() => String) lastName: string;
  @Field(() => Int, { nullable: true }) jerseyNumber: number | null;
  @Field(() => Int, { description: 'Eventi con presenza registrata' }) recorded: number;
  @Field(() => Int, { description: 'Presenti o in ritardo' }) attended: number;
  @Field(() => Int) excused: number;
  @Field(() => Int, { nullable: true, description: 'attended / recorded in percentuale; null se nessuna registrazione' })
  percentage: number | null;
}

@ObjectType()
export class AttendanceRegister {
  @Field(() => [RegisterEvent]) events: RegisterEvent[];
  @Field(() => [RegisterPlayer]) players: RegisterPlayer[];
  @Field(() => [RegisterCell]) cells: RegisterCell[];
}

@ObjectType({ description: "Partecipazione di una persona (sé stessi o un figlio) a un evento." })
export class Participation {
  @Field(() => ID) personId: string;
  @Field(() => String) firstName: string;
  @Field(() => String) lastName: string;
  @Field(() => AttendanceStatusEnum, { nullable: true }) status: AttendanceStatusEnum | null;
  @Field(() => AbsenceNotice, { nullable: true }) absenceNotice: AbsenceNotice | null;
  @Field(() => Boolean, { description: 'Si può ancora segnalare o ritirare un’assenza' }) canReport: boolean;
}

@ObjectType()
export class PersonAttendance {
  @Field(() => ID) eventId: string;
  @Field(() => GraphQLISODateTime) startsAt: Date;
  @Field(() => EventKindEnum) kind: EventKindEnum;
  @Field(() => String, { nullable: true }) title: string | null;
  @Field(() => String, { nullable: true }) opponent: string | null;
  @Field(() => String) teamName: string;
  @Field(() => AttendanceStatusEnum) status: AttendanceStatusEnum;
}
