//
//  TabBarCoordinator.swift
//  SocialNetwork
//
//  Created by MahmoudFares on 19/09/2023.
//

import SharedUI
import SwiftUI

@MainActor
public class TabBarCoordinator: ObservableObject {
    // MARK: Stored Properties

    @Published var tab = TabBarScreens.feeds

    @Published var postsCoordinator: PostsCoordinator!
    @Published var searchCoordinator: SearchCoordinator!
    @Published var isTabBarhiden: Bool = false
    public init() {
        postsCoordinator = .init(parent: self)
        searchCoordinator = .init(parent: self, isTabbarHidden: true)
    }
}
