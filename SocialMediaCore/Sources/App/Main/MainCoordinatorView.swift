//
//  File.swift
//
//
//  Created by MahmoudFares on 22/09/2023.
//

import SwiftUI

public struct MainCoordinatorView: View {
    @ObservedObject var coordinator: MainCoordinator
    public init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
    }

    public var body: some View {
        if coordinator.showLogin {
            LoginCoordinatorView(coordinator: coordinator.loginCoordinator)
        } else {
            TabBarCoordinatorView(coordinator: coordinator.tabBarCoordinator)
        }
    }
}
