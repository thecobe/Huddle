import { graphql } from '@/gql';

export const PersonFields = graphql(`
  fragment PersonFields on Person {
    id
    firstName
    lastName
    birthDate
    birthPlace
    taxCode
    gender
    categories
    email
    phone
    addressLine
    city
    province
    postalCode
    notes
    age
    isMinor
    hasAccount
    archivedAt
    guardians {
      id
      relation
      person {
        id
        firstName
        lastName
        email
        phone
      }
    }
    wards {
      id
      relation
      person {
        id
        firstName
        lastName
      }
    }
    teams {
      teamId
      teamName
      seasonName
      asPlayer
      staffRole
      jerseyNumber
    }
  }
`);

export const PeopleDoc = graphql(`
  query People($filter: PeopleFilter, $limit: Int!, $offset: Int!) {
    people(filter: $filter, limit: $limit, offset: $offset) {
      total
      items {
        id
        firstName
        lastName
        birthDate
        age
        isMinor
        categories
        email
        phone
        hasAccount
        archivedAt
        teams {
          teamId
          teamName
        }
      }
    }
  }
`);

export const PersonDoc = graphql(`
  query Person($id: ID!) {
    person(id: $id) {
      ...PersonFields
    }
  }
`);

export const CreatePersonDoc = graphql(`
  mutation CreatePerson($input: PersonInput!) {
    createPerson(input: $input) {
      id
    }
  }
`);

export const UpdatePersonDoc = graphql(`
  mutation UpdatePerson($id: ID!, $input: PersonInput!) {
    updatePerson(id: $id, input: $input) {
      ...PersonFields
    }
  }
`);

export const SetPersonArchivedDoc = graphql(`
  mutation SetPersonArchived($id: ID!, $archived: Boolean!) {
    setPersonArchived(id: $id, archived: $archived) {
      ...PersonFields
    }
  }
`);

export const AddGuardianDoc = graphql(`
  mutation AddGuardian($minorId: ID!, $guardianId: ID!, $relation: GuardianRelation!) {
    addGuardian(minorId: $minorId, guardianId: $guardianId, relation: $relation) {
      ...PersonFields
    }
  }
`);

export const RemoveGuardianDoc = graphql(`
  mutation RemoveGuardian($guardianshipId: ID!) {
    removeGuardian(guardianshipId: $guardianshipId) {
      ...PersonFields
    }
  }
`);

export const InvitePersonAccountDoc = graphql(`
  mutation InvitePersonAccount($personId: ID!, $email: String!, $role: MembershipRole!) {
    invitePersonAccount(personId: $personId, email: $email, role: $role) {
      id
    }
  }
`);

export const PreviewPeopleImportDoc = graphql(`
  mutation PreviewPeopleImport($rows: [PersonImportRow!]!) {
    previewPeopleImport(rows: $rows) {
      index
      status
      errors
      personId
    }
  }
`);

export const CommitPeopleImportDoc = graphql(`
  mutation CommitPeopleImport($rows: [PersonImportRow!]!) {
    commitPeopleImport(rows: $rows) {
      created
      updated
      guardiansLinked
      addedToTeams
    }
  }
`);

export const TeamFields = graphql(`
  fragment TeamFields on Team {
    id
    seasonId
    seasonName
    name
    category
    birthYearFrom
    birthYearTo
    color
    playerCount
    staffCount
    archivedAt
  }
`);

export const TeamsDoc = graphql(`
  query Teams($seasonId: ID, $includeArchived: Boolean!) {
    teams(seasonId: $seasonId, includeArchived: $includeArchived) {
      ...TeamFields
    }
    seasons {
      id
      name
      status
    }
  }
`);

export const TeamDetailFields = graphql(`
  fragment TeamDetailFields on TeamDetail {
    id
    seasonId
    seasonName
    name
    category
    birthYearFrom
    birthYearTo
    color
    playerCount
    staffCount
    archivedAt
    players {
      id
      personId
      firstName
      lastName
      birthDate
      jerseyNumber
      position
      availability
      email
      phone
      guardians {
        personId
        name
        relation
        email
        phone
      }
    }
    staff {
      id
      personId
      firstName
      lastName
      role
      email
      phone
      hasAccount
    }
  }
`);

export const TeamDoc = graphql(`
  query Team($id: ID!) {
    team(id: $id) {
      ...TeamDetailFields
    }
  }
`);

export const CreateTeamDoc = graphql(`
  mutation CreateTeam($input: TeamInput!) {
    createTeam(input: $input) {
      id
    }
  }
`);

export const UpdateTeamDoc = graphql(`
  mutation UpdateTeam($id: ID!, $input: TeamInput!) {
    updateTeam(id: $id, input: $input) {
      ...TeamDetailFields
    }
  }
`);

export const CopyTeamsDoc = graphql(`
  mutation CopyTeams($input: CopyTeamsInput!) {
    copyTeams(input: $input) {
      id
    }
  }
`);

export const AddPlayerDoc = graphql(`
  mutation AddPlayer($teamId: ID!, $personId: ID!, $input: PlayerInput) {
    addPlayer(teamId: $teamId, personId: $personId, input: $input) {
      ...TeamDetailFields
    }
  }
`);

export const UpdatePlayerDoc = graphql(`
  mutation UpdatePlayer($rosterId: ID!, $input: PlayerInput!) {
    updatePlayer(rosterId: $rosterId, input: $input) {
      ...TeamDetailFields
    }
  }
`);

export const RemovePlayerDoc = graphql(`
  mutation RemovePlayer($rosterId: ID!) {
    removePlayer(rosterId: $rosterId) {
      ...TeamDetailFields
    }
  }
`);

export const AddStaffDoc = graphql(`
  mutation AddStaff($teamId: ID!, $personId: ID!, $role: StaffRole!) {
    addStaff(teamId: $teamId, personId: $personId, role: $role) {
      ...TeamDetailFields
    }
  }
`);

export const RemoveStaffDoc = graphql(`
  mutation RemoveStaff($staffId: ID!) {
    removeStaff(staffId: $staffId) {
      ...TeamDetailFields
    }
  }
`);
