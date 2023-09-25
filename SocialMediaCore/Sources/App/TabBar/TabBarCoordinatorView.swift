//
//  TabBarCoordinatorView.swift
//  SocialNetwork
//
//  Created by MahmoudFares on 19/09/2023.
//

import SwiftUI
import SharedUI

public struct TabBarCoordinatorView: View {
    @ObservedObject var coordinator: TabBarCoordinator
    public init(coordinator: TabBarCoordinator) {
        self.coordinator = coordinator
    }
    public var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Spacer()
                ZStack {
                    switch coordinator.tab {
                    case .feeds:
                        PostsCoordinatorView(coordinator: coordinator.postsCoordinator)
                    case .shop:
                        Text("shop")
                    case .discount:
                        Text("discount")
                    case .gallery:
                        Text("gallery")
                    case .profile:
                        Settings()
                    }
                }
                Spacer()
                if !coordinator.isTabBarhiden {
                    CustomTabView(selectedTab: $coordinator.tab)
                }
            }
            .padding(.top)
            .ignoresSafeArea()
        }
    }
}

struct MainCoordinateView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarCoordinatorView(coordinator: .init())
    }
}
