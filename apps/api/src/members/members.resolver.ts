import { Args, ID, Mutation, Query, Resolver } from '@nestjs/graphql';
import { Throttle } from '@nestjs/throttler';
import { UseGuards } from '@nestjs/common';
import { AuthPayload } from '../auth/auth.models.js';
import { client } from '../auth/auth.resolver.js';
import { GqlThrottlerGuard } from '../auth/gql-throttler.guard.js';
import { SessionResponder } from '../auth/session-responder.js';
import { CurrentTenant, CurrentUserId, GqlRequest, Public, RequirePermission } from '../common/decorators.js';
import type { GqlContext, TenantAccess } from '../common/request-context.js';
import { Permission } from '../permissions/permissions.js';
import { AcceptInvitationInput, Invitation, InvitationPreview, InviteMemberInput, Member } from './member.model.js';
import { MembersService } from './members.service.js';

@Resolver()
export class MembersResolver {
  constructor(
    private readonly members: MembersService,
    private readonly responder: SessionResponder,
  ) {}

  @Query(() => [Member], { name: 'members' })
  @RequirePermission(Permission.MemberView)
  listMembers(): Promise<Member[]> {
    return this.members.list();
  }

  @Mutation(() => Boolean)
  @RequirePermission(Permission.MemberManage)
  removeMembership(
    @CurrentTenant() access: TenantAccess,
    @Args('membershipId', { type: () => ID }) membershipId: string,
  ): Promise<boolean> {
    return this.members.remove(access, membershipId);
  }

  @Query(() => [Invitation], { description: 'Inviti in attesa' })
  @RequirePermission(Permission.MemberInvite)
  invitations(): Promise<Invitation[]> {
    return this.members.listInvitations();
  }

  @Mutation(() => Invitation)
  @RequirePermission(Permission.MemberInvite)
  inviteMember(
    @CurrentTenant() access: TenantAccess,
    @CurrentUserId() userId: string,
    @Args('input') input: InviteMemberInput,
  ): Promise<Invitation> {
    return this.members.invite(access, userId, input);
  }

  @Mutation(() => Boolean)
  @RequirePermission(Permission.MemberInvite)
  revokeInvitation(@Args('id', { type: () => ID }) id: string): Promise<boolean> {
    return this.members.revokeInvitation(id);
  }

  @Public()
  @Query(() => InvitationPreview)
  invitationPreview(@Args('token') token: string): Promise<InvitationPreview> {
    return this.members.preview(token);
  }

  @Public()
  @UseGuards(GqlThrottlerGuard)
  @Throttle({ default: { limit: 10, ttl: 60_000 } })
  @Mutation(() => AuthPayload)
  async acceptInvitation(
    @Args('input') input: AcceptInvitationInput,
    @GqlRequest() gql: GqlContext,
  ): Promise<AuthPayload> {
    return this.responder.deliver(await this.members.accept(input, client(gql)), gql);
  }
}
