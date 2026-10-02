import { Field, InputType } from '@nestjs/graphql';
import { IsIn, IsOptional, IsString, Length } from 'class-validator';

@InputType()
export class UpdateMeInput {
  @Field(() => String, { nullable: true })
  @IsOptional()
  @IsString()
  @Length(2, 120)
  fullName?: string;

  @Field(() => String, { nullable: true })
  @IsOptional()
  @IsIn(['it', 'en'])
  locale?: string;
}
