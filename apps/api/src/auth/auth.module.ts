import { Global, Module } from '@nestjs/common';
import { AccessGuard } from './access.guard.js';
import { AuthResolver } from './auth.resolver.js';
import { AuthService } from './auth.service.js';
import { PasswordService } from './password.service.js';
import { SessionResponder } from './session-responder.js';
import { TokenService } from './token.service.js';
import { TotpService } from './totp.service.js';

@Global()
@Module({
  providers: [AuthService, AuthResolver, PasswordService, TokenService, TotpService, AccessGuard, SessionResponder],
  exports: [AuthService, TokenService, PasswordService, AccessGuard, SessionResponder],
})
export class AuthModule {}
