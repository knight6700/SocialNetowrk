//
//  SearchCoordinatorView.swift
//  SocialNetwork
//
//  Created by MahmoudFares on 19/09/2023.
//

import SwiftUI

struct SearchCoordinatorView: View {
    
    // MARK: Stored Properties
    
    @ObservedObject var coordinator: SearchCoordinator
    
    // MARK: Views
    
    var body: some View {
        SearchView(viewModel: coordinator.viewModel)
    }
}
