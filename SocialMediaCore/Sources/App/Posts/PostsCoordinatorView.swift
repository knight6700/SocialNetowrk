//
//  PostsCoordinatorView.swift
//  SocialNetwork
//
//  Created by MahmoudFares on 19/09/2023.
//

import SwiftUI

struct PostsCoordinatorView: View {
    
    // MARK: Stored Properties
    
    @ObservedObject var coordinator: PostsCoordinator
    
    // MARK: Views
    
    var body: some View {
        NavigationStack {
            PostsView(viewModel: coordinator.viewModel)
                .navigation(item: $coordinator.searchCoordinator) { coordinator in
                    SearchCoordinatorView(coordinator: coordinator)
                }
        }
        .alert(item: $coordinator.alertItem) {
            Alert(title: $0.title, message: $0.message, dismissButton: $0.dismissButton)
        }
        
    }
}
