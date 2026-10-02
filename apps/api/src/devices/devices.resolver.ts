import { Args, Field, InputType, Mutation, Resolver } from '@nestjs/graphql';
import { IsEnum, IsOptional, IsString, Length } from 'class-validator';
import { sql } from 'kysely';
import { CurrentUserId } from '../common/decorators.js';
import { DevicePlatformEnum } from '../common/enums.js';
import { DbContext } from '../database/db-context.js';

@InputType()
export class RegisterDeviceInput {
  @Field(() => String, { description: 'Token FCM/APNs del dispositivo' })
  @IsString()
  @Length(10, 4096)
  token: string;

  @Field(() => DevicePlatformEnum) @IsEnum(DevicePlatformEnum) platform: DevicePlatformEnum;
  @Field(() => String, { nullable: true }) @IsOptional() @IsString() appVersion?: string;
}

/** Registrazione dei dispositivi per le notifiche push (invio in Fase 1). */
@Resolver()
export class DevicesResolver {
  constructor(private readonly ctx: DbContext) {}

  @Mutation(() => Boolean)
  async registerDevice(@CurrentUserId() userId: string, @Args('input') input: RegisterDeviceInput): Promise<boolean> {
    // Un token appartiene a un solo utente: se il dispositivo cambia account, passa al nuovo.
    await this.ctx.db
      .insertInto('device_tokens')
      .values({ user_id: userId, token: input.token, platform: input.platform, app_version: input.appVersion ?? null })
      .onConflict((oc) =>
        oc.column('token').doUpdateSet({
          user_id: userId,
          platform: input.platform,
          app_version: input.appVersion ?? null,
          last_seen_at: sql`now()`,
        }),
      )
      .execute();
    return true;
  }

  @Mutation(() => Boolean)
  async unregisterDevice(@CurrentUserId() userId: string, @Args('token') token: string): Promise<boolean> {
    await this.ctx.db.deleteFrom('device_tokens').where('token', '=', token).where('user_id', '=', userId).execute();
    return true;
  }
}
