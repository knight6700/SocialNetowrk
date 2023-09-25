import Foundation

public enum StorageKey: CaseIterable {
    case user
    case token
    case eventsLaunched
    case filterEvents

    var key: String {
        switch self {
        case .user:
            return "user_key"
        case .token:
            return "token"
        case .eventsLaunched:
            return "events_launched"
        case .filterEvents:
            return "filter_events"
        }
    }
}
