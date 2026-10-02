/* eslint-disable */
import * as types from './graphql';
import type { TypedDocumentNode as DocumentNode } from '@graphql-typed-document-node/core';

/**
 * Map of all GraphQL operations in the project.
 *
 * This map has several performance disadvantages:
 * 1. It is not tree-shakeable, so it will include all operations in the project.
 * 2. It is not minifiable, so the string of a GraphQL query will be multiple times inside the bundle.
 * 3. It does not support dead code elimination, so it will add unused operations.
 *
 * Therefore it is highly recommended to use the babel or swc plugin for production.
 * Learn more about it here: https://the-guild.dev/graphql/codegen/plugins/presets/preset-client#reducing-bundle-size
 */
type Documents = {
    "\n  fragment MeFields on Me {\n    id\n    email\n    fullName\n    locale\n    twoFactorEnabled\n    memberships {\n      id\n      role\n      teamId\n      clubId\n      clubName\n    }\n  }\n": typeof types.MeFieldsFragmentDoc,
    "\n  fragment AuthFields on AuthPayload {\n    status\n    accessToken\n    accessTokenExpiresAt\n    challengeToken\n    user {\n      ...MeFields\n    }\n  }\n": typeof types.AuthFieldsFragmentDoc,
    "\n  mutation Login($input: LoginInput!) {\n    login(input: $input) {\n      ...AuthFields\n    }\n  }\n": typeof types.LoginDocument,
    "\n  mutation Register($input: RegisterInput!) {\n    register(input: $input) {\n      ...AuthFields\n    }\n  }\n": typeof types.RegisterDocument,
    "\n  mutation VerifyTwoFactor($challengeToken: String!, $code: String!) {\n    verifyTwoFactor(challengeToken: $challengeToken, code: $code) {\n      ...AuthFields\n    }\n  }\n": typeof types.VerifyTwoFactorDocument,
    "\n  mutation RequestMagicLink($email: String!) {\n    requestMagicLink(email: $email)\n  }\n": typeof types.RequestMagicLinkDocument,
    "\n  mutation ConsumeMagicLink($token: String!) {\n    consumeMagicLink(token: $token) {\n      ...AuthFields\n    }\n  }\n": typeof types.ConsumeMagicLinkDocument,
    "\n  mutation RequestPasswordReset($email: String!) {\n    requestPasswordReset(email: $email)\n  }\n": typeof types.RequestPasswordResetDocument,
    "\n  mutation ResetPassword($token: String!, $newPassword: String!) {\n    resetPassword(token: $token, newPassword: $newPassword)\n  }\n": typeof types.ResetPasswordDocument,
    "\n  mutation ChangePassword($currentPassword: String!, $newPassword: String!) {\n    changePassword(currentPassword: $currentPassword, newPassword: $newPassword)\n  }\n": typeof types.ChangePasswordDocument,
    "\n  mutation RefreshSession {\n    refreshSession {\n      ...AuthFields\n    }\n  }\n": typeof types.RefreshSessionDocument,
    "\n  mutation Logout {\n    logout\n  }\n": typeof types.LogoutDocument,
    "\n  query Me {\n    me {\n      ...MeFields\n    }\n  }\n": typeof types.MeDocument,
    "\n  mutation UpdateMe($input: UpdateMeInput!) {\n    updateMe(input: $input) {\n      ...MeFields\n    }\n  }\n": typeof types.UpdateMeDocument,
    "\n  mutation SetupTwoFactor {\n    setupTwoFactor {\n      secret\n      otpauthUri\n    }\n  }\n": typeof types.SetupTwoFactorDocument,
    "\n  mutation EnableTwoFactor($code: String!) {\n    enableTwoFactor(code: $code)\n  }\n": typeof types.EnableTwoFactorDocument,
    "\n  mutation DisableTwoFactor($code: String!) {\n    disableTwoFactor(code: $code)\n  }\n": typeof types.DisableTwoFactorDocument,
    "\n  fragment ClubFields on Club {\n    id\n    name\n    legalName\n    taxCode\n    vatNumber\n    sport\n    email\n    phone\n    addressLine\n    city\n    province\n    postalCode\n    country\n    federations\n  }\n": typeof types.ClubFieldsFragmentDoc,
    "\n  query Club {\n    club {\n      ...ClubFields\n    }\n  }\n": typeof types.ClubDocument,
    "\n  mutation CreateClub($input: ClubInput!) {\n    createClub(input: $input) {\n      ...ClubFields\n    }\n  }\n": typeof types.CreateClubDocument,
    "\n  mutation UpdateClub($input: ClubInput!) {\n    updateClub(input: $input) {\n      ...ClubFields\n    }\n  }\n": typeof types.UpdateClubDocument,
    "\n  query Seasons {\n    seasons {\n      id\n      name\n      startsOn\n      endsOn\n      status\n    }\n  }\n": typeof types.SeasonsDocument,
    "\n  mutation CreateSeason($input: SeasonInput!) {\n    createSeason(input: $input) {\n      id\n    }\n  }\n": typeof types.CreateSeasonDocument,
    "\n  mutation SetSeasonStatus($id: ID!, $status: SeasonStatus!) {\n    setSeasonStatus(id: $id, status: $status) {\n      id\n      status\n    }\n  }\n": typeof types.SetSeasonStatusDocument,
    "\n  query Members {\n    members {\n      membershipId\n      userId\n      fullName\n      email\n      role\n      teamId\n      createdAt\n    }\n    invitations {\n      id\n      email\n      role\n      expiresAt\n      createdAt\n    }\n  }\n": typeof types.MembersDocument,
    "\n  mutation InviteMember($input: InviteMemberInput!) {\n    inviteMember(input: $input) {\n      id\n    }\n  }\n": typeof types.InviteMemberDocument,
    "\n  mutation RevokeInvitation($id: ID!) {\n    revokeInvitation(id: $id)\n  }\n": typeof types.RevokeInvitationDocument,
    "\n  mutation RemoveMembership($membershipId: ID!) {\n    removeMembership(membershipId: $membershipId)\n  }\n": typeof types.RemoveMembershipDocument,
    "\n  query InvitationPreview($token: String!) {\n    invitationPreview(token: $token) {\n      clubId\n      clubName\n      email\n      role\n      expiresAt\n      accountExists\n    }\n  }\n": typeof types.InvitationPreviewDocument,
    "\n  mutation AcceptInvitation($input: AcceptInvitationInput!) {\n    acceptInvitation(input: $input) {\n      ...AuthFields\n    }\n  }\n": typeof types.AcceptInvitationDocument,
    "\n  query AuditEvents($beforeId: String) {\n    auditEvents(limit: 50, beforeId: $beforeId) {\n      id\n      action\n      actorName\n      entityType\n      entityId\n      metadata\n      createdAt\n    }\n  }\n": typeof types.AuditEventsDocument,
    "\n  query MyConsents {\n    myConsents {\n      kind\n      clubId\n      version\n      granted\n      recordedAt\n    }\n  }\n": typeof types.MyConsentsDocument,
    "\n  mutation RecordConsent($kind: ConsentKind!, $granted: Boolean!) {\n    recordConsent(kind: $kind, granted: $granted) {\n      kind\n      granted\n    }\n  }\n": typeof types.RecordConsentDocument,
    "\n  query MyDataExport {\n    myDataExport\n  }\n": typeof types.MyDataExportDocument,
};
const documents: Documents = {
    "\n  fragment MeFields on Me {\n    id\n    email\n    fullName\n    locale\n    twoFactorEnabled\n    memberships {\n      id\n      role\n      teamId\n      clubId\n      clubName\n    }\n  }\n": types.MeFieldsFragmentDoc,
    "\n  fragment AuthFields on AuthPayload {\n    status\n    accessToken\n    accessTokenExpiresAt\n    challengeToken\n    user {\n      ...MeFields\n    }\n  }\n": types.AuthFieldsFragmentDoc,
    "\n  mutation Login($input: LoginInput!) {\n    login(input: $input) {\n      ...AuthFields\n    }\n  }\n": types.LoginDocument,
    "\n  mutation Register($input: RegisterInput!) {\n    register(input: $input) {\n      ...AuthFields\n    }\n  }\n": types.RegisterDocument,
    "\n  mutation VerifyTwoFactor($challengeToken: String!, $code: String!) {\n    verifyTwoFactor(challengeToken: $challengeToken, code: $code) {\n      ...AuthFields\n    }\n  }\n": types.VerifyTwoFactorDocument,
    "\n  mutation RequestMagicLink($email: String!) {\n    requestMagicLink(email: $email)\n  }\n": types.RequestMagicLinkDocument,
    "\n  mutation ConsumeMagicLink($token: String!) {\n    consumeMagicLink(token: $token) {\n      ...AuthFields\n    }\n  }\n": types.ConsumeMagicLinkDocument,
    "\n  mutation RequestPasswordReset($email: String!) {\n    requestPasswordReset(email: $email)\n  }\n": types.RequestPasswordResetDocument,
    "\n  mutation ResetPassword($token: String!, $newPassword: String!) {\n    resetPassword(token: $token, newPassword: $newPassword)\n  }\n": types.ResetPasswordDocument,
    "\n  mutation ChangePassword($currentPassword: String!, $newPassword: String!) {\n    changePassword(currentPassword: $currentPassword, newPassword: $newPassword)\n  }\n": types.ChangePasswordDocument,
    "\n  mutation RefreshSession {\n    refreshSession {\n      ...AuthFields\n    }\n  }\n": types.RefreshSessionDocument,
    "\n  mutation Logout {\n    logout\n  }\n": types.LogoutDocument,
    "\n  query Me {\n    me {\n      ...MeFields\n    }\n  }\n": types.MeDocument,
    "\n  mutation UpdateMe($input: UpdateMeInput!) {\n    updateMe(input: $input) {\n      ...MeFields\n    }\n  }\n": types.UpdateMeDocument,
    "\n  mutation SetupTwoFactor {\n    setupTwoFactor {\n      secret\n      otpauthUri\n    }\n  }\n": types.SetupTwoFactorDocument,
    "\n  mutation EnableTwoFactor($code: String!) {\n    enableTwoFactor(code: $code)\n  }\n": types.EnableTwoFactorDocument,
    "\n  mutation DisableTwoFactor($code: String!) {\n    disableTwoFactor(code: $code)\n  }\n": types.DisableTwoFactorDocument,
    "\n  fragment ClubFields on Club {\n    id\n    name\n    legalName\n    taxCode\n    vatNumber\n    sport\n    email\n    phone\n    addressLine\n    city\n    province\n    postalCode\n    country\n    federations\n  }\n": types.ClubFieldsFragmentDoc,
    "\n  query Club {\n    club {\n      ...ClubFields\n    }\n  }\n": types.ClubDocument,
    "\n  mutation CreateClub($input: ClubInput!) {\n    createClub(input: $input) {\n      ...ClubFields\n    }\n  }\n": types.CreateClubDocument,
    "\n  mutation UpdateClub($input: ClubInput!) {\n    updateClub(input: $input) {\n      ...ClubFields\n    }\n  }\n": types.UpdateClubDocument,
    "\n  query Seasons {\n    seasons {\n      id\n      name\n      startsOn\n      endsOn\n      status\n    }\n  }\n": types.SeasonsDocument,
    "\n  mutation CreateSeason($input: SeasonInput!) {\n    createSeason(input: $input) {\n      id\n    }\n  }\n": types.CreateSeasonDocument,
    "\n  mutation SetSeasonStatus($id: ID!, $status: SeasonStatus!) {\n    setSeasonStatus(id: $id, status: $status) {\n      id\n      status\n    }\n  }\n": types.SetSeasonStatusDocument,
    "\n  query Members {\n    members {\n      membershipId\n      userId\n      fullName\n      email\n      role\n      teamId\n      createdAt\n    }\n    invitations {\n      id\n      email\n      role\n      expiresAt\n      createdAt\n    }\n  }\n": types.MembersDocument,
    "\n  mutation InviteMember($input: InviteMemberInput!) {\n    inviteMember(input: $input) {\n      id\n    }\n  }\n": types.InviteMemberDocument,
    "\n  mutation RevokeInvitation($id: ID!) {\n    revokeInvitation(id: $id)\n  }\n": types.RevokeInvitationDocument,
    "\n  mutation RemoveMembership($membershipId: ID!) {\n    removeMembership(membershipId: $membershipId)\n  }\n": types.RemoveMembershipDocument,
    "\n  query InvitationPreview($token: String!) {\n    invitationPreview(token: $token) {\n      clubId\n      clubName\n      email\n      role\n      expiresAt\n      accountExists\n    }\n  }\n": types.InvitationPreviewDocument,
    "\n  mutation AcceptInvitation($input: AcceptInvitationInput!) {\n    acceptInvitation(input: $input) {\n      ...AuthFields\n    }\n  }\n": types.AcceptInvitationDocument,
    "\n  query AuditEvents($beforeId: String) {\n    auditEvents(limit: 50, beforeId: $beforeId) {\n      id\n      action\n      actorName\n      entityType\n      entityId\n      metadata\n      createdAt\n    }\n  }\n": types.AuditEventsDocument,
    "\n  query MyConsents {\n    myConsents {\n      kind\n      clubId\n      version\n      granted\n      recordedAt\n    }\n  }\n": types.MyConsentsDocument,
    "\n  mutation RecordConsent($kind: ConsentKind!, $granted: Boolean!) {\n    recordConsent(kind: $kind, granted: $granted) {\n      kind\n      granted\n    }\n  }\n": types.RecordConsentDocument,
    "\n  query MyDataExport {\n    myDataExport\n  }\n": types.MyDataExportDocument,
};

