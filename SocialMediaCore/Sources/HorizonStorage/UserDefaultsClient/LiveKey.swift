import Dependencies
import Foundation

extension UserDefaultsClient: DependencyKey {
    public static let liveValue: Self = {
        let defaults = { UserDefaults(suiteName: "group.socialNetwork") ?? UserDefaults() }
        @Sendable func decodeUser(defaults: () -> UserDefaults) -> User? {
            defaults().data(forKey: "user")?.decode(User.self)
        }
        @Sendable func encodeUser(value: User?) -> Data? {
            try? JSONEncoder().encode(value)
        }

        return Self(
            user: {
                decodeUser(defaults: defaults)
            },
            setUser: {
                let value = try? JSONEncoder().encode($0)
                return defaults().set(value, forKey: "user")

            }
        )
    }()
}
