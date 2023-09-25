import Dependencies
import SharedModels
import NetworkHerizon

struct LoginClient {
    var login: @Sendable (_ parameters: LoginParameters) async throws -> UserDTO
}

extension LoginClient: DependencyKey {
    static var liveValue: Self {
        .init(
            login: { parameters in
                try await ApiClient.load(
                    UserDTO.self,
                    with: .init(
                        endpoint: "auth/login",
                        body: parameters,
                        method: .post
                    )
                )
            }
        )
    }
}

extension LoginClient: TestDependencyKey {
    static var testValue: Self {
        .init(
            login: { _ in
                .mock
            }
        )
    }

    static var previewValue: Self {
        .testValue
    }
}

extension DependencyValues {
    var loginClient: LoginClient {
        get { self[LoginClient.self] }
        set { self[LoginClient.self] = newValue }
    }
}
