//
//  PostsCoordinator.swift
//  SocialNetwork
//
//  Created by MahmoudFares on 19/09/2023.
//

import Foundation
import SharedUI
import SwiftUI

@MainActor
public final class PostsCoordinator: ObservableObject, Identifiable {
    private unowned let parent: TabBarCoordinator?
    @Published var alertItem: AlertItem?
    @Published var viewModel: PostsViewModel!
    @Published var searchCoordinator: SearchCoordinator?

    public init(parent: TabBarCoordinator?) {
        self.parent = parent
        viewModel = PostsViewModel(coordinator: self)
    }

    public func openSecond() {
        parent?.isTabBarhiden = true
        searchCoordinator = SearchCoordinator(
            parent: parent,
            isTabbarHidden: true
        )
    }

    public func showTabBar() {
        parent?.isTabBarhiden = false
    }
}
