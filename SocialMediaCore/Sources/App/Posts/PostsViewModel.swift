//
//  PostsViewModel.swift
//  SocialNetwork
//
//  Created by MahmoudFares on 19/09/2023.
//

import Dependencies
import Foundation
import SharedModels

class PostsViewModel: ObservableObject {
    enum Action {
        case loadPosts
        case rowOnAppear(id: Int)
        case loadMore
        case refreshable
    }

    struct State: Equatable {
        var parameters = PostsParameters(skip: 0)
        var posts: [FBPostModel] = []
        var canLoadMore: Bool = false
        var isLoading: Bool = true
    }

    unowned let coordinator: PostsCoordinator
    @Dependency(\.postsRepository) var postRepository
    @Published var state: State = .init()
    
    init(coordinator: PostsCoordinator) {
        self.coordinator = coordinator
    }

    func trigger(_ action: Action) {
        switch action {
        case .loadPosts:
            state.isLoading = true
            loadPosts()
        case .loadMore:
            loadMore()
        case let .rowOnAppear(id: id):
            guard id == state.posts.last?.id && state.canLoadMore else {
                return
            }
            loadMore()
        case .refreshable:
            refreshable()
        }
    }

    func loadPosts() {
        Task { @MainActor in
            do {
                let posts = try await postRepository.fetchPosts(state.parameters)
                state.canLoadMore = posts.totalCount > state.posts.count
                if state.parameters.skip == 0 {
                    state.posts.removeAll()
                }
                state.posts.append(contentsOf: posts.posts)
            } catch {
                // Handle the error here
            }
            state.isLoading = false
        }
    }

    private func loadMore() {
        state.parameters.skip += 10
        loadPosts()
    }
    
    func refreshable() {
        state.parameters.skip = 0
        loadPosts()
    }

    func isLastCell(id: Int) -> Bool {
        state.posts.last?.id == id && state.canLoadMore
    }
}
