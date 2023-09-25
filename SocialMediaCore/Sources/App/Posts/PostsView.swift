//
//  PostsView.swift
//  SocialNetwork
//
//  Created by MahmoudFares on 18/09/2023.
//

import SwiftUI
import SharedUI

struct PostsView: View {
    @ObservedObject var viewModel: PostsViewModel

    var body: some View {
        NavigationStack {
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
                        .listRowSeparatorTint(.clear)
                    }
                }
            }
            .refreshable {
                viewModel.trigger(.refreshable)
            }
            .listStyle(.plain)
            .showLoader(isLoading: $viewModel.state.isLoading)
            .navigationStyle(
                title: LogoView(),
                navPresentationStyle: .modal,
                trailing: Button(action: {
                    viewModel.coordinator.openSecond()
                }, label: {
                    Image.horizon(NavigationImages.search)
                })
            )
            .onAppear{
                viewModel.coordinator.showTabBar()
            }
            .task {
                viewModel.trigger(.loadPosts)
            }
        }
    }
}
