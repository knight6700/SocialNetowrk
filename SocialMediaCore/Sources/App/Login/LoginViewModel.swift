import Dependencies
import Foundation
import HorizonStorage
import NetworkHerizon
import SharedModels
import SharedUI

public class LoginViewModel: ObservableObject {
    struct State {
        var usernameFieldState: TextFildViewState = .init(
            text: "",
            subtitle: "Enter User name",
            keyBoardType: .default,
            format: { $0 },
            validate: Validator.validateUsername(_:),
            field: .username,
            identifier: "usernameTextField"
        )

        var passwordFieldState: TextFildViewState = .init(
            text: "",
            subtitle: "Enter Password",
            keyBoardType: .default,
            format: { $0 },
            validate: Validator.validatePassword(_:),
            isSecure: true,
            field: .password,
            identifier: "passwordTextField"
        )

        var loginButtonDisable: Bool {
            !(
                usernameFieldState.isValid
                    && passwordFieldState.isValid
            )
        }

        var isLoading: Bool = false
    }

    enum Action {
        case onAppear
        case loginButtonTapped
    }

    unowned let coordinator: LoginCoordinator

    init(coordinator: LoginCoordinator) {
        self.coordinator = coordinator
    }

    @Dependency(\.loginClient) var loginApi
    @Dependency(\.userDefaults) var userDefaults

    @Published var state: State = .init()

    func trigger(_ action: Action) {
        switch action {
        case .onAppear:
            Task { @MainActor in
                onAppear()
            }
        case .loginButtonTapped:
            login()
        }
    }

    func login() {
        state.isLoading = true
        Task { @MainActor in
            do {
                let loginResponse = try await loginApi.login(
                    .init(
                        username: state.usernameFieldState.text,
                        password: state.passwordFieldState.text
                    )
                )
                await userDefaults.setUser(
                    .init(
                        id: loginResponse.id,
                        username: loginResponse.username,
                        email: loginResponse.email,
                        firstName: loginResponse.firstName,
                        lastName: loginResponse.lastName,
                        image: loginResponse.image,
                        token: loginResponse.token
                    )
                )
                coordinator.presentTabBar()
            } catch {
                // Handle the error here
                let customError = error as? NetworkError
                let message = customError?.customDescription ?? error.localizedDescription
                showAlert(error: .custom(message: message))
            }
            state.isLoading = false
        }
    }

    @MainActor
    func showAlert(error: CustomError) {
        coordinator.alertItem = error.showUrlAlert()
    }
    
    @MainActor
    func onAppear() {
        guard userDefaults.user()?.token != nil else {
            return
        }
        coordinator.presentTabBar()
    }
}
