/* eslint-disable */
/** Internal type. DO NOT USE DIRECTLY. */
type Exact<T extends { [key: string]: unknown }> = { [K in keyof T]: T[K] };
/** Internal type. DO NOT USE DIRECTLY. */
export type Incremental<T> = T | { [P in keyof T]?: P extends ' $fragmentName' | '__typename' ? T[P] : never };
import type { TypedDocumentNode as DocumentNode } from '@graphql-typed-document-node/core';
export type AcceptInvitationInput = {
  acceptTerms: boolean;
  /** Obbligatorio se non esiste ancora un account */
  fullName?: string | null | undefined;
  /** Facoltativa: le famiglie possono accedere solo con magic link */
  password?: string | null | undefined;
  token: string;
};

export type AuthStatus =
  | 'AUTHENTICATED'
  | 'TWO_FACTOR_REQUIRED';

export type ClubInput = {
  addressLine?: string | null | undefined;
  city?: string | null | undefined;
  email?: string | null | undefined;
  federations?: Array<string> | null | undefined;
  legalName?: string | null | undefined;
  name: string;
  phone?: string | null | undefined;
  postalCode?: string | null | undefined;
  province?: string | null | undefined;
  sport?: string | null | undefined;
  taxCode?: string | null | undefined;
  vatNumber?: string | null | undefined;
};

export type ConsentKind =
  | 'IMAGE_RELEASE'
  | 'MARKETING'
  | 'PRIVACY_POLICY'
  | 'TERMS_OF_SERVICE';

export type InviteMemberInput = {
  email: string;
  role: MembershipRole;
  teamId?: string | number | null | undefined;
};

export type LoginInput = {
  email: string;
  password: string;
};

export type MembershipRole =
  | 'ADMIN'
  | 'ATHLETE'
  | 'COACH'
  | 'PARENT'
  | 'SECRETARY'
  | 'SPORTS_DIRECTOR'
  | 'TEAM_MANAGER';

export type RegisterInput = {
  /** Accettazione di informativa privacy e termini di servizio */
  acceptTerms: boolean;
  email: string;
  fullName: string;
  locale?: string | null | undefined;
  password: string;
};

export type SeasonInput = {
  endsOn: string;
  name: string;
  startsOn: string;
};

export type SeasonStatus =
  | 'CLOSED'
  | 'OPEN'
  | 'PLANNED';

export type UpdateMeInput = {
  fullName?: string | null | undefined;
  locale?: string | null | undefined;
};

export type MeFieldsFragment = { id: string, email: string, fullName: string, locale: string, twoFactorEnabled: boolean, memberships: Array<{ id: string, role: MembershipRole, teamId: string | null, clubId: string, clubName: string }> };

export type AuthFieldsFragment = { status: AuthStatus, accessToken: string | null, accessTokenExpiresAt: string | null, challengeToken: string | null, user: { id: string, email: string, fullName: string, locale: string, twoFactorEnabled: boolean, memberships: Array<{ id: string, role: MembershipRole, teamId: string | null, clubId: string, clubName: string }> } | null };

export type LoginMutationVariables = Exact<{
  input: LoginInput;
}>;


export type LoginMutation = { login: { status: AuthStatus, accessToken: string | null, accessTokenExpiresAt: string | null, challengeToken: string | null, user: { id: string, email: string, fullName: string, locale: string, twoFactorEnabled: boolean, memberships: Array<{ id: string, role: MembershipRole, teamId: string | null, clubId: string, clubName: string }> } | null } };

export type RegisterMutationVariables = Exact<{
  input: RegisterInput;
}>;


export type RegisterMutation = { register: { status: AuthStatus, accessToken: string | null, accessTokenExpiresAt: string | null, challengeToken: string | null, user: { id: string, email: string, fullName: string, locale: string, twoFactorEnabled: boolean, memberships: Array<{ id: string, role: MembershipRole, teamId: string | null, clubId: string, clubName: string }> } | null } };

export type VerifyTwoFactorMutationVariables = Exact<{
  challengeToken: string;
  code: string;
}>;


export type VerifyTwoFactorMutation = { verifyTwoFactor: { status: AuthStatus, accessToken: string | null, accessTokenExpiresAt: string | null, challengeToken: string | null, user: { id: string, email: string, fullName: string, locale: string, twoFactorEnabled: boolean, memberships: Array<{ id: string, role: MembershipRole, teamId: string | null, clubId: string, clubName: string }> } | null } };

export type RequestMagicLinkMutationVariables = Exact<{
  email: string;
}>;


export type RequestMagicLinkMutation = { requestMagicLink: boolean };

export type ConsumeMagicLinkMutationVariables = Exact<{
  token: string;
}>;


export type ConsumeMagicLinkMutation = { consumeMagicLink: { status: AuthStatus, accessToken: string | null, accessTokenExpiresAt: string | null, challengeToken: string | null, user: { id: string, email: string, fullName: string, locale: string, twoFactorEnabled: boolean, memberships: Array<{ id: string, role: MembershipRole, teamId: string | null, clubId: string, clubName: string }> } | null } };

export type RequestPasswordResetMutationVariables = Exact<{
  email: string;
}>;


