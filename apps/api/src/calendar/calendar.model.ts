import { Field, GraphQLISODateTime, ID, InputType, Int, ObjectType } from '@nestjs/graphql';
import {
  ArrayMaxSize,
  ArrayMinSize,
  IsBoolean,
  IsDate,
  IsEnum,
  IsInt,
  IsISO8601,
  IsOptional,
  IsString,
  IsUUID,
  Matches,
  Max,
  MaxLength,
  Min,
} from 'class-validator';
import { EventKindEnum, EventStatusEnum } from '../common/enums.js';

@ObjectType()
export class CalendarEvent {
  @Field(() => ID) id: string;
  @Field(() => ID, { nullable: true, description: "Null per gli eventi di tutta la società" }) teamId: string | null;
  @Field(() => String, { nullable: true }) teamName: string | null;
  @Field(() => String, { nullable: true }) teamColor: string | null;
  @Field(() => ID, { nullable: true }) seriesId: string | null;
  @Field(() => Boolean, { description: 'Modificato rispetto alla serie: non viene più rigenerato' }) detached: boolean;
  @Field(() => EventKindEnum) kind: EventKindEnum;
  @Field(() => String, { nullable: true }) title: string | null;
  @Field(() => GraphQLISODateTime) startsAt: Date;
  @Field(() => GraphQLISODateTime) endsAt: Date;
  @Field(() => String, { nullable: true }) location: string | null;
  @Field(() => String, { nullable: true }) notes: string | null;
  @Field(() => EventStatusEnum) status: EventStatusEnum;
  @Field(() => String, { nullable: true }) cancelReason: string | null;
  @Field(() => String, { nullable: true }) opponent: string | null;
  @Field(() => Boolean, { nullable: true }) isHome: boolean | null;
  @Field(() => String, { nullable: true }) competition: string | null;
  @Field(() => Boolean, { description: "L'utente può modificare l'evento" }) canEdit: boolean;
}

@ObjectType()
export class EventSeries {
  @Field(() => ID) id: string;
  @Field(() => ID) teamId: string;
  @Field(() => String) teamName: string;
  @Field(() => EventKindEnum) kind: EventKindEnum;
  @Field(() => String, { nullable: true }) title: string | null;
  @Field(() => [Int], { description: 'Giorni ISO: 1 = lunedì … 7 = domenica' }) weekdays: number[];
  @Field(() => String, { description: 'HH:MM' }) startTime: string;
  @Field(() => Int) durationMinutes: number;
  @Field(() => String, { nullable: true }) location: string | null;
  @Field(() => String) startsOn: string;
  @Field(() => String) endsOn: string;
  @Field(() => Int, { description: 'Occorrenze future in programma' }) upcomingCount: number;
}

@InputType()
export class SeriesInput {
  @Field(() => ID) @IsUUID() teamId: string;
  @Field(() => String, { nullable: true }) @IsOptional() @IsString() @MaxLength(80) title?: string | null;
  @Field(() => [Int]) @ArrayMinSize(1) @ArrayMaxSize(7) @IsInt({ each: true }) @Min(1, { each: true }) @Max(7, { each: true })
  weekdays: number[];
  @Field(() => String, { description: 'HH:MM, ora locale della società' })
  @Matches(/^([01]\d|2[0-3]):[0-5]\d$/)
  startTime: string;
  @Field(() => Int) @IsInt() @Min(15) @Max(600) durationMinutes: number;
  @Field(() => String, { nullable: true }) @IsOptional() @IsString() @MaxLength(200) location?: string | null;
  @Field(() => String, { nullable: true, description: 'Predefinito: inizio della stagione o oggi' })
  @IsOptional()
  @IsISO8601({ strict: true })
  startsOn?: string | null;
  @Field(() => String, { nullable: true, description: 'Predefinito: fine della stagione' })
  @IsOptional()
  @IsISO8601({ strict: true })
  endsOn?: string | null;
}

@InputType()
export class EventInput {
  @Field(() => ID, { nullable: true, description: 'Null per un evento di tutta la società' })
  @IsOptional()
  @IsUUID()
  teamId?: string | null;
  @Field(() => EventKindEnum) @IsEnum(EventKindEnum) kind: EventKindEnum;
  @Field(() => String, { nullable: true }) @IsOptional() @IsString() @MaxLength(120) title?: string | null;
  @Field(() => GraphQLISODateTime) @IsDate() startsAt: Date;
  @Field(() => GraphQLISODateTime) @IsDate() endsAt: Date;
  @Field(() => String, { nullable: true }) @IsOptional() @IsString() @MaxLength(200) location?: string | null;
  @Field(() => String, { nullable: true }) @IsOptional() @IsString() @MaxLength(2000) notes?: string | null;
  @Field(() => String, { nullable: true }) @IsOptional() @IsString() @MaxLength(120) opponent?: string | null;
  @Field(() => Boolean, { nullable: true }) @IsOptional() @IsBoolean() isHome?: boolean | null;
  @Field(() => String, { nullable: true }) @IsOptional() @IsString() @MaxLength(120) competition?: string | null;
}

@InputType()
export class CancelRangeInput {
  @Field(() => String) @IsISO8601({ strict: true }) fromDate: string;
  @Field(() => String) @IsISO8601({ strict: true }) toDate: string;
  @Field(() => ID, { nullable: true, description: 'Null: tutte le squadre (es. chiusura impianto)' })
  @IsOptional()
  @IsUUID()
  teamId?: string | null;
  @Field(() => String, { nullable: true }) @IsOptional() @IsString() @MaxLength(200) reason?: string | null;
}

@ObjectType()
export class CalendarFeed {
  @Field(() => String, { description: 'Mostrato una sola volta: conservarlo o rigenerarlo' }) url: string;
}
