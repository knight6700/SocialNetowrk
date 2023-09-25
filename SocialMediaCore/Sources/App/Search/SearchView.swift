//
//  SearchView.swift
//  SocialNetwork
//
//  Created by MahmoudFares on 19/09/2023.
//

import SharedUI
import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel

    var body: some View {
        List {
            ForEach(viewModel.state.posts, id: \.id) { model in
                FBPost(model: model)
                    .listRowInsets(.init())
                    .listRowSeparator(.hidden)
                    .listRowSeparatorTint(.clear)
                    .listRowBackground(Color.clear)
                    .onAppear {
                        viewModel.trigger(.rowOnAppear(id: model.id))
                    }
                if viewModel.isLastCell(id: model.id) {
                    HStack {
                        Spacer()
                        ProgressView()
                            .tint(.horizon(.blackColor))
                        Spacer()
                    }
                    .listRowInsets(.init())
                    .listRowSeparator(.hidden)
                    .listRowSeparatorTint(.clear)
                    .listRowBackground(Color.clear)
                }
            }
        }
        .showLoader(isLoading: $viewModel.state.isLoading)
        .listStyle(.plain)
        .navigationStyle(
            title: SearchBarView(viewModel: viewModel.state.searchBarViewModel)
            ,navPresentationStyle: .navigation
        )
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: .init(coordinator: .init(parent: .init(), isTabbarHidden: true)))
    }
}