/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 *
 *
 * @example
 * ```ts
 * const query = graphql(`query GetUser($id: ID!) { user(id: $id) { name } }`);
 * ```
 *
 * The query argument is unknown!
 * Please regenerate the types.
 */
export function graphql(source: string): unknown;

/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  fragment MeFields on Me {\n    id\n    email\n    fullName\n    locale\n    twoFactorEnabled\n    memberships {\n      id\n      role\n      teamId\n      clubId\n      clubName\n    }\n  }\n"): (typeof documents)["\n  fragment MeFields on Me {\n    id\n    email\n    fullName\n    locale\n    twoFactorEnabled\n    memberships {\n      id\n      role\n      teamId\n      clubId\n      clubName\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  fragment AuthFields on AuthPayload {\n    status\n    accessToken\n    accessTokenExpiresAt\n    challengeToken\n    user {\n      ...MeFields\n    }\n  }\n"): (typeof documents)["\n  fragment AuthFields on AuthPayload {\n    status\n    accessToken\n    accessTokenExpiresAt\n    challengeToken\n    user {\n      ...MeFields\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation Login($input: LoginInput!) {\n    login(input: $input) {\n      ...AuthFields\n    }\n  }\n"): (typeof documents)["\n  mutation Login($input: LoginInput!) {\n    login(input: $input) {\n      ...AuthFields\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation Register($input: RegisterInput!) {\n    register(input: $input) {\n      ...AuthFields\n    }\n  }\n"): (typeof documents)["\n  mutation Register($input: RegisterInput!) {\n    register(input: $input) {\n      ...AuthFields\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation VerifyTwoFactor($challengeToken: String!, $code: String!) {\n    verifyTwoFactor(challengeToken: $challengeToken, code: $code) {\n      ...AuthFields\n    }\n  }\n"): (typeof documents)["\n  mutation VerifyTwoFactor($challengeToken: String!, $code: String!) {\n    verifyTwoFactor(challengeToken: $challengeToken, code: $code) {\n      ...AuthFields\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation RequestMagicLink($email: String!) {\n    requestMagicLink(email: $email)\n  }\n"): (typeof documents)["\n  mutation RequestMagicLink($email: String!) {\n    requestMagicLink(email: $email)\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation ConsumeMagicLink($token: String!) {\n    consumeMagicLink(token: $token) {\n      ...AuthFields\n    }\n  }\n"): (typeof documents)["\n  mutation ConsumeMagicLink($token: String!) {\n    consumeMagicLink(token: $token) {\n      ...AuthFields\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation RequestPasswordReset($email: String!) {\n    requestPasswordReset(email: $email)\n  }\n"): (typeof documents)["\n  mutation RequestPasswordReset($email: String!) {\n    requestPasswordReset(email: $email)\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation ResetPassword($token: String!, $newPassword: String!) {\n    resetPassword(token: $token, newPassword: $newPassword)\n  }\n"): (typeof documents)["\n  mutation ResetPassword($token: String!, $newPassword: String!) {\n    resetPassword(token: $token, newPassword: $newPassword)\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation ChangePassword($currentPassword: String!, $newPassword: String!) {\n    changePassword(currentPassword: $currentPassword, newPassword: $newPassword)\n  }\n"): (typeof documents)["\n  mutation ChangePassword($currentPassword: String!, $newPassword: String!) {\n    changePassword(currentPassword: $currentPassword, newPassword: $newPassword)\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation RefreshSession {\n    refreshSession {\n      ...AuthFields\n    }\n  }\n"): (typeof documents)["\n  mutation RefreshSession {\n    refreshSession {\n      ...AuthFields\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation Logout {\n    logout\n  }\n"): (typeof documents)["\n  mutation Logout {\n    logout\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  query Me {\n    me {\n      ...MeFields\n    }\n  }\n"): (typeof documents)["\n  query Me {\n    me {\n      ...MeFields\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation UpdateMe($input: UpdateMeInput!) {\n    updateMe(input: $input) {\n      ...MeFields\n    }\n  }\n"): (typeof documents)["\n  mutation UpdateMe($input: UpdateMeInput!) {\n    updateMe(input: $input) {\n      ...MeFields\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation SetupTwoFactor {\n    setupTwoFactor {\n      secret\n      otpauthUri\n    }\n  }\n"): (typeof documents)["\n  mutation SetupTwoFactor {\n    setupTwoFactor {\n      secret\n      otpauthUri\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation EnableTwoFactor($code: String!) {\n    enableTwoFactor(code: $code)\n  }\n"): (typeof documents)["\n  mutation EnableTwoFactor($code: String!) {\n    enableTwoFactor(code: $code)\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation DisableTwoFactor($code: String!) {\n    disableTwoFactor(code: $code)\n  }\n"): (typeof documents)["\n  mutation DisableTwoFactor($code: String!) {\n    disableTwoFactor(code: $code)\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  fragment ClubFields on Club {\n    id\n    name\n    legalName\n    taxCode\n    vatNumber\n    sport\n    email\n    phone\n    addressLine\n    city\n    province\n    postalCode\n    country\n    federations\n  }\n"): (typeof documents)["\n  fragment ClubFields on Club {\n    id\n    name\n    legalName\n    taxCode\n    vatNumber\n    sport\n    email\n    phone\n    addressLine\n    city\n    province\n    postalCode\n    country\n    federations\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  query Club {\n    club {\n      ...ClubFields\n    }\n  }\n"): (typeof documents)["\n  query Club {\n    club {\n      ...ClubFields\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation CreateClub($input: ClubInput!) {\n    createClub(input: $input) {\n      ...ClubFields\n    }\n  }\n"): (typeof documents)["\n  mutation CreateClub($input: ClubInput!) {\n    createClub(input: $input) {\n      ...ClubFields\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation UpdateClub($input: ClubInput!) {\n    updateClub(input: $input) {\n      ...ClubFields\n    }\n  }\n"): (typeof documents)["\n  mutation UpdateClub($input: ClubInput!) {\n    updateClub(input: $input) {\n      ...ClubFields\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  query Seasons {\n    seasons {\n      id\n      name\n      startsOn\n      endsOn\n      status\n    }\n  }\n"): (typeof documents)["\n  query Seasons {\n    seasons {\n      id\n      name\n      startsOn\n      endsOn\n      status\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation CreateSeason($input: SeasonInput!) {\n    createSeason(input: $input) {\n      id\n    }\n  }\n"): (typeof documents)["\n  mutation CreateSeason($input: SeasonInput!) {\n    createSeason(input: $input) {\n      id\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation SetSeasonStatus($id: ID!, $status: SeasonStatus!) {\n    setSeasonStatus(id: $id, status: $status) {\n      id\n      status\n    }\n  }\n"): (typeof documents)["\n  mutation SetSeasonStatus($id: ID!, $status: SeasonStatus!) {\n    setSeasonStatus(id: $id, status: $status) {\n      id\n      status\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  query Members {\n    members {\n      membershipId\n      userId\n      fullName\n      email\n      role\n      teamId\n      createdAt\n    }\n    invitations {\n      id\n      email\n      role\n      expiresAt\n      createdAt\n    }\n  }\n"): (typeof documents)["\n  query Members {\n    members {\n      membershipId\n      userId\n      fullName\n      email\n      role\n      teamId\n      createdAt\n    }\n    invitations {\n      id\n      email\n      role\n      expiresAt\n      createdAt\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation InviteMember($input: InviteMemberInput!) {\n    inviteMember(input: $input) {\n      id\n    }\n  }\n"): (typeof documents)["\n  mutation InviteMember($input: InviteMemberInput!) {\n    inviteMember(input: $input) {\n      id\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation RevokeInvitation($id: ID!) {\n    revokeInvitation(id: $id)\n  }\n"): (typeof documents)["\n  mutation RevokeInvitation($id: ID!) {\n    revokeInvitation(id: $id)\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation RemoveMembership($membershipId: ID!) {\n    removeMembership(membershipId: $membershipId)\n  }\n"): (typeof documents)["\n  mutation RemoveMembership($membershipId: ID!) {\n    removeMembership(membershipId: $membershipId)\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  query InvitationPreview($token: String!) {\n    invitationPreview(token: $token) {\n      clubId\n      clubName\n      email\n      role\n      expiresAt\n      accountExists\n    }\n  }\n"): (typeof documents)["\n  query InvitationPreview($token: String!) {\n    invitationPreview(token: $token) {\n      clubId\n      clubName\n      email\n      role\n      expiresAt\n      accountExists\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation AcceptInvitation($input: AcceptInvitationInput!) {\n    acceptInvitation(input: $input) {\n      ...AuthFields\n    }\n  }\n"): (typeof documents)["\n  mutation AcceptInvitation($input: AcceptInvitationInput!) {\n    acceptInvitation(input: $input) {\n      ...AuthFields\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  query AuditEvents($beforeId: String) {\n    auditEvents(limit: 50, beforeId: $beforeId) {\n      id\n      action\n      actorName\n      entityType\n      entityId\n      metadata\n      createdAt\n    }\n  }\n"): (typeof documents)["\n  query AuditEvents($beforeId: String) {\n    auditEvents(limit: 50, beforeId: $beforeId) {\n      id\n      action\n      actorName\n      entityType\n      entityId\n      metadata\n      createdAt\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  query MyConsents {\n    myConsents {\n      kind\n      clubId\n      version\n      granted\n      recordedAt\n    }\n  }\n"): (typeof documents)["\n  query MyConsents {\n    myConsents {\n      kind\n      clubId\n      version\n      granted\n      recordedAt\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation RecordConsent($kind: ConsentKind!, $granted: Boolean!) {\n    recordConsent(kind: $kind, granted: $granted) {\n      kind\n      granted\n    }\n  }\n"): (typeof documents)["\n  mutation RecordConsent($kind: ConsentKind!, $granted: Boolean!) {\n    recordConsent(kind: $kind, granted: $granted) {\n      kind\n      granted\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  query MyDataExport {\n    myDataExport\n  }\n"): (typeof documents)["\n  query MyDataExport {\n    myDataExport\n  }\n"];

export function graphql(source: string) {
  return (documents as any)[source] ?? {};
}

export type DocumentType<TDocumentNode extends DocumentNode<any, any>> = TDocumentNode extends DocumentNode<  infer TType,  any>  ? TType  : never;