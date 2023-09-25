//
//  SearchCoordinator.swift
//  SocialNetwork
//
//  Created by MahmoudFares on 19/09/2023.
//

import Foundation
import SwiftUI

@MainActor
public final class SearchCoordinator: ObservableObject, Identifiable {
    public var isTabbarHidden: Bool
    @Published var viewModel: SearchViewModel!

    private unowned let parent: TabBarCoordinator?

    public  init(parent: TabBarCoordinator?, isTabbarHidden: Bool) {
        self.parent = parent
        self.isTabbarHidden = isTabbarHidden
        viewModel = SearchViewModel(coordinator: self)
    }
}
