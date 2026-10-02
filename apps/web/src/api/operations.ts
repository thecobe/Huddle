import { graphql } from '@/gql';

export const MeFields = graphql(`
  fragment MeFields on Me {
    id
    email
    fullName
    locale
    twoFactorEnabled
    memberships {
      id
      role
      teamId
      clubId
      clubName
    }
  }
`);

export const AuthFields = graphql(`
  fragment AuthFields on AuthPayload {
    status
    accessToken
    accessTokenExpiresAt
    challengeToken
    user {
      ...MeFields
    }
  }
`);

export const LoginDoc = graphql(`
  mutation Login($input: LoginInput!) {
    login(input: $input) {
      ...AuthFields
    }
  }
`);

export const RegisterDoc = graphql(`
  mutation Register($input: RegisterInput!) {
    register(input: $input) {
      ...AuthFields
    }
  }
`);

export const VerifyTwoFactorDoc = graphql(`
  mutation VerifyTwoFactor($challengeToken: String!, $code: String!) {
    verifyTwoFactor(challengeToken: $challengeToken, code: $code) {
      ...AuthFields
    }
  }
`);

export const RequestMagicLinkDoc = graphql(`
  mutation RequestMagicLink($email: String!) {
    requestMagicLink(email: $email)
  }
`);

export const ConsumeMagicLinkDoc = graphql(`
  mutation ConsumeMagicLink($token: String!) {
    consumeMagicLink(token: $token) {
      ...AuthFields
    }
  }
`);

export const RequestPasswordResetDoc = graphql(`
  mutation RequestPasswordReset($email: String!) {
    requestPasswordReset(email: $email)
  }
`);

export const ResetPasswordDoc = graphql(`
  mutation ResetPassword($token: String!, $newPassword: String!) {
    resetPassword(token: $token, newPassword: $newPassword)
  }
`);

export const ChangePasswordDoc = graphql(`
  mutation ChangePassword($currentPassword: String!, $newPassword: String!) {
    changePassword(currentPassword: $currentPassword, newPassword: $newPassword)
  }
`);

export const RefreshSessionDoc = graphql(`
  mutation RefreshSession {
    refreshSession {
      ...AuthFields
    }
  }
`);

export const LogoutDoc = graphql(`
  mutation Logout {
    logout
  }
`);

export const MeDoc = graphql(`
  query Me {
    me {
      ...MeFields
    }
  }
`);

export const UpdateMeDoc = graphql(`
  mutation UpdateMe($input: UpdateMeInput!) {
    updateMe(input: $input) {
      ...MeFields
    }
  }
`);

export const SetupTwoFactorDoc = graphql(`
  mutation SetupTwoFactor {
    setupTwoFactor {
      secret
      otpauthUri
    }
  }
`);

export const EnableTwoFactorDoc = graphql(`
  mutation EnableTwoFactor($code: String!) {
    enableTwoFactor(code: $code)
  }
`);

export const DisableTwoFactorDoc = graphql(`
  mutation DisableTwoFactor($code: String!) {
    disableTwoFactor(code: $code)
  }
`);

export const ClubFields = graphql(`
  fragment ClubFields on Club {
    id
    name
    legalName
    taxCode
    vatNumber
    sport
    email
    phone
    addressLine
    city
    province
    postalCode
    country
    federations
  }
`);

export const ClubDoc = graphql(`
  query Club {
    club {
      ...ClubFields
    }
  }
`);

export const CreateClubDoc = graphql(`
  mutation CreateClub($input: ClubInput!) {
    createClub(input: $input) {
      ...ClubFields
    }
  }
`);

export const UpdateClubDoc = graphql(`
  mutation UpdateClub($input: ClubInput!) {
    updateClub(input: $input) {
      ...ClubFields
    }
  }
`);

export const SeasonsDoc = graphql(`
  query Seasons {
    seasons {
      id
      name
      startsOn
      endsOn
      status
    }
  }
`);

export const CreateSeasonDoc = graphql(`
  mutation CreateSeason($input: SeasonInput!) {
    createSeason(input: $input) {
      id
    }
  }
`);

export const SetSeasonStatusDoc = graphql(`
  mutation SetSeasonStatus($id: ID!, $status: SeasonStatus!) {
    setSeasonStatus(id: $id, status: $status) {
      id
      status
    }
  }
`);

export const MembersDoc = graphql(`
  query Members {
    members {
      membershipId
      userId
      fullName
      email
      role
      teamId
      createdAt
    }
    invitations {
      id
      email
      role
      expiresAt
      createdAt
    }
  }
`);

export const InviteMemberDoc = graphql(`
  mutation InviteMember($input: InviteMemberInput!) {
    inviteMember(input: $input) {
      id
    }
  }
`);

export const RevokeInvitationDoc = graphql(`
  mutation RevokeInvitation($id: ID!) {
    revokeInvitation(id: $id)
  }
`);

export const RemoveMembershipDoc = graphql(`
  mutation RemoveMembership($membershipId: ID!) {
    removeMembership(membershipId: $membershipId)
  }
`);

export const InvitationPreviewDoc = graphql(`
  query InvitationPreview($token: String!) {
    invitationPreview(token: $token) {
      clubId
      clubName
      email
      role
      expiresAt
      accountExists
    }
  }
`);

export const AcceptInvitationDoc = graphql(`
  mutation AcceptInvitation($input: AcceptInvitationInput!) {
    acceptInvitation(input: $input) {
      ...AuthFields
    }
  }
`);

export const AuditEventsDoc = graphql(`
  query AuditEvents($beforeId: String) {
    auditEvents(limit: 50, beforeId: $beforeId) {
      id
      action
      actorName
      entityType
      entityId
      metadata
      createdAt
    }
  }
`);

export const MyConsentsDoc = graphql(`
  query MyConsents {
    myConsents {
      kind
      clubId
      version
      granted
      recordedAt
    }
  }
`);

export const RecordConsentDoc = graphql(`
  mutation RecordConsent($kind: ConsentKind!, $granted: Boolean!) {
    recordConsent(kind: $kind, granted: $granted) {
      kind
      granted
    }
  }
`);

export const MyDataExportDoc = graphql(`
  query MyDataExport {
    myDataExport
  }
`);