export type RequestPasswordResetMutation = { requestPasswordReset: boolean };

export type ResetPasswordMutationVariables = Exact<{
  token: string;
  newPassword: string;
}>;


export type ResetPasswordMutation = { resetPassword: boolean };

export type ChangePasswordMutationVariables = Exact<{
  currentPassword: string;
  newPassword: string;
}>;


export type ChangePasswordMutation = { changePassword: boolean };

export type RefreshSessionMutationVariables = Exact<{ [key: string]: never; }>;


export type RefreshSessionMutation = { refreshSession: { status: AuthStatus, accessToken: string | null, accessTokenExpiresAt: string | null, challengeToken: string | null, user: { id: string, email: string, fullName: string, locale: string, twoFactorEnabled: boolean, memberships: Array<{ id: string, role: MembershipRole, teamId: string | null, clubId: string, clubName: string }> } | null } };

export type LogoutMutationVariables = Exact<{ [key: string]: never; }>;


export type LogoutMutation = { logout: boolean };

export type MeQueryVariables = Exact<{ [key: string]: never; }>;


export type MeQuery = { me: { id: string, email: string, fullName: string, locale: string, twoFactorEnabled: boolean, memberships: Array<{ id: string, role: MembershipRole, teamId: string | null, clubId: string, clubName: string }> } };

export type UpdateMeMutationVariables = Exact<{
  input: UpdateMeInput;
}>;


export type UpdateMeMutation = { updateMe: { id: string, email: string, fullName: string, locale: string, twoFactorEnabled: boolean, memberships: Array<{ id: string, role: MembershipRole, teamId: string | null, clubId: string, clubName: string }> } };

export type SetupTwoFactorMutationVariables = Exact<{ [key: string]: never; }>;


export type SetupTwoFactorMutation = { setupTwoFactor: { secret: string, otpauthUri: string } };

export type EnableTwoFactorMutationVariables = Exact<{
  code: string;
}>;


export type EnableTwoFactorMutation = { enableTwoFactor: Array<string> };

export type DisableTwoFactorMutationVariables = Exact<{
  code: string;
}>;


export type DisableTwoFactorMutation = { disableTwoFactor: boolean };

export type ClubFieldsFragment = { id: string, name: string, legalName: string | null, taxCode: string | null, vatNumber: string | null, sport: string, email: string | null, phone: string | null, addressLine: string | null, city: string | null, province: string | null, postalCode: string | null, country: string, federations: Array<string> };

export type ClubQueryVariables = Exact<{ [key: string]: never; }>;


export type ClubQuery = { club: { id: string, name: string, legalName: string | null, taxCode: string | null, vatNumber: string | null, sport: string, email: string | null, phone: string | null, addressLine: string | null, city: string | null, province: string | null, postalCode: string | null, country: string, federations: Array<string> } };

export type CreateClubMutationVariables = Exact<{
  input: ClubInput;
}>;


export type CreateClubMutation = { createClub: { id: string, name: string, legalName: string | null, taxCode: string | null, vatNumber: string | null, sport: string, email: string | null, phone: string | null, addressLine: string | null, city: string | null, province: string | null, postalCode: string | null, country: string, federations: Array<string> } };

export type UpdateClubMutationVariables = Exact<{
  input: ClubInput;
}>;


export type UpdateClubMutation = { updateClub: { id: string, name: string, legalName: string | null, taxCode: string | null, vatNumber: string | null, sport: string, email: string | null, phone: string | null, addressLine: string | null, city: string | null, province: string | null, postalCode: string | null, country: string, federations: Array<string> } };

export type SeasonsQueryVariables = Exact<{ [key: string]: never; }>;


export type SeasonsQuery = { seasons: Array<{ id: string, name: string, startsOn: string, endsOn: string, status: SeasonStatus }> };

export type CreateSeasonMutationVariables = Exact<{
  input: SeasonInput;
}>;


export type CreateSeasonMutation = { createSeason: { id: string } };

export type SetSeasonStatusMutationVariables = Exact<{
  id: string | number;
  status: SeasonStatus;
}>;


export type SetSeasonStatusMutation = { setSeasonStatus: { id: string, status: SeasonStatus } };

export type MembersQueryVariables = Exact<{ [key: string]: never; }>;


export type MembersQuery = { members: Array<{ membershipId: string, userId: string, fullName: string, email: string, role: MembershipRole, teamId: string | null, createdAt: string }>, invitations: Array<{ id: string, email: string, role: MembershipRole, expiresAt: string, createdAt: string }> };

export type InviteMemberMutationVariables = Exact<{
  input: InviteMemberInput;
}>;


export type InviteMemberMutation = { inviteMember: { id: string } };

export type RevokeInvitationMutationVariables = Exact<{
  id: string | number;
}>;


export type RevokeInvitationMutation = { revokeInvitation: boolean };

export type RemoveMembershipMutationVariables = Exact<{
  membershipId: string | number;
}>;


export type RemoveMembershipMutation = { removeMembership: boolean };

export type InvitationPreviewQueryVariables = Exact<{
  token: string;
}>;


