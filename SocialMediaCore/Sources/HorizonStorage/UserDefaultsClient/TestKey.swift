import Dependencies
import Foundation
import XCTestDynamicOverlay

extension UserDefaultsClient: TestDependencyKey {
    public static let previewValue = Self.noop

    public static let testValue = Self(
        user: unimplemented("\(Self.self).dataForKey", placeholder: nil),
        setUser: unimplemented("\(Self.self).setData")
    )
}

public extension UserDefaultsClient {
    static let noop = Self(
        user: { nil },
        setUser: { _ in }
    )
}
