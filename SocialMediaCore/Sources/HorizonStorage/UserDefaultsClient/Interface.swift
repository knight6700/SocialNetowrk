import Dependencies
import Foundation

public extension DependencyValues {
    var userDefaults: UserDefaultsClient {
        get { self[UserDefaultsClient.self] }
        set { self[UserDefaultsClient.self] = newValue }
    }
}

public struct UserDefaultsClient {
    public var user:  () -> User?
    public var setUser:  (User?) async -> Void
}
