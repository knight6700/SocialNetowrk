//
//  LoginCoordinatorView.swift
//
//
//  Created by MahmoudFares on 22/09/2023.
//

import SwiftUI

public struct LoginCoordinatorView: View {
    public init(coordinator: LoginCoordinator) {
        self.coordinator = coordinator
    }

    @ObservedObject var coordinator: LoginCoordinator
    public var body: some View {
        LoginView(viewModel: coordinator.viewModel)
            .alert(item: $coordinator.alertItem) {
                Alert(title: $0.title, message: $0.message, dismissButton: $0.dismissButton)
            }

    }
}
