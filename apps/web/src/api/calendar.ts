import { graphql } from '@/gql';

export const EventFields = graphql(`
  fragment EventFields on CalendarEvent {
    id
    teamId
    teamName
    teamColor
    seriesId
    detached
    kind
    title
    startsAt
    endsAt
    location
    notes
    status
    cancelReason
    opponent
    isHome
    competition
    canEdit
  }
`);

export const CalendarDoc = graphql(`
  query Calendar($from: DateTime!, $to: DateTime!, $teamId: ID) {
    events(from: $from, to: $to, teamId: $teamId) {
      ...EventFields
    }
  }
`);

export const CalendarContextDoc = graphql(`
  query CalendarContext {
    club {
      id
      timezone
    }
    manageableTeamIds
    teams(includeArchived: false) {
      id
      name
      seasonName
      color
    }
  }
`);

export const SeriesDoc = graphql(`
  query Series($teamId: ID) {
    eventSeries(teamId: $teamId) {
      id
      teamId
      teamName
      title
      weekdays
      startTime
      durationMinutes
      location
      startsOn
      endsOn
      upcomingCount
    }
  }
`);

export const CreateSeriesDoc = graphql(`
  mutation CreateSeries($input: SeriesInput!) {
    createEventSeries(input: $input) {
      id
      upcomingCount
    }
  }
`);

export const UpdateSeriesDoc = graphql(`
  mutation UpdateSeries($id: ID!, $input: SeriesInput!, $fromDate: String) {
    updateEventSeries(id: $id, input: $input, fromDate: $fromDate) {
      id
      upcomingCount
    }
  }
`);

export const EndSeriesDoc = graphql(`
  mutation EndSeries($id: ID!, $fromDate: String!) {
    endEventSeries(id: $id, fromDate: $fromDate)
  }
`);

export const CreateEventDoc = graphql(`
  mutation CreateEvent($input: EventInput!) {
    createEvent(input: $input) {
      ...EventFields
    }
  }
`);

export const UpdateEventDoc = graphql(`
  mutation UpdateEvent($id: ID!, $input: EventInput!) {
    updateEvent(id: $id, input: $input) {
      ...EventFields
    }
  }
`);

export const SetEventCancelledDoc = graphql(`
  mutation SetEventCancelled($id: ID!, $cancelled: Boolean!, $reason: String) {
    setEventCancelled(id: $id, cancelled: $cancelled, reason: $reason) {
      ...EventFields
    }
  }
`);

export const DeleteEventDoc = graphql(`
  mutation DeleteEvent($id: ID!) {
    deleteEvent(id: $id)
  }
`);

export const CancelRangeDoc = graphql(`
  mutation CancelRange($input: CancelRangeInput!) {
    cancelEventsInRange(input: $input)
  }
`);

export const CreateFeedDoc = graphql(`
  mutation CreateFeed($teamId: ID) {
    createCalendarFeed(teamId: $teamId) {
      url
    }
  }
`);
