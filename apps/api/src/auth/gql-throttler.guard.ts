import { type ExecutionContext, Injectable } from '@nestjs/common';
import { ThrottlerGuard } from '@nestjs/throttler';
import { gqlContext } from '../common/decorators.js';

@Injectable()
export class GqlThrottlerGuard extends ThrottlerGuard {
  protected override getRequestResponse(context: ExecutionContext) {
    const { req, res } = gqlContext(context);
    return { req, res };
  }
}
