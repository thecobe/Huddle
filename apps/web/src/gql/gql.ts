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
    "\n  query AttendanceRegister($teamId: ID!, $from: DateTime!, $to: DateTime!, $kind: EventKind) {\n    attendanceRegister(teamId: $teamId, from: $from, to: $to, kind: $kind) {\n      events {\n        id\n        startsAt\n        kind\n        title\n        opponent\n        rollCallDone\n      }\n      players {\n        personId\n        firstName\n        lastName\n        jerseyNumber\n        recorded\n        attended\n        excused\n        percentage\n      }\n      cells {\n        eventId\n        personId\n        status\n        note\n      }\n    }\n  }\n": typeof types.AttendanceRegisterDocument,
    "\n  fragment EventFields on CalendarEvent {\n    id\n    teamId\n    teamName\n    teamColor\n    seriesId\n    detached\n    kind\n    title\n    startsAt\n    endsAt\n    location\n    notes\n    status\n    cancelReason\n    opponent\n    isHome\n    competition\n    canEdit\n  }\n": typeof types.EventFieldsFragmentDoc,
    "\n  query Calendar($from: DateTime!, $to: DateTime!, $teamId: ID) {\n    events(from: $from, to: $to, teamId: $teamId) {\n      ...EventFields\n    }\n  }\n": typeof types.CalendarDocument,
    "\n  query CalendarContext {\n    club {\n      id\n      timezone\n    }\n    manageableTeamIds\n    teams(includeArchived: false) {\n      id\n      name\n      seasonName\n      color\n    }\n  }\n": typeof types.CalendarContextDocument,
    "\n  query Series($teamId: ID) {\n    eventSeries(teamId: $teamId) {\n      id\n      teamId\n      teamName\n      title\n      weekdays\n      startTime\n      durationMinutes\n      location\n      startsOn\n      endsOn\n      upcomingCount\n    }\n  }\n": typeof types.SeriesDocument,
    "\n  mutation CreateSeries($input: SeriesInput!) {\n    createEventSeries(input: $input) {\n      id\n      upcomingCount\n    }\n  }\n": typeof types.CreateSeriesDocument,
    "\n  mutation UpdateSeries($id: ID!, $input: SeriesInput!, $fromDate: String) {\n    updateEventSeries(id: $id, input: $input, fromDate: $fromDate) {\n      id\n      upcomingCount\n    }\n  }\n": typeof types.UpdateSeriesDocument,
    "\n  mutation EndSeries($id: ID!, $fromDate: String!) {\n    endEventSeries(id: $id, fromDate: $fromDate)\n  }\n": typeof types.EndSeriesDocument,
    "\n  mutation CreateEvent($input: EventInput!) {\n    createEvent(input: $input) {\n      ...EventFields\n    }\n  }\n": typeof types.CreateEventDocument,
    "\n  mutation UpdateEvent($id: ID!, $input: EventInput!) {\n    updateEvent(id: $id, input: $input) {\n      ...EventFields\n    }\n  }\n": typeof types.UpdateEventDocument,
    "\n  mutation SetEventCancelled($id: ID!, $cancelled: Boolean!, $reason: String) {\n    setEventCancelled(id: $id, cancelled: $cancelled, reason: $reason) {\n      ...EventFields\n    }\n  }\n": typeof types.SetEventCancelledDocument,
    "\n  mutation DeleteEvent($id: ID!) {\n    deleteEvent(id: $id)\n  }\n": typeof types.DeleteEventDocument,
    "\n  mutation CancelRange($input: CancelRangeInput!) {\n    cancelEventsInRange(input: $input)\n  }\n": typeof types.CancelRangeDocument,
    "\n  mutation CreateFeed($teamId: ID) {\n    createCalendarFeed(teamId: $teamId) {\n      url\n    }\n  }\n": typeof types.CreateFeedDocument,
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
    "\n  fragment PersonFields on Person {\n    id\n    firstName\n    lastName\n    birthDate\n    birthPlace\n    taxCode\n    gender\n    categories\n    email\n    phone\n    addressLine\n    city\n    province\n    postalCode\n    notes\n    age\n    isMinor\n    hasAccount\n    archivedAt\n    guardians {\n      id\n      relation\n      person {\n        id\n        firstName\n        lastName\n        email\n        phone\n      }\n    }\n    wards {\n      id\n      relation\n      person {\n        id\n        firstName\n        lastName\n      }\n    }\n    teams {\n      teamId\n      teamName\n      seasonName\n      asPlayer\n      staffRole\n      jerseyNumber\n    }\n  }\n": typeof types.PersonFieldsFragmentDoc,
    "\n  query People($filter: PeopleFilter, $limit: Int!, $offset: Int!) {\n    people(filter: $filter, limit: $limit, offset: $offset) {\n      total\n      items {\n        id\n        firstName\n        lastName\n        birthDate\n        age\n        isMinor\n        categories\n        email\n        phone\n        hasAccount\n        archivedAt\n        teams {\n          teamId\n          teamName\n        }\n      }\n    }\n  }\n": typeof types.PeopleDocument,
    "\n  query Person($id: ID!) {\n    person(id: $id) {\n      ...PersonFields\n    }\n  }\n": typeof types.PersonDocument,
    "\n  mutation CreatePerson($input: PersonInput!) {\n    createPerson(input: $input) {\n      id\n    }\n  }\n": typeof types.CreatePersonDocument,
    "\n  mutation UpdatePerson($id: ID!, $input: PersonInput!) {\n    updatePerson(id: $id, input: $input) {\n      ...PersonFields\n    }\n  }\n": typeof types.UpdatePersonDocument,
    "\n  mutation SetPersonArchived($id: ID!, $archived: Boolean!) {\n    setPersonArchived(id: $id, archived: $archived) {\n      ...PersonFields\n    }\n  }\n": typeof types.SetPersonArchivedDocument,
    "\n  mutation AddGuardian($minorId: ID!, $guardianId: ID!, $relation: GuardianRelation!) {\n    addGuardian(minorId: $minorId, guardianId: $guardianId, relation: $relation) {\n      ...PersonFields\n    }\n  }\n": typeof types.AddGuardianDocument,
    "\n  mutation RemoveGuardian($guardianshipId: ID!) {\n    removeGuardian(guardianshipId: $guardianshipId) {\n      ...PersonFields\n    }\n  }\n": typeof types.RemoveGuardianDocument,
    "\n  mutation InvitePersonAccount($personId: ID!, $email: String!, $role: MembershipRole!) {\n    invitePersonAccount(personId: $personId, email: $email, role: $role) {\n      id\n    }\n  }\n": typeof types.InvitePersonAccountDocument,
    "\n  mutation PreviewPeopleImport($rows: [PersonImportRow!]!) {\n    previewPeopleImport(rows: $rows) {\n      index\n      status\n      errors\n      personId\n    }\n  }\n": typeof types.PreviewPeopleImportDocument,
    "\n  mutation CommitPeopleImport($rows: [PersonImportRow!]!) {\n    commitPeopleImport(rows: $rows) {\n      created\n      updated\n      guardiansLinked\n      addedToTeams\n    }\n  }\n": typeof types.CommitPeopleImportDocument,
    "\n  fragment TeamFields on Team {\n    id\n    seasonId\n    seasonName\n    name\n    category\n    birthYearFrom\n    birthYearTo\n    color\n    playerCount\n    staffCount\n    archivedAt\n  }\n": typeof types.TeamFieldsFragmentDoc,
    "\n  query Teams($seasonId: ID, $includeArchived: Boolean!) {\n    teams(seasonId: $seasonId, includeArchived: $includeArchived) {\n      ...TeamFields\n    }\n    seasons {\n      id\n      name\n      status\n    }\n  }\n": typeof types.TeamsDocument,
    "\n  fragment TeamDetailFields on TeamDetail {\n    id\n    seasonId\n    seasonName\n    name\n    category\n    birthYearFrom\n    birthYearTo\n    color\n    playerCount\n    staffCount\n    archivedAt\n    players {\n      id\n      personId\n      firstName\n      lastName\n      birthDate\n      jerseyNumber\n      position\n      availability\n      email\n      phone\n      guardians {\n        personId\n        name\n        relation\n        email\n        phone\n      }\n    }\n    staff {\n      id\n      personId\n      firstName\n      lastName\n      role\n      email\n      phone\n      hasAccount\n    }\n  }\n": typeof types.TeamDetailFieldsFragmentDoc,
    "\n  query Team($id: ID!) {\n    team(id: $id) {\n      ...TeamDetailFields\n    }\n  }\n": typeof types.TeamDocument,
    "\n  mutation CreateTeam($input: TeamInput!) {\n    createTeam(input: $input) {\n      id\n    }\n  }\n": typeof types.CreateTeamDocument,
    "\n  mutation UpdateTeam($id: ID!, $input: TeamInput!) {\n    updateTeam(id: $id, input: $input) {\n      ...TeamDetailFields\n    }\n  }\n": typeof types.UpdateTeamDocument,
    "\n  mutation CopyTeams($input: CopyTeamsInput!) {\n    copyTeams(input: $input) {\n      id\n    }\n  }\n": typeof types.CopyTeamsDocument,
    "\n  mutation AddPlayer($teamId: ID!, $personId: ID!, $input: PlayerInput) {\n    addPlayer(teamId: $teamId, personId: $personId, input: $input) {\n      ...TeamDetailFields\n    }\n  }\n": typeof types.AddPlayerDocument,
    "\n  mutation UpdatePlayer($rosterId: ID!, $input: PlayerInput!) {\n    updatePlayer(rosterId: $rosterId, input: $input) {\n      ...TeamDetailFields\n    }\n  }\n": typeof types.UpdatePlayerDocument,
    "\n  mutation RemovePlayer($rosterId: ID!) {\n    removePlayer(rosterId: $rosterId) {\n      ...TeamDetailFields\n    }\n  }\n": typeof types.RemovePlayerDocument,
    "\n  mutation AddStaff($teamId: ID!, $personId: ID!, $role: StaffRole!) {\n    addStaff(teamId: $teamId, personId: $personId, role: $role) {\n      ...TeamDetailFields\n    }\n  }\n": typeof types.AddStaffDocument,
    "\n  mutation RemoveStaff($staffId: ID!) {\n    removeStaff(staffId: $staffId) {\n      ...TeamDetailFields\n    }\n  }\n": typeof types.RemoveStaffDocument,
};
const documents: Documents = {
    "\n  query AttendanceRegister($teamId: ID!, $from: DateTime!, $to: DateTime!, $kind: EventKind) {\n    attendanceRegister(teamId: $teamId, from: $from, to: $to, kind: $kind) {\n      events {\n        id\n        startsAt\n        kind\n        title\n        opponent\n        rollCallDone\n      }\n      players {\n        personId\n        firstName\n        lastName\n        jerseyNumber\n        recorded\n        attended\n        excused\n        percentage\n      }\n      cells {\n        eventId\n        personId\n        status\n        note\n      }\n    }\n  }\n": types.AttendanceRegisterDocument,
    "\n  fragment EventFields on CalendarEvent {\n    id\n    teamId\n    teamName\n    teamColor\n    seriesId\n    detached\n    kind\n    title\n    startsAt\n    endsAt\n    location\n    notes\n    status\n    cancelReason\n    opponent\n    isHome\n    competition\n    canEdit\n  }\n": types.EventFieldsFragmentDoc,
    "\n  query Calendar($from: DateTime!, $to: DateTime!, $teamId: ID) {\n    events(from: $from, to: $to, teamId: $teamId) {\n      ...EventFields\n    }\n  }\n": types.CalendarDocument,
    "\n  query CalendarContext {\n    club {\n      id\n      timezone\n    }\n    manageableTeamIds\n    teams(includeArchived: false) {\n      id\n      name\n      seasonName\n      color\n    }\n  }\n": types.CalendarContextDocument,
    "\n  query Series($teamId: ID) {\n    eventSeries(teamId: $teamId) {\n      id\n      teamId\n      teamName\n      title\n      weekdays\n      startTime\n      durationMinutes\n      location\n      startsOn\n      endsOn\n      upcomingCount\n    }\n  }\n": types.SeriesDocument,
    "\n  mutation CreateSeries($input: SeriesInput!) {\n    createEventSeries(input: $input) {\n      id\n      upcomingCount\n    }\n  }\n": types.CreateSeriesDocument,
    "\n  mutation UpdateSeries($id: ID!, $input: SeriesInput!, $fromDate: String) {\n    updateEventSeries(id: $id, input: $input, fromDate: $fromDate) {\n      id\n      upcomingCount\n    }\n  }\n": types.UpdateSeriesDocument,
    "\n  mutation EndSeries($id: ID!, $fromDate: String!) {\n    endEventSeries(id: $id, fromDate: $fromDate)\n  }\n": types.EndSeriesDocument,
    "\n  mutation CreateEvent($input: EventInput!) {\n    createEvent(input: $input) {\n      ...EventFields\n    }\n  }\n": types.CreateEventDocument,
    "\n  mutation UpdateEvent($id: ID!, $input: EventInput!) {\n    updateEvent(id: $id, input: $input) {\n      ...EventFields\n    }\n  }\n": types.UpdateEventDocument,
    "\n  mutation SetEventCancelled($id: ID!, $cancelled: Boolean!, $reason: String) {\n    setEventCancelled(id: $id, cancelled: $cancelled, reason: $reason) {\n      ...EventFields\n    }\n  }\n": types.SetEventCancelledDocument,
    "\n  mutation DeleteEvent($id: ID!) {\n    deleteEvent(id: $id)\n  }\n": types.DeleteEventDocument,
    "\n  mutation CancelRange($input: CancelRangeInput!) {\n    cancelEventsInRange(input: $input)\n  }\n": types.CancelRangeDocument,
    "\n  mutation CreateFeed($teamId: ID) {\n    createCalendarFeed(teamId: $teamId) {\n      url\n    }\n  }\n": types.CreateFeedDocument,
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
    "\n  fragment PersonFields on Person {\n    id\n    firstName\n    lastName\n    birthDate\n    birthPlace\n    taxCode\n    gender\n    categories\n    email\n    phone\n    addressLine\n    city\n    province\n    postalCode\n    notes\n    age\n    isMinor\n    hasAccount\n    archivedAt\n    guardians {\n      id\n      relation\n      person {\n        id\n        firstName\n        lastName\n        email\n        phone\n      }\n    }\n    wards {\n      id\n      relation\n      person {\n        id\n        firstName\n        lastName\n      }\n    }\n    teams {\n      teamId\n      teamName\n      seasonName\n      asPlayer\n      staffRole\n      jerseyNumber\n    }\n  }\n": types.PersonFieldsFragmentDoc,
    "\n  query People($filter: PeopleFilter, $limit: Int!, $offset: Int!) {\n    people(filter: $filter, limit: $limit, offset: $offset) {\n      total\n      items {\n        id\n        firstName\n        lastName\n        birthDate\n        age\n        isMinor\n        categories\n        email\n        phone\n        hasAccount\n        archivedAt\n        teams {\n          teamId\n          teamName\n        }\n      }\n    }\n  }\n": types.PeopleDocument,
    "\n  query Person($id: ID!) {\n    person(id: $id) {\n      ...PersonFields\n    }\n  }\n": types.PersonDocument,
    "\n  mutation CreatePerson($input: PersonInput!) {\n    createPerson(input: $input) {\n      id\n    }\n  }\n": types.CreatePersonDocument,
    "\n  mutation UpdatePerson($id: ID!, $input: PersonInput!) {\n    updatePerson(id: $id, input: $input) {\n      ...PersonFields\n    }\n  }\n": types.UpdatePersonDocument,
    "\n  mutation SetPersonArchived($id: ID!, $archived: Boolean!) {\n    setPersonArchived(id: $id, archived: $archived) {\n      ...PersonFields\n    }\n  }\n": types.SetPersonArchivedDocument,
    "\n  mutation AddGuardian($minorId: ID!, $guardianId: ID!, $relation: GuardianRelation!) {\n    addGuardian(minorId: $minorId, guardianId: $guardianId, relation: $relation) {\n      ...PersonFields\n    }\n  }\n": types.AddGuardianDocument,
    "\n  mutation RemoveGuardian($guardianshipId: ID!) {\n    removeGuardian(guardianshipId: $guardianshipId) {\n      ...PersonFields\n    }\n  }\n": types.RemoveGuardianDocument,
    "\n  mutation InvitePersonAccount($personId: ID!, $email: String!, $role: MembershipRole!) {\n    invitePersonAccount(personId: $personId, email: $email, role: $role) {\n      id\n    }\n  }\n": types.InvitePersonAccountDocument,
    "\n  mutation PreviewPeopleImport($rows: [PersonImportRow!]!) {\n    previewPeopleImport(rows: $rows) {\n      index\n      status\n      errors\n      personId\n    }\n  }\n": types.PreviewPeopleImportDocument,
    "\n  mutation CommitPeopleImport($rows: [PersonImportRow!]!) {\n    commitPeopleImport(rows: $rows) {\n      created\n      updated\n      guardiansLinked\n      addedToTeams\n    }\n  }\n": types.CommitPeopleImportDocument,
    "\n  fragment TeamFields on Team {\n    id\n    seasonId\n    seasonName\n    name\n    category\n    birthYearFrom\n    birthYearTo\n    color\n    playerCount\n    staffCount\n    archivedAt\n  }\n": types.TeamFieldsFragmentDoc,
    "\n  query Teams($seasonId: ID, $includeArchived: Boolean!) {\n    teams(seasonId: $seasonId, includeArchived: $includeArchived) {\n      ...TeamFields\n    }\n    seasons {\n      id\n      name\n      status\n    }\n  }\n": types.TeamsDocument,
    "\n  fragment TeamDetailFields on TeamDetail {\n    id\n    seasonId\n    seasonName\n    name\n    category\n    birthYearFrom\n    birthYearTo\n    color\n    playerCount\n    staffCount\n    archivedAt\n    players {\n      id\n      personId\n      firstName\n      lastName\n      birthDate\n      jerseyNumber\n      position\n      availability\n      email\n      phone\n      guardians {\n        personId\n        name\n        relation\n        email\n        phone\n      }\n    }\n    staff {\n      id\n      personId\n      firstName\n      lastName\n      role\n      email\n      phone\n      hasAccount\n    }\n  }\n": types.TeamDetailFieldsFragmentDoc,
    "\n  query Team($id: ID!) {\n    team(id: $id) {\n      ...TeamDetailFields\n    }\n  }\n": types.TeamDocument,
    "\n  mutation CreateTeam($input: TeamInput!) {\n    createTeam(input: $input) {\n      id\n    }\n  }\n": types.CreateTeamDocument,
    "\n  mutation UpdateTeam($id: ID!, $input: TeamInput!) {\n    updateTeam(id: $id, input: $input) {\n      ...TeamDetailFields\n    }\n  }\n": types.UpdateTeamDocument,
    "\n  mutation CopyTeams($input: CopyTeamsInput!) {\n    copyTeams(input: $input) {\n      id\n    }\n  }\n": types.CopyTeamsDocument,
    "\n  mutation AddPlayer($teamId: ID!, $personId: ID!, $input: PlayerInput) {\n    addPlayer(teamId: $teamId, personId: $personId, input: $input) {\n      ...TeamDetailFields\n    }\n  }\n": types.AddPlayerDocument,
    "\n  mutation UpdatePlayer($rosterId: ID!, $input: PlayerInput!) {\n    updatePlayer(rosterId: $rosterId, input: $input) {\n      ...TeamDetailFields\n    }\n  }\n": types.UpdatePlayerDocument,
    "\n  mutation RemovePlayer($rosterId: ID!) {\n    removePlayer(rosterId: $rosterId) {\n      ...TeamDetailFields\n    }\n  }\n": types.RemovePlayerDocument,
    "\n  mutation AddStaff($teamId: ID!, $personId: ID!, $role: StaffRole!) {\n    addStaff(teamId: $teamId, personId: $personId, role: $role) {\n      ...TeamDetailFields\n    }\n  }\n": types.AddStaffDocument,
    "\n  mutation RemoveStaff($staffId: ID!) {\n    removeStaff(staffId: $staffId) {\n      ...TeamDetailFields\n    }\n  }\n": types.RemoveStaffDocument,
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
export function graphql(source: "\n  query AttendanceRegister($teamId: ID!, $from: DateTime!, $to: DateTime!, $kind: EventKind) {\n    attendanceRegister(teamId: $teamId, from: $from, to: $to, kind: $kind) {\n      events {\n        id\n        startsAt\n        kind\n        title\n        opponent\n        rollCallDone\n      }\n      players {\n        personId\n        firstName\n        lastName\n        jerseyNumber\n        recorded\n        attended\n        excused\n        percentage\n      }\n      cells {\n        eventId\n        personId\n        status\n        note\n      }\n    }\n  }\n"): (typeof documents)["\n  query AttendanceRegister($teamId: ID!, $from: DateTime!, $to: DateTime!, $kind: EventKind) {\n    attendanceRegister(teamId: $teamId, from: $from, to: $to, kind: $kind) {\n      events {\n        id\n        startsAt\n        kind\n        title\n        opponent\n        rollCallDone\n      }\n      players {\n        personId\n        firstName\n        lastName\n        jerseyNumber\n        recorded\n        attended\n        excused\n        percentage\n      }\n      cells {\n        eventId\n        personId\n        status\n        note\n      }\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  fragment EventFields on CalendarEvent {\n    id\n    teamId\n    teamName\n    teamColor\n    seriesId\n    detached\n    kind\n    title\n    startsAt\n    endsAt\n    location\n    notes\n    status\n    cancelReason\n    opponent\n    isHome\n    competition\n    canEdit\n  }\n"): (typeof documents)["\n  fragment EventFields on CalendarEvent {\n    id\n    teamId\n    teamName\n    teamColor\n    seriesId\n    detached\n    kind\n    title\n    startsAt\n    endsAt\n    location\n    notes\n    status\n    cancelReason\n    opponent\n    isHome\n    competition\n    canEdit\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  query Calendar($from: DateTime!, $to: DateTime!, $teamId: ID) {\n    events(from: $from, to: $to, teamId: $teamId) {\n      ...EventFields\n    }\n  }\n"): (typeof documents)["\n  query Calendar($from: DateTime!, $to: DateTime!, $teamId: ID) {\n    events(from: $from, to: $to, teamId: $teamId) {\n      ...EventFields\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  query CalendarContext {\n    club {\n      id\n      timezone\n    }\n    manageableTeamIds\n    teams(includeArchived: false) {\n      id\n      name\n      seasonName\n      color\n    }\n  }\n"): (typeof documents)["\n  query CalendarContext {\n    club {\n      id\n      timezone\n    }\n    manageableTeamIds\n    teams(includeArchived: false) {\n      id\n      name\n      seasonName\n      color\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  query Series($teamId: ID) {\n    eventSeries(teamId: $teamId) {\n      id\n      teamId\n      teamName\n      title\n      weekdays\n      startTime\n      durationMinutes\n      location\n      startsOn\n      endsOn\n      upcomingCount\n    }\n  }\n"): (typeof documents)["\n  query Series($teamId: ID) {\n    eventSeries(teamId: $teamId) {\n      id\n      teamId\n      teamName\n      title\n      weekdays\n      startTime\n      durationMinutes\n      location\n      startsOn\n      endsOn\n      upcomingCount\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation CreateSeries($input: SeriesInput!) {\n    createEventSeries(input: $input) {\n      id\n      upcomingCount\n    }\n  }\n"): (typeof documents)["\n  mutation CreateSeries($input: SeriesInput!) {\n    createEventSeries(input: $input) {\n      id\n      upcomingCount\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation UpdateSeries($id: ID!, $input: SeriesInput!, $fromDate: String) {\n    updateEventSeries(id: $id, input: $input, fromDate: $fromDate) {\n      id\n      upcomingCount\n    }\n  }\n"): (typeof documents)["\n  mutation UpdateSeries($id: ID!, $input: SeriesInput!, $fromDate: String) {\n    updateEventSeries(id: $id, input: $input, fromDate: $fromDate) {\n      id\n      upcomingCount\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation EndSeries($id: ID!, $fromDate: String!) {\n    endEventSeries(id: $id, fromDate: $fromDate)\n  }\n"): (typeof documents)["\n  mutation EndSeries($id: ID!, $fromDate: String!) {\n    endEventSeries(id: $id, fromDate: $fromDate)\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation CreateEvent($input: EventInput!) {\n    createEvent(input: $input) {\n      ...EventFields\n    }\n  }\n"): (typeof documents)["\n  mutation CreateEvent($input: EventInput!) {\n    createEvent(input: $input) {\n      ...EventFields\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation UpdateEvent($id: ID!, $input: EventInput!) {\n    updateEvent(id: $id, input: $input) {\n      ...EventFields\n    }\n  }\n"): (typeof documents)["\n  mutation UpdateEvent($id: ID!, $input: EventInput!) {\n    updateEvent(id: $id, input: $input) {\n      ...EventFields\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation SetEventCancelled($id: ID!, $cancelled: Boolean!, $reason: String) {\n    setEventCancelled(id: $id, cancelled: $cancelled, reason: $reason) {\n      ...EventFields\n    }\n  }\n"): (typeof documents)["\n  mutation SetEventCancelled($id: ID!, $cancelled: Boolean!, $reason: String) {\n    setEventCancelled(id: $id, cancelled: $cancelled, reason: $reason) {\n      ...EventFields\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation DeleteEvent($id: ID!) {\n    deleteEvent(id: $id)\n  }\n"): (typeof documents)["\n  mutation DeleteEvent($id: ID!) {\n    deleteEvent(id: $id)\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation CancelRange($input: CancelRangeInput!) {\n    cancelEventsInRange(input: $input)\n  }\n"): (typeof documents)["\n  mutation CancelRange($input: CancelRangeInput!) {\n    cancelEventsInRange(input: $input)\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation CreateFeed($teamId: ID) {\n    createCalendarFeed(teamId: $teamId) {\n      url\n    }\n  }\n"): (typeof documents)["\n  mutation CreateFeed($teamId: ID) {\n    createCalendarFeed(teamId: $teamId) {\n      url\n    }\n  }\n"];
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
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  fragment PersonFields on Person {\n    id\n    firstName\n    lastName\n    birthDate\n    birthPlace\n    taxCode\n    gender\n    categories\n    email\n    phone\n    addressLine\n    city\n    province\n    postalCode\n    notes\n    age\n    isMinor\n    hasAccount\n    archivedAt\n    guardians {\n      id\n      relation\n      person {\n        id\n        firstName\n        lastName\n        email\n        phone\n      }\n    }\n    wards {\n      id\n      relation\n      person {\n        id\n        firstName\n        lastName\n      }\n    }\n    teams {\n      teamId\n      teamName\n      seasonName\n      asPlayer\n      staffRole\n      jerseyNumber\n    }\n  }\n"): (typeof documents)["\n  fragment PersonFields on Person {\n    id\n    firstName\n    lastName\n    birthDate\n    birthPlace\n    taxCode\n    gender\n    categories\n    email\n    phone\n    addressLine\n    city\n    province\n    postalCode\n    notes\n    age\n    isMinor\n    hasAccount\n    archivedAt\n    guardians {\n      id\n      relation\n      person {\n        id\n        firstName\n        lastName\n        email\n        phone\n      }\n    }\n    wards {\n      id\n      relation\n      person {\n        id\n        firstName\n        lastName\n      }\n    }\n    teams {\n      teamId\n      teamName\n      seasonName\n      asPlayer\n      staffRole\n      jerseyNumber\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  query People($filter: PeopleFilter, $limit: Int!, $offset: Int!) {\n    people(filter: $filter, limit: $limit, offset: $offset) {\n      total\n      items {\n        id\n        firstName\n        lastName\n        birthDate\n        age\n        isMinor\n        categories\n        email\n        phone\n        hasAccount\n        archivedAt\n        teams {\n          teamId\n          teamName\n        }\n      }\n    }\n  }\n"): (typeof documents)["\n  query People($filter: PeopleFilter, $limit: Int!, $offset: Int!) {\n    people(filter: $filter, limit: $limit, offset: $offset) {\n      total\n      items {\n        id\n        firstName\n        lastName\n        birthDate\n        age\n        isMinor\n        categories\n        email\n        phone\n        hasAccount\n        archivedAt\n        teams {\n          teamId\n          teamName\n        }\n      }\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  query Person($id: ID!) {\n    person(id: $id) {\n      ...PersonFields\n    }\n  }\n"): (typeof documents)["\n  query Person($id: ID!) {\n    person(id: $id) {\n      ...PersonFields\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation CreatePerson($input: PersonInput!) {\n    createPerson(input: $input) {\n      id\n    }\n  }\n"): (typeof documents)["\n  mutation CreatePerson($input: PersonInput!) {\n    createPerson(input: $input) {\n      id\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation UpdatePerson($id: ID!, $input: PersonInput!) {\n    updatePerson(id: $id, input: $input) {\n      ...PersonFields\n    }\n  }\n"): (typeof documents)["\n  mutation UpdatePerson($id: ID!, $input: PersonInput!) {\n    updatePerson(id: $id, input: $input) {\n      ...PersonFields\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation SetPersonArchived($id: ID!, $archived: Boolean!) {\n    setPersonArchived(id: $id, archived: $archived) {\n      ...PersonFields\n    }\n  }\n"): (typeof documents)["\n  mutation SetPersonArchived($id: ID!, $archived: Boolean!) {\n    setPersonArchived(id: $id, archived: $archived) {\n      ...PersonFields\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation AddGuardian($minorId: ID!, $guardianId: ID!, $relation: GuardianRelation!) {\n    addGuardian(minorId: $minorId, guardianId: $guardianId, relation: $relation) {\n      ...PersonFields\n    }\n  }\n"): (typeof documents)["\n  mutation AddGuardian($minorId: ID!, $guardianId: ID!, $relation: GuardianRelation!) {\n    addGuardian(minorId: $minorId, guardianId: $guardianId, relation: $relation) {\n      ...PersonFields\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation RemoveGuardian($guardianshipId: ID!) {\n    removeGuardian(guardianshipId: $guardianshipId) {\n      ...PersonFields\n    }\n  }\n"): (typeof documents)["\n  mutation RemoveGuardian($guardianshipId: ID!) {\n    removeGuardian(guardianshipId: $guardianshipId) {\n      ...PersonFields\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation InvitePersonAccount($personId: ID!, $email: String!, $role: MembershipRole!) {\n    invitePersonAccount(personId: $personId, email: $email, role: $role) {\n      id\n    }\n  }\n"): (typeof documents)["\n  mutation InvitePersonAccount($personId: ID!, $email: String!, $role: MembershipRole!) {\n    invitePersonAccount(personId: $personId, email: $email, role: $role) {\n      id\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation PreviewPeopleImport($rows: [PersonImportRow!]!) {\n    previewPeopleImport(rows: $rows) {\n      index\n      status\n      errors\n      personId\n    }\n  }\n"): (typeof documents)["\n  mutation PreviewPeopleImport($rows: [PersonImportRow!]!) {\n    previewPeopleImport(rows: $rows) {\n      index\n      status\n      errors\n      personId\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation CommitPeopleImport($rows: [PersonImportRow!]!) {\n    commitPeopleImport(rows: $rows) {\n      created\n      updated\n      guardiansLinked\n      addedToTeams\n    }\n  }\n"): (typeof documents)["\n  mutation CommitPeopleImport($rows: [PersonImportRow!]!) {\n    commitPeopleImport(rows: $rows) {\n      created\n      updated\n      guardiansLinked\n      addedToTeams\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  fragment TeamFields on Team {\n    id\n    seasonId\n    seasonName\n    name\n    category\n    birthYearFrom\n    birthYearTo\n    color\n    playerCount\n    staffCount\n    archivedAt\n  }\n"): (typeof documents)["\n  fragment TeamFields on Team {\n    id\n    seasonId\n    seasonName\n    name\n    category\n    birthYearFrom\n    birthYearTo\n    color\n    playerCount\n    staffCount\n    archivedAt\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  query Teams($seasonId: ID, $includeArchived: Boolean!) {\n    teams(seasonId: $seasonId, includeArchived: $includeArchived) {\n      ...TeamFields\n    }\n    seasons {\n      id\n      name\n      status\n    }\n  }\n"): (typeof documents)["\n  query Teams($seasonId: ID, $includeArchived: Boolean!) {\n    teams(seasonId: $seasonId, includeArchived: $includeArchived) {\n      ...TeamFields\n    }\n    seasons {\n      id\n      name\n      status\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  fragment TeamDetailFields on TeamDetail {\n    id\n    seasonId\n    seasonName\n    name\n    category\n    birthYearFrom\n    birthYearTo\n    color\n    playerCount\n    staffCount\n    archivedAt\n    players {\n      id\n      personId\n      firstName\n      lastName\n      birthDate\n      jerseyNumber\n      position\n      availability\n      email\n      phone\n      guardians {\n        personId\n        name\n        relation\n        email\n        phone\n      }\n    }\n    staff {\n      id\n      personId\n      firstName\n      lastName\n      role\n      email\n      phone\n      hasAccount\n    }\n  }\n"): (typeof documents)["\n  fragment TeamDetailFields on TeamDetail {\n    id\n    seasonId\n    seasonName\n    name\n    category\n    birthYearFrom\n    birthYearTo\n    color\n    playerCount\n    staffCount\n    archivedAt\n    players {\n      id\n      personId\n      firstName\n      lastName\n      birthDate\n      jerseyNumber\n      position\n      availability\n      email\n      phone\n      guardians {\n        personId\n        name\n        relation\n        email\n        phone\n      }\n    }\n    staff {\n      id\n      personId\n      firstName\n      lastName\n      role\n      email\n      phone\n      hasAccount\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  query Team($id: ID!) {\n    team(id: $id) {\n      ...TeamDetailFields\n    }\n  }\n"): (typeof documents)["\n  query Team($id: ID!) {\n    team(id: $id) {\n      ...TeamDetailFields\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation CreateTeam($input: TeamInput!) {\n    createTeam(input: $input) {\n      id\n    }\n  }\n"): (typeof documents)["\n  mutation CreateTeam($input: TeamInput!) {\n    createTeam(input: $input) {\n      id\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation UpdateTeam($id: ID!, $input: TeamInput!) {\n    updateTeam(id: $id, input: $input) {\n      ...TeamDetailFields\n    }\n  }\n"): (typeof documents)["\n  mutation UpdateTeam($id: ID!, $input: TeamInput!) {\n    updateTeam(id: $id, input: $input) {\n      ...TeamDetailFields\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation CopyTeams($input: CopyTeamsInput!) {\n    copyTeams(input: $input) {\n      id\n    }\n  }\n"): (typeof documents)["\n  mutation CopyTeams($input: CopyTeamsInput!) {\n    copyTeams(input: $input) {\n      id\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation AddPlayer($teamId: ID!, $personId: ID!, $input: PlayerInput) {\n    addPlayer(teamId: $teamId, personId: $personId, input: $input) {\n      ...TeamDetailFields\n    }\n  }\n"): (typeof documents)["\n  mutation AddPlayer($teamId: ID!, $personId: ID!, $input: PlayerInput) {\n    addPlayer(teamId: $teamId, personId: $personId, input: $input) {\n      ...TeamDetailFields\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation UpdatePlayer($rosterId: ID!, $input: PlayerInput!) {\n    updatePlayer(rosterId: $rosterId, input: $input) {\n      ...TeamDetailFields\n    }\n  }\n"): (typeof documents)["\n  mutation UpdatePlayer($rosterId: ID!, $input: PlayerInput!) {\n    updatePlayer(rosterId: $rosterId, input: $input) {\n      ...TeamDetailFields\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation RemovePlayer($rosterId: ID!) {\n    removePlayer(rosterId: $rosterId) {\n      ...TeamDetailFields\n    }\n  }\n"): (typeof documents)["\n  mutation RemovePlayer($rosterId: ID!) {\n    removePlayer(rosterId: $rosterId) {\n      ...TeamDetailFields\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation AddStaff($teamId: ID!, $personId: ID!, $role: StaffRole!) {\n    addStaff(teamId: $teamId, personId: $personId, role: $role) {\n      ...TeamDetailFields\n    }\n  }\n"): (typeof documents)["\n  mutation AddStaff($teamId: ID!, $personId: ID!, $role: StaffRole!) {\n    addStaff(teamId: $teamId, personId: $personId, role: $role) {\n      ...TeamDetailFields\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation RemoveStaff($staffId: ID!) {\n    removeStaff(staffId: $staffId) {\n      ...TeamDetailFields\n    }\n  }\n"): (typeof documents)["\n  mutation RemoveStaff($staffId: ID!) {\n    removeStaff(staffId: $staffId) {\n      ...TeamDetailFields\n    }\n  }\n"];

export function graphql(source: string) {
  return (documents as any)[source] ?? {};
}

export type DocumentType<TDocumentNode extends DocumentNode<any, any>> = TDocumentNode extends DocumentNode<  infer TType,  any>  ? TType  : never;