export type InvitationPreviewQuery = { invitationPreview: { clubId: string, clubName: string, email: string, role: MembershipRole, expiresAt: string, accountExists: boolean } };

export type AcceptInvitationMutationVariables = Exact<{
  input: AcceptInvitationInput;
}>;


export type AcceptInvitationMutation = { acceptInvitation: { status: AuthStatus, accessToken: string | null, accessTokenExpiresAt: string | null, challengeToken: string | null, user: { id: string, email: string, fullName: string, locale: string, twoFactorEnabled: boolean, memberships: Array<{ id: string, role: MembershipRole, teamId: string | null, clubId: string, clubName: string }> } | null } };

export type AuditEventsQueryVariables = Exact<{
  beforeId?: string | null | undefined;
}>;


export type AuditEventsQuery = { auditEvents: Array<{ id: string, action: string, actorName: string | null, entityType: string | null, entityId: string | null, metadata: unknown, createdAt: string }> };

export type MyConsentsQueryVariables = Exact<{ [key: string]: never; }>;


export type MyConsentsQuery = { myConsents: Array<{ kind: ConsentKind, clubId: string | null, version: string, granted: boolean, recordedAt: string }> };

export type RecordConsentMutationVariables = Exact<{
  kind: ConsentKind;
  granted: boolean;
}>;


export type RecordConsentMutation = { recordConsent: { kind: ConsentKind, granted: boolean } };

export type MyDataExportQueryVariables = Exact<{ [key: string]: never; }>;


export type MyDataExportQuery = { myDataExport: unknown };

