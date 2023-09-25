import Foundation

final class UserDefaultsStorage: @unchecked Sendable {
    let defaults: UserDefaults = .standard
}

extension UserDefaultsStorage: WritableStorage {
    func save<T>(value: T, for key: StorageKey) throws where T: Codable {
        defaults.set(value.encode, forKey: key.key)
    }

    func remove<T>(type _: T.Type, for key: StorageKey) throws where T: Codable {
        defaults.removeObject(forKey: key.key)
    }
}

extension UserDefaultsStorage: ReadableStorage {
    func fetchValue<T>(for key: StorageKey) throws -> T where T: Codable {
        guard let value = defaults.data(forKey: key.key)?.decode(T.self) else { throw StorageError.notFound }
        return value
    }
}
