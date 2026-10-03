import { graphql } from '@/gql';

export const AttendanceRegisterDoc = graphql(`
  query AttendanceRegister($teamId: ID!, $from: DateTime!, $to: DateTime!, $kind: EventKind) {
    attendanceRegister(teamId: $teamId, from: $from, to: $to, kind: $kind) {
      events {
        id
        startsAt
        kind
        title
        opponent
        rollCallDone
      }
      players {
        personId
        firstName
        lastName
        jerseyNumber
        recorded
        attended
        excused
        percentage
      }
      cells {
        eventId
        personId
        status
        note
      }
    }
  }
`);