export const MeFieldsFragmentDoc = {"kind":"Document","definitions":[{"kind":"FragmentDefinition","name":{"kind":"Name","value":"MeFields"},"typeCondition":{"kind":"NamedType","name":{"kind":"Name","value":"Me"}},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"email"}},{"kind":"Field","name":{"kind":"Name","value":"fullName"}},{"kind":"Field","name":{"kind":"Name","value":"locale"}},{"kind":"Field","name":{"kind":"Name","value":"twoFactorEnabled"}},{"kind":"Field","name":{"kind":"Name","value":"memberships"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"role"}},{"kind":"Field","name":{"kind":"Name","value":"teamId"}},{"kind":"Field","name":{"kind":"Name","value":"clubId"}},{"kind":"Field","name":{"kind":"Name","value":"clubName"}}]}}]}}]} as unknown as DocumentNode<MeFieldsFragment, unknown>;
export const AuthFieldsFragmentDoc = {"kind":"Document","definitions":[{"kind":"FragmentDefinition","name":{"kind":"Name","value":"AuthFields"},"typeCondition":{"kind":"NamedType","name":{"kind":"Name","value":"AuthPayload"}},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"status"}},{"kind":"Field","name":{"kind":"Name","value":"accessToken"}},{"kind":"Field","name":{"kind":"Name","value":"accessTokenExpiresAt"}},{"kind":"Field","name":{"kind":"Name","value":"challengeToken"}},{"kind":"Field","name":{"kind":"Name","value":"user"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"FragmentSpread","name":{"kind":"Name","value":"MeFields"}}]}}]}},{"kind":"FragmentDefinition","name":{"kind":"Name","value":"MeFields"},"typeCondition":{"kind":"NamedType","name":{"kind":"Name","value":"Me"}},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"email"}},{"kind":"Field","name":{"kind":"Name","value":"fullName"}},{"kind":"Field","name":{"kind":"Name","value":"locale"}},{"kind":"Field","name":{"kind":"Name","value":"twoFactorEnabled"}},{"kind":"Field","name":{"kind":"Name","value":"memberships"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"role"}},{"kind":"Field","name":{"kind":"Name","value":"teamId"}},{"kind":"Field","name":{"kind":"Name","value":"clubId"}},{"kind":"Field","name":{"kind":"Name","value":"clubName"}}]}}]}}]} as unknown as DocumentNode<AuthFieldsFragment, unknown>;
export const ClubFieldsFragmentDoc = {"kind":"Document","definitions":[{"kind":"FragmentDefinition","name":{"kind":"Name","value":"ClubFields"},"typeCondition":{"kind":"NamedType","name":{"kind":"Name","value":"Club"}},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}},{"kind":"Field","name":{"kind":"Name","value":"legalName"}},{"kind":"Field","name":{"kind":"Name","value":"taxCode"}},{"kind":"Field","name":{"kind":"Name","value":"vatNumber"}},{"kind":"Field","name":{"kind":"Name","value":"sport"}},{"kind":"Field","name":{"kind":"Name","value":"email"}},{"kind":"Field","name":{"kind":"Name","value":"phone"}},{"kind":"Field","name":{"kind":"Name","value":"addressLine"}},{"kind":"Field","name":{"kind":"Name","value":"city"}},{"kind":"Field","name":{"kind":"Name","value":"province"}},{"kind":"Field","name":{"kind":"Name","value":"postalCode"}},{"kind":"Field","name":{"kind":"Name","value":"country"}},{"kind":"Field","name":{"kind":"Name","value":"federations"}}]}}]} as unknown as DocumentNode<ClubFieldsFragment, unknown>;
export const LoginDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"Login"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"input"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"LoginInput"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"login"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"input"},"value":{"kind":"Variable","name":{"kind":"Name","value":"input"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"FragmentSpread","name":{"kind":"Name","value":"AuthFields"}}]}}]}},{"kind":"FragmentDefinition","name":{"kind":"Name","value":"MeFields"},"typeCondition":{"kind":"NamedType","name":{"kind":"Name","value":"Me"}},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"email"}},{"kind":"Field","name":{"kind":"Name","value":"fullName"}},{"kind":"Field","name":{"kind":"Name","value":"locale"}},{"kind":"Field","name":{"kind":"Name","value":"twoFactorEnabled"}},{"kind":"Field","name":{"kind":"Name","value":"memberships"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"role"}},{"kind":"Field","name":{"kind":"Name","value":"teamId"}},{"kind":"Field","name":{"kind":"Name","value":"clubId"}},{"kind":"Field","name":{"kind":"Name","value":"clubName"}}]}}]}},{"kind":"FragmentDefinition","name":{"kind":"Name","value":"AuthFields"},"typeCondition":{"kind":"NamedType","name":{"kind":"Name","value":"AuthPayload"}},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"status"}},{"kind":"Field","name":{"kind":"Name","value":"accessToken"}},{"kind":"Field","name":{"kind":"Name","value":"accessTokenExpiresAt"}},{"kind":"Field","name":{"kind":"Name","value":"challengeToken"}},{"kind":"Field","name":{"kind":"Name","value":"user"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"FragmentSpread","name":{"kind":"Name","value":"MeFields"}}]}}]}}]} as unknown as DocumentNode<LoginMutation, LoginMutationVariables>;
export const RegisterDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"Register"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"input"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"RegisterInput"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"register"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"input"},"value":{"kind":"Variable","name":{"kind":"Name","value":"input"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"FragmentSpread","name":{"kind":"Name","value":"AuthFields"}}]}}]}},{"kind":"FragmentDefinition","name":{"kind":"Name","value":"MeFields"},"typeCondition":{"kind":"NamedType","name":{"kind":"Name","value":"Me"}},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"email"}},{"kind":"Field","name":{"kind":"Name","value":"fullName"}},{"kind":"Field","name":{"kind":"Name","value":"locale"}},{"kind":"Field","name":{"kind":"Name","value":"twoFactorEnabled"}},{"kind":"Field","name":{"kind":"Name","value":"memberships"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"role"}},{"kind":"Field","name":{"kind":"Name","value":"teamId"}},{"kind":"Field","name":{"kind":"Name","value":"clubId"}},{"kind":"Field","name":{"kind":"Name","value":"clubName"}}]}}]}},{"kind":"FragmentDefinition","name":{"kind":"Name","value":"AuthFields"},"typeCondition":{"kind":"NamedType","name":{"kind":"Name","value":"AuthPayload"}},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"status"}},{"kind":"Field","name":{"kind":"Name","value":"accessToken"}},{"kind":"Field","name":{"kind":"Name","value":"accessTokenExpiresAt"}},{"kind":"Field","name":{"kind":"Name","value":"challengeToken"}},{"kind":"Field","name":{"kind":"Name","value":"user"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"FragmentSpread","name":{"kind":"Name","value":"MeFields"}}]}}]}}]} as unknown as DocumentNode<RegisterMutation, RegisterMutationVariables>;
export const VerifyTwoFactorDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"VerifyTwoFactor"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"challengeToken"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"String"}}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"code"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"String"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"verifyTwoFactor"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"challengeToken"},"value":{"kind":"Variable","name":{"kind":"Name","value":"challengeToken"}}},{"kind":"Argument","name":{"kind":"Name","value":"code"},"value":{"kind":"Variable","name":{"kind":"Name","value":"code"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"FragmentSpread","name":{"kind":"Name","value":"AuthFields"}}]}}]}},{"kind":"FragmentDefinition","name":{"kind":"Name","value":"MeFields"},"typeCondition":{"kind":"NamedType","name":{"kind":"Name","value":"Me"}},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"email"}},{"kind":"Field","name":{"kind":"Name","value":"fullName"}},{"kind":"Field","name":{"kind":"Name","value":"locale"}},{"kind":"Field","name":{"kind":"Name","value":"twoFactorEnabled"}},{"kind":"Field","name":{"kind":"Name","value":"memberships"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"role"}},{"kind":"Field","name":{"kind":"Name","value":"teamId"}},{"kind":"Field","name":{"kind":"Name","value":"clubId"}},{"kind":"Field","name":{"kind":"Name","value":"clubName"}}]}}]}},{"kind":"FragmentDefinition","name":{"kind":"Name","value":"AuthFields"},"typeCondition":{"kind":"NamedType","name":{"kind":"Name","value":"AuthPayload"}},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"status"}},{"kind":"Field","name":{"kind":"Name","value":"accessToken"}},{"kind":"Field","name":{"kind":"Name","value":"accessTokenExpiresAt"}},{"kind":"Field","name":{"kind":"Name","value":"challengeToken"}},{"kind":"Field","name":{"kind":"Name","value":"user"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"FragmentSpread","name":{"kind":"Name","value":"MeFields"}}]}}]}}]} as unknown as DocumentNode<VerifyTwoFactorMutation, VerifyTwoFactorMutationVariables>;
export const RequestMagicLinkDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"RequestMagicLink"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"email"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"String"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"requestMagicLink"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"email"},"value":{"kind":"Variable","name":{"kind":"Name","value":"email"}}}]}]}}]} as unknown as DocumentNode<RequestMagicLinkMutation, RequestMagicLinkMutationVariables>;
export const ConsumeMagicLinkDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"ConsumeMagicLink"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"token"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"String"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"consumeMagicLink"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"token"},"value":{"kind":"Variable","name":{"kind":"Name","value":"token"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"FragmentSpread","name":{"kind":"Name","value":"AuthFields"}}]}}]}},{"kind":"FragmentDefinition","name":{"kind":"Name","value":"MeFields"},"typeCondition":{"kind":"NamedType","name":{"kind":"Name","value":"Me"}},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"email"}},{"kind":"Field","name":{"kind":"Name","value":"fullName"}},{"kind":"Field","name":{"kind":"Name","value":"locale"}},{"kind":"Field","name":{"kind":"Name","value":"twoFactorEnabled"}},{"kind":"Field","name":{"kind":"Name","value":"memberships"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"role"}},{"kind":"Field","name":{"kind":"Name","value":"teamId"}},{"kind":"Field","name":{"kind":"Name","value":"clubId"}},{"kind":"Field","name":{"kind":"Name","value":"clubName"}}]}}]}},{"kind":"FragmentDefinition","name":{"kind":"Name","value":"AuthFields"},"typeCondition":{"kind":"NamedType","name":{"kind":"Name","value":"AuthPayload"}},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"status"}},{"kind":"Field","name":{"kind":"Name","value":"accessToken"}},{"kind":"Field","name":{"kind":"Name","value":"accessTokenExpiresAt"}},{"kind":"Field","name":{"kind":"Name","value":"challengeToken"}},{"kind":"Field","name":{"kind":"Name","value":"user"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"FragmentSpread","name":{"kind":"Name","value":"MeFields"}}]}}]}}]} as unknown as DocumentNode<ConsumeMagicLinkMutation, ConsumeMagicLinkMutationVariables>;
export const RequestPasswordResetDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"RequestPasswordReset"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"email"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"String"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"requestPasswordReset"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"email"},"value":{"kind":"Variable","name":{"kind":"Name","value":"email"}}}]}]}}]} as unknown as DocumentNode<RequestPasswordResetMutation, RequestPasswordResetMutationVariables>;
export const ResetPasswordDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"ResetPassword"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"token"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"String"}}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"newPassword"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"String"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"resetPassword"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"token"},"value":{"kind":"Variable","name":{"kind":"Name","value":"token"}}},{"kind":"Argument","name":{"kind":"Name","value":"newPassword"},"value":{"kind":"Variable","name":{"kind":"Name","value":"newPassword"}}}]}]}}]} as unknown as DocumentNode<ResetPasswordMutation, ResetPasswordMutationVariables>;
export const ChangePasswordDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"ChangePassword"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"currentPassword"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"String"}}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"newPassword"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"String"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"changePassword"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"currentPassword"},"value":{"kind":"Variable","name":{"kind":"Name","value":"currentPassword"}}},{"kind":"Argument","name":{"kind":"Name","value":"newPassword"},"value":{"kind":"Variable","name":{"kind":"Name","value":"newPassword"}}}]}]}}]} as unknown as DocumentNode<ChangePasswordMutation, ChangePasswordMutationVariables>;
export const RefreshSessionDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"RefreshSession"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"refreshSession"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"FragmentSpread","name":{"kind":"Name","value":"AuthFields"}}]}}]}},{"kind":"FragmentDefinition","name":{"kind":"Name","value":"MeFields"},"typeCondition":{"kind":"NamedType","name":{"kind":"Name","value":"Me"}},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"email"}},{"kind":"Field","name":{"kind":"Name","value":"fullName"}},{"kind":"Field","name":{"kind":"Name","value":"locale"}},{"kind":"Field","name":{"kind":"Name","value":"twoFactorEnabled"}},{"kind":"Field","name":{"kind":"Name","value":"memberships"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"role"}},{"kind":"Field","name":{"kind":"Name","value":"teamId"}},{"kind":"Field","name":{"kind":"Name","value":"clubId"}},{"kind":"Field","name":{"kind":"Name","value":"clubName"}}]}}]}},{"kind":"FragmentDefinition","name":{"kind":"Name","value":"AuthFields"},"typeCondition":{"kind":"NamedType","name":{"kind":"Name","value":"AuthPayload"}},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"status"}},{"kind":"Field","name":{"kind":"Name","value":"accessToken"}},{"kind":"Field","name":{"kind":"Name","value":"accessTokenExpiresAt"}},{"kind":"Field","name":{"kind":"Name","value":"challengeToken"}},{"kind":"Field","name":{"kind":"Name","value":"user"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"FragmentSpread","name":{"kind":"Name","value":"MeFields"}}]}}]}}]} as unknown as DocumentNode<RefreshSessionMutation, RefreshSessionMutationVariables>;
export const LogoutDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"Logout"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"logout"}}]}}]} as unknown as DocumentNode<LogoutMutation, LogoutMutationVariables>;
export const MeDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"query","name":{"kind":"Name","value":"Me"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"me"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"FragmentSpread","name":{"kind":"Name","value":"MeFields"}}]}}]}},{"kind":"FragmentDefinition","name":{"kind":"Name","value":"MeFields"},"typeCondition":{"kind":"NamedType","name":{"kind":"Name","value":"Me"}},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"email"}},{"kind":"Field","name":{"kind":"Name","value":"fullName"}},{"kind":"Field","name":{"kind":"Name","value":"locale"}},{"kind":"Field","name":{"kind":"Name","value":"twoFactorEnabled"}},{"kind":"Field","name":{"kind":"Name","value":"memberships"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"role"}},{"kind":"Field","name":{"kind":"Name","value":"teamId"}},{"kind":"Field","name":{"kind":"Name","value":"clubId"}},{"kind":"Field","name":{"kind":"Name","value":"clubName"}}]}}]}}]} as unknown as DocumentNode<MeQuery, MeQueryVariables>;
export const UpdateMeDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"UpdateMe"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"input"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"UpdateMeInput"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"updateMe"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"input"},"value":{"kind":"Variable","name":{"kind":"Name","value":"input"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"FragmentSpread","name":{"kind":"Name","value":"MeFields"}}]}}]}},{"kind":"FragmentDefinition","name":{"kind":"Name","value":"MeFields"},"typeCondition":{"kind":"NamedType","name":{"kind":"Name","value":"Me"}},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"email"}},{"kind":"Field","name":{"kind":"Name","value":"fullName"}},{"kind":"Field","name":{"kind":"Name","value":"locale"}},{"kind":"Field","name":{"kind":"Name","value":"twoFactorEnabled"}},{"kind":"Field","name":{"kind":"Name","value":"memberships"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"role"}},{"kind":"Field","name":{"kind":"Name","value":"teamId"}},{"kind":"Field","name":{"kind":"Name","value":"clubId"}},{"kind":"Field","name":{"kind":"Name","value":"clubName"}}]}}]}}]} as unknown as DocumentNode<UpdateMeMutation, UpdateMeMutationVariables>;
export const SetupTwoFactorDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"SetupTwoFactor"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"setupTwoFactor"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"secret"}},{"kind":"Field","name":{"kind":"Name","value":"otpauthUri"}}]}}]}}]} as unknown as DocumentNode<SetupTwoFactorMutation, SetupTwoFactorMutationVariables>;
export const EnableTwoFactorDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"EnableTwoFactor"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"code"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"String"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"enableTwoFactor"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"code"},"value":{"kind":"Variable","name":{"kind":"Name","value":"code"}}}]}]}}]} as unknown as DocumentNode<EnableTwoFactorMutation, EnableTwoFactorMutationVariables>;
export const DisableTwoFactorDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"DisableTwoFactor"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"code"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"String"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"disableTwoFactor"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"code"},"value":{"kind":"Variable","name":{"kind":"Name","value":"code"}}}]}]}}]} as unknown as DocumentNode<DisableTwoFactorMutation, DisableTwoFactorMutationVariables>;
export const ClubDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"query","name":{"kind":"Name","value":"Club"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"club"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"FragmentSpread","name":{"kind":"Name","value":"ClubFields"}}]}}]}},{"kind":"FragmentDefinition","name":{"kind":"Name","value":"ClubFields"},"typeCondition":{"kind":"NamedType","name":{"kind":"Name","value":"Club"}},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}},{"kind":"Field","name":{"kind":"Name","value":"legalName"}},{"kind":"Field","name":{"kind":"Name","value":"taxCode"}},{"kind":"Field","name":{"kind":"Name","value":"vatNumber"}},{"kind":"Field","name":{"kind":"Name","value":"sport"}},{"kind":"Field","name":{"kind":"Name","value":"email"}},{"kind":"Field","name":{"kind":"Name","value":"phone"}},{"kind":"Field","name":{"kind":"Name","value":"addressLine"}},{"kind":"Field","name":{"kind":"Name","value":"city"}},{"kind":"Field","name":{"kind":"Name","value":"province"}},{"kind":"Field","name":{"kind":"Name","value":"postalCode"}},{"kind":"Field","name":{"kind":"Name","value":"country"}},{"kind":"Field","name":{"kind":"Name","value":"federations"}}]}}]} as unknown as DocumentNode<ClubQuery, ClubQueryVariables>;
export const CreateClubDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"CreateClub"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"input"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"ClubInput"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"createClub"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"input"},"value":{"kind":"Variable","name":{"kind":"Name","value":"input"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"FragmentSpread","name":{"kind":"Name","value":"ClubFields"}}]}}]}},{"kind":"FragmentDefinition","name":{"kind":"Name","value":"ClubFields"},"typeCondition":{"kind":"NamedType","name":{"kind":"Name","value":"Club"}},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}},{"kind":"Field","name":{"kind":"Name","value":"legalName"}},{"kind":"Field","name":{"kind":"Name","value":"taxCode"}},{"kind":"Field","name":{"kind":"Name","value":"vatNumber"}},{"kind":"Field","name":{"kind":"Name","value":"sport"}},{"kind":"Field","name":{"kind":"Name","value":"email"}},{"kind":"Field","name":{"kind":"Name","value":"phone"}},{"kind":"Field","name":{"kind":"Name","value":"addressLine"}},{"kind":"Field","name":{"kind":"Name","value":"city"}},{"kind":"Field","name":{"kind":"Name","value":"province"}},{"kind":"Field","name":{"kind":"Name","value":"postalCode"}},{"kind":"Field","name":{"kind":"Name","value":"country"}},{"kind":"Field","name":{"kind":"Name","value":"federations"}}]}}]} as unknown as DocumentNode<CreateClubMutation, CreateClubMutationVariables>;
export const UpdateClubDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"UpdateClub"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"input"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"ClubInput"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"updateClub"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"input"},"value":{"kind":"Variable","name":{"kind":"Name","value":"input"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"FragmentSpread","name":{"kind":"Name","value":"ClubFields"}}]}}]}},{"kind":"FragmentDefinition","name":{"kind":"Name","value":"ClubFields"},"typeCondition":{"kind":"NamedType","name":{"kind":"Name","value":"Club"}},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}},{"kind":"Field","name":{"kind":"Name","value":"legalName"}},{"kind":"Field","name":{"kind":"Name","value":"taxCode"}},{"kind":"Field","name":{"kind":"Name","value":"vatNumber"}},{"kind":"Field","name":{"kind":"Name","value":"sport"}},{"kind":"Field","name":{"kind":"Name","value":"email"}},{"kind":"Field","name":{"kind":"Name","value":"phone"}},{"kind":"Field","name":{"kind":"Name","value":"addressLine"}},{"kind":"Field","name":{"kind":"Name","value":"city"}},{"kind":"Field","name":{"kind":"Name","value":"province"}},{"kind":"Field","name":{"kind":"Name","value":"postalCode"}},{"kind":"Field","name":{"kind":"Name","value":"country"}},{"kind":"Field","name":{"kind":"Name","value":"federations"}}]}}]} as unknown as DocumentNode<UpdateClubMutation, UpdateClubMutationVariables>;
export const SeasonsDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"query","name":{"kind":"Name","value":"Seasons"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"seasons"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}},{"kind":"Field","name":{"kind":"Name","value":"startsOn"}},{"kind":"Field","name":{"kind":"Name","value":"endsOn"}},{"kind":"Field","name":{"kind":"Name","value":"status"}}]}}]}}]} as unknown as DocumentNode<SeasonsQuery, SeasonsQueryVariables>;
export const CreateSeasonDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"CreateSeason"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"input"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"SeasonInput"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"createSeason"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"input"},"value":{"kind":"Variable","name":{"kind":"Name","value":"input"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}}]}}]}}]} as unknown as DocumentNode<CreateSeasonMutation, CreateSeasonMutationVariables>;
export const SetSeasonStatusDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"SetSeasonStatus"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"id"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"ID"}}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"status"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"SeasonStatus"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"setSeasonStatus"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"id"},"value":{"kind":"Variable","name":{"kind":"Name","value":"id"}}},{"kind":"Argument","name":{"kind":"Name","value":"status"},"value":{"kind":"Variable","name":{"kind":"Name","value":"status"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"status"}}]}}]}}]} as unknown as DocumentNode<SetSeasonStatusMutation, SetSeasonStatusMutationVariables>;
export const MembersDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"query","name":{"kind":"Name","value":"Members"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"members"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"membershipId"}},{"kind":"Field","name":{"kind":"Name","value":"userId"}},{"kind":"Field","name":{"kind":"Name","value":"fullName"}},{"kind":"Field","name":{"kind":"Name","value":"email"}},{"kind":"Field","name":{"kind":"Name","value":"role"}},{"kind":"Field","name":{"kind":"Name","value":"teamId"}},{"kind":"Field","name":{"kind":"Name","value":"createdAt"}}]}},{"kind":"Field","name":{"kind":"Name","value":"invitations"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"email"}},{"kind":"Field","name":{"kind":"Name","value":"role"}},{"kind":"Field","name":{"kind":"Name","value":"expiresAt"}},{"kind":"Field","name":{"kind":"Name","value":"createdAt"}}]}}]}}]} as unknown as DocumentNode<MembersQuery, MembersQueryVariables>;
export const InviteMemberDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"InviteMember"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"input"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"InviteMemberInput"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"inviteMember"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"input"},"value":{"kind":"Variable","name":{"kind":"Name","value":"input"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}}]}}]}}]} as unknown as DocumentNode<InviteMemberMutation, InviteMemberMutationVariables>;
export const RevokeInvitationDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"RevokeInvitation"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"id"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"ID"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"revokeInvitation"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"id"},"value":{"kind":"Variable","name":{"kind":"Name","value":"id"}}}]}]}}]} as unknown as DocumentNode<RevokeInvitationMutation, RevokeInvitationMutationVariables>;
export const RemoveMembershipDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"RemoveMembership"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"membershipId"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"ID"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"removeMembership"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"membershipId"},"value":{"kind":"Variable","name":{"kind":"Name","value":"membershipId"}}}]}]}}]} as unknown as DocumentNode<RemoveMembershipMutation, RemoveMembershipMutationVariables>;
export const InvitationPreviewDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"query","name":{"kind":"Name","value":"InvitationPreview"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"token"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"String"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"invitationPreview"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"token"},"value":{"kind":"Variable","name":{"kind":"Name","value":"token"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"clubId"}},{"kind":"Field","name":{"kind":"Name","value":"clubName"}},{"kind":"Field","name":{"kind":"Name","value":"email"}},{"kind":"Field","name":{"kind":"Name","value":"role"}},{"kind":"Field","name":{"kind":"Name","value":"expiresAt"}},{"kind":"Field","name":{"kind":"Name","value":"accountExists"}}]}}]}}]} as unknown as DocumentNode<InvitationPreviewQuery, InvitationPreviewQueryVariables>;
export const AcceptInvitationDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"AcceptInvitation"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"input"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"AcceptInvitationInput"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"acceptInvitation"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"input"},"value":{"kind":"Variable","name":{"kind":"Name","value":"input"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"FragmentSpread","name":{"kind":"Name","value":"AuthFields"}}]}}]}},{"kind":"FragmentDefinition","name":{"kind":"Name","value":"MeFields"},"typeCondition":{"kind":"NamedType","name":{"kind":"Name","value":"Me"}},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"email"}},{"kind":"Field","name":{"kind":"Name","value":"fullName"}},{"kind":"Field","name":{"kind":"Name","value":"locale"}},{"kind":"Field","name":{"kind":"Name","value":"twoFactorEnabled"}},{"kind":"Field","name":{"kind":"Name","value":"memberships"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"role"}},{"kind":"Field","name":{"kind":"Name","value":"teamId"}},{"kind":"Field","name":{"kind":"Name","value":"clubId"}},{"kind":"Field","name":{"kind":"Name","value":"clubName"}}]}}]}},{"kind":"FragmentDefinition","name":{"kind":"Name","value":"AuthFields"},"typeCondition":{"kind":"NamedType","name":{"kind":"Name","value":"AuthPayload"}},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"status"}},{"kind":"Field","name":{"kind":"Name","value":"accessToken"}},{"kind":"Field","name":{"kind":"Name","value":"accessTokenExpiresAt"}},{"kind":"Field","name":{"kind":"Name","value":"challengeToken"}},{"kind":"Field","name":{"kind":"Name","value":"user"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"FragmentSpread","name":{"kind":"Name","value":"MeFields"}}]}}]}}]} as unknown as DocumentNode<AcceptInvitationMutation, AcceptInvitationMutationVariables>;
export const AuditEventsDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"query","name":{"kind":"Name","value":"AuditEvents"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"beforeId"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"String"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"auditEvents"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"limit"},"value":{"kind":"IntValue","value":"50"}},{"kind":"Argument","name":{"kind":"Name","value":"beforeId"},"value":{"kind":"Variable","name":{"kind":"Name","value":"beforeId"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"action"}},{"kind":"Field","name":{"kind":"Name","value":"actorName"}},{"kind":"Field","name":{"kind":"Name","value":"entityType"}},{"kind":"Field","name":{"kind":"Name","value":"entityId"}},{"kind":"Field","name":{"kind":"Name","value":"metadata"}},{"kind":"Field","name":{"kind":"Name","value":"createdAt"}}]}}]}}]} as unknown as DocumentNode<AuditEventsQuery, AuditEventsQueryVariables>;
export const MyConsentsDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"query","name":{"kind":"Name","value":"MyConsents"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"myConsents"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"kind"}},{"kind":"Field","name":{"kind":"Name","value":"clubId"}},{"kind":"Field","name":{"kind":"Name","value":"version"}},{"kind":"Field","name":{"kind":"Name","value":"granted"}},{"kind":"Field","name":{"kind":"Name","value":"recordedAt"}}]}}]}}]} as unknown as DocumentNode<MyConsentsQuery, MyConsentsQueryVariables>;
export const RecordConsentDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"RecordConsent"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"kind"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"ConsentKind"}}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"granted"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"Boolean"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"recordConsent"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"kind"},"value":{"kind":"Variable","name":{"kind":"Name","value":"kind"}}},{"kind":"Argument","name":{"kind":"Name","value":"granted"},"value":{"kind":"Variable","name":{"kind":"Name","value":"granted"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"kind"}},{"kind":"Field","name":{"kind":"Name","value":"granted"}}]}}]}}]} as unknown as DocumentNode<RecordConsentMutation, RecordConsentMutationVariables>;
export const MyDataExportDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"query","name":{"kind":"Name","value":"MyDataExport"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"myDataExport"}}]}}]} as unknown as DocumentNode<MyDataExportQuery, MyDataExportQueryVariables>;