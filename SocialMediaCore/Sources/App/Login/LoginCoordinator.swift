import Foundation

@MainActor
public final class LoginCoordinator: ObservableObject, Identifiable {
    unowned let parent: MainCoordinator?
    @Published var alertItem: AlertItem?
    @Published var viewModel: LoginViewModel!
    
    public init(parent: MainCoordinator?) {
        self.parent = parent
        viewModel = LoginViewModel(coordinator: self)
    }
    
    func presentTabBar() {
        parent?.showLogin = false
    }
}
