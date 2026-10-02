import { Field, GraphQLISODateTime, InputType, ObjectType, registerEnumType } from '@nestjs/graphql';
import { Equals, IsEmail, IsIn, IsOptional, IsString, Length, MinLength } from 'class-validator';
import { Me } from '../users/user.model.js';
import { MIN_PASSWORD_LENGTH } from './password.service.js';

export enum AuthStatus {
  AUTHENTICATED = 'AUTHENTICATED',
  TWO_FACTOR_REQUIRED = 'TWO_FACTOR_REQUIRED',
}
registerEnumType(AuthStatus, { name: 'AuthStatus' });

@ObjectType({
  description:
    'Esito di un accesso. Con AUTHENTICATED contiene i token; con TWO_FACTOR_REQUIRED il challengeToken da usare in verifyTwoFactor. ' +
    'Per il client web (header X-Huddle-Client: web) il refresh token è in un cookie httpOnly e refreshToken è null.',
})
export class AuthPayload {
  @Field(() => AuthStatus) status: AuthStatus;
  @Field(() => String, { nullable: true }) accessToken: string | null;
  @Field(() => GraphQLISODateTime, { nullable: true }) accessTokenExpiresAt: Date | null;
  @Field(() => String, { nullable: true }) refreshToken: string | null;
  @Field(() => String, { nullable: true }) challengeToken: string | null;
  @Field(() => Me, { nullable: true }) user: Me | null;
}

@ObjectType()
export class TwoFactorSetup {
  @Field(() => String) secret: string;
  @Field(() => String) otpauthUri: string;
}

@InputType()
export class RegisterInput {
  @Field(() => String) @IsEmail() email: string;
  @Field(() => String) @IsString() @MinLength(MIN_PASSWORD_LENGTH) password: string;
  @Field(() => String) @IsString() @Length(2, 120) fullName: string;
  @Field(() => String, { nullable: true }) @IsOptional() @IsIn(['it', 'en']) locale?: string;
  @Field(() => Boolean, { description: 'Accettazione di informativa privacy e termini di servizio' })
  @Equals(true)
  acceptTerms: boolean;
}

@InputType()
export class LoginInput {
  @Field(() => String) @IsEmail() email: string;
  @Field(() => String) @IsString() password: string;
}
