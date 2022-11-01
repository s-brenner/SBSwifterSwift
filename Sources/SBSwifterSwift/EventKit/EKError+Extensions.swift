import EventKit

extension EKError.Code: CustomStringConvertible {
    
    public var title: String {
        switch self {
        case .eventNotMutable:
            return "Event Not Mutable"
        case .noCalendar:
            return "No Calendar"
        case .noStartDate:
            return "No Start Date"
        case .noEndDate:
            return "No End Date"
        case .datesInverted:
            return "Dates Inverted"
        case .internalFailure:
            return "Internal Failure"
        case .calendarReadOnly:
            return "Calendar Read Only"
        case .durationGreaterThanRecurrence:
            return "Duration Greater Than Recurrence"
        case .alarmGreaterThanRecurrence:
            return "Alarm Greater Than Recurrence"
        case .startDateTooFarInFuture:
            return "Start Date Too Far In Future"
        case .startDateCollidesWithOtherOccurrence:
            return "Start Date Collides With Other Occurrence"
        case .objectBelongsToDifferentStore:
            return "Object Belongs To Different Store"
        case .invitesCannotBeMoved:
            return "Invites Cannot Be Moved"
        case .invalidSpan:
            return "Invalid Span"
        case .calendarHasNoSource:
            return "Calendar Has No Source"
        case .calendarSourceCannotBeModified:
            return "Calendar Source Cannot Be Modified"
        case .calendarIsImmutable:
            return "Calendar Is Immutable"
        case .sourceDoesNotAllowCalendarAddDelete:
            return "Source Does Not Allow Calendar Add/Delete"
        case .recurringReminderRequiresDueDate:
            return "Recurring Reminder Requires Due Date"
        case .structuredLocationsNotSupported:
            return "Structured Locations Not Supported"
        case .reminderLocationsNotSupported:
            return "Reminder Locations Not Supported"
        case .alarmProximityNotSupported:
            return "Alarm Proximity Not Supported"
        case .calendarDoesNotAllowEvents:
            return "Calendar Does Not Allow Events"
        case .calendarDoesNotAllowReminders:
            return "Calendar Does Not Allow Reminders"
        case .sourceDoesNotAllowReminders:
            return "Source Does Not Allow Reminders"
        case .sourceDoesNotAllowEvents:
            return "Source DOes Not Allow Events"
        case .priorityIsInvalid:
            return "Priority Is Invalid"
        case .invalidEntityType:
            return "Invalid Entity Type"
        case .procedureAlarmsNotMutable:
            return "Procedure Alarms Not Mutable"
        case .eventStoreNotAuthorized:
            return "Event Store Not Authorized"
        case .osNotSupported:
            return "OS Not Supported"
        case .invalidInviteReplyCalendar:
            return "Invalid Invite Reply Calendar"
        case .notificationsCollectionFlagNotSet:
            return "Notifications Collection Flag Not Set"
        case .sourceMismatch:
            return "Source Mismatch"
        case .notificationCollectionMismatch:
            return "Notification Collection Mismatch"
        case .notificationSavedWithoutCollection:
            return "Notification Saved Without Collection"
        case .last:
            return "Last"
        default:
            return "Unknown error code: \(rawValue)."
        }
    }
    
    public var description: String {
        switch self {
        case .eventNotMutable:
            return "The event isn't mutable and you can’t save or delete it."
        case .noCalendar:
            return "The event isn't associated with a calendar."
        case .noStartDate:
            return "The event has no start date set."
        case .noEndDate:
            return "The event has no end date set."
        case .datesInverted:
            return "The event’s end date occurs before its start date."
        case .internalFailure:
            return "An internal error occurred."
        case .calendarReadOnly:
            return "The calendar is read-only and you can’t add events to it."
        case .durationGreaterThanRecurrence:
            return "The duration of an event is greater than its recurrence interval."
        case .alarmGreaterThanRecurrence:
            return "The alarm interval is greater than the recurrence interval."
        case .startDateTooFarInFuture:
            return "The start date is further into the future than the calendar can display."
        case .startDateCollidesWithOtherOccurrence:
            return "The event’s start date collides with another occurrence of the event."
        case .objectBelongsToDifferentStore:
            return "The object belongs to a different calendar store."
        case .invitesCannotBeMoved:
            return "You can’t move the event because it’s an invitation."
        case .invalidSpan:
            return "The system encountered an invalid span during a save or deletion."
        case .calendarHasNoSource:
            return "You can’t save the calendar without setting a source first."
        case .calendarSourceCannotBeModified:
            return "You can’t move the calendar to another source."
        case .calendarIsImmutable:
            return "The calendar is immutable and you can’t modify or delete it."
        case .sourceDoesNotAllowCalendarAddDelete:
            return "The source doesn’t allow you to add or delete calendars."
        case .recurringReminderRequiresDueDate:
            return "The recurring reminder requires a due date."
        case .structuredLocationsNotSupported:
            return "The source to which this calendar belongs doesn't support structured locations."
        case .reminderLocationsNotSupported:
            return "The source doesn't support locations on reminders."
        case .alarmProximityNotSupported:
            return "The source doesn't allow geofences on alarms."
        case .calendarDoesNotAllowEvents:
            return "The calendar doesn’t allow you to add events."
        case .calendarDoesNotAllowReminders:
            return "The calendar doesn’t allow you to add reminders."
        case .sourceDoesNotAllowReminders:
            return "The source doesn't allow calendars supporting reminder entity types."
        case .sourceDoesNotAllowEvents:
            return "The source doesn't allow calendars supporting event entity types."
        case .priorityIsInvalid:
            return "The priority number for the reminder is invalid."
        case .invalidEntityType:
            return "The entity type is invalid."
        case .procedureAlarmsNotMutable:
            return "You can’t create or modify procedure alarms."
        case .eventStoreNotAuthorized:
            return "The user hasn't authorized your app to access events or reminders."
        case .osNotSupported:
            return "The action isn't supported on the current operating system."
        case .invalidInviteReplyCalendar:
            return "The calendar is invalid or nil."
        case .notificationsCollectionFlagNotSet:
            return "The notification collection doesn't have the notifications collection flag."
        case .sourceMismatch:
            return "The object's source doesn't match its container's source."
        case .notificationCollectionMismatch:
            return "The notification collection that contains this notification doesn’t match the collection the system is trying to save."
        case .notificationSavedWithoutCollection:
            return "The notification can’t save because you haven’t added it to a notification collection and saved the collection first."
        case .last:
            return "This error is for internal use."
        default:
            return "Unknown error code: \(rawValue)."
        }
    }
}
