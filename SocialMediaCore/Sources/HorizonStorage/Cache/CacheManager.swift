import Dependencies
import Foundation

public final class CacheManager: Sendable {
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    private lazy var userDefaultsStorage = UserDefaultsStorage()
    private lazy var encryptedStorage = EncryptedStorage()

    public init(
        decoder: JSONDecoder = .init(),
        encoder: JSONEncoder = .init()
    ) {
        self.decoder = decoder
        self.encoder = encoder
    }

    public func fetch<T: Codable>(_: T.Type, for key: StorageKey, from suitableStorage: SupportedStorage) throws -> T {
        try getSuitableStorage(from: suitableStorage).fetchValue(for: key)
    }

    public func save<T: Codable>(_ value: T, for key: StorageKey, from suitableStorage: SupportedStorage) throws {
        try getSuitableStorage(from: suitableStorage).save(value: value, for: key)
    }

    public func remove<T: Codable>(type: T.Type, for key: StorageKey, from suitableStorage: SupportedStorage) throws {
        try getSuitableStorage(from: suitableStorage).remove(type: type, for: key)
    }
}

private extension CacheManager {
    func getSuitableStorage(from choice: SupportedStorage) -> Storage {
        switch choice {
        case .userDefaults:
            return userDefaultsStorage
        case .keychain:
            return encryptedStorage
        }
    }
}

public extension DependencyValues {
    var cacheManager: CacheManager {
        get { self[CacheManager.self] }
        set { self[CacheManager.self] = newValue }
    }
}

extension CacheManager: DependencyKey {
    public static var liveValue: CacheManager = .init()
    public static var testValue: CacheManager {
        .init()
    }
}
