import { Field, GraphQLISODateTime, ID, InputType, ObjectType } from '@nestjs/graphql';
import { IsISO8601, IsString, Length } from 'class-validator';
import { SeasonStatusEnum } from '../common/enums.js';

@ObjectType()
export class Season {
  @Field(() => ID) id: string;
  @Field(() => String) name: string;
  @Field(() => String, { description: 'Data ISO (YYYY-MM-DD)' }) startsOn: string;
  @Field(() => String, { description: 'Data ISO (YYYY-MM-DD)' }) endsOn: string;
  @Field(() => SeasonStatusEnum) status: SeasonStatusEnum;
  @Field(() => GraphQLISODateTime) createdAt: Date;
}

@InputType()
export class SeasonInput {
  @Field(() => String) @IsString() @Length(2, 40) name: string;
  @Field(() => String) @IsISO8601({ strict: true }) startsOn: string;
  @Field(() => String) @IsISO8601({ strict: true }) endsOn: string;
}
