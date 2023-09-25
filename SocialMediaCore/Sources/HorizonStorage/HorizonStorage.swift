import Foundation

@propertyWrapper
public struct HorizonStorage<T: Codable> {
    private let cache: CacheManager
    private let type: T.Type
    private let value: T?
    private let key: StorageKey
    private let suitableStorage: SupportedStorage

    public init(
        cache: CacheManager = CacheManager(),
        type: T.Type,
        value: T?,
        key: StorageKey,
        suitableStorage: SupportedStorage
    ) {
        self.cache = cache
        self.type = type
        self.value = value
        self.key = key
        self.suitableStorage = suitableStorage
    }

    public var wrappedValue: T? {
        get {
            do {
                return try cache.fetch(type, for: key, from: suitableStorage)
            } catch {
                debugPrint(error)
                return nil
            }
        } set {
            do {
                newValue != nil
                    ? try cache.save(newValue, for: key, from: suitableStorage)
                    : try cache.remove(type: type, for: key, from: suitableStorage)
            } catch {
                debugPrint(error)
            }
        }
    }
}
