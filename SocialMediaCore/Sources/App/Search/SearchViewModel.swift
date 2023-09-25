//
//  SearchViewModel.swift
//  SocialNetwork
//
//  Created by MahmoudFares on 19/09/2023.
//

import Combine
import Foundation
import SharedModels
import SharedUI
import Dependencies

class SearchViewModel: ObservableObject {
    struct State {
        var searchBarViewModel: SearchBarViewModel = .init()
        var parameters = PostsParameters(skip: 0)
        var posts: [FBPostModel] = []
        var canLoadMore: Bool = false
        var isLoading: Bool = false
    }
    
    enum Action {
        case loadPosts
        case rowOnAppear(id: Int)
        case loadMore
        case search
    }
    
    @Published var state: State = .init()
    @Dependency(\.searchClient) var searchApi
    @Dependency(\.postsDomain) var postsDomain

    
    private var cancellable = Set<AnyCancellable>()

    unowned let coordinator: SearchCoordinator

    init(coordinator: SearchCoordinator) {
        self.coordinator = coordinator
        intialzie()
    }
    
    func trigger(_ action: Action) {
        switch action {
        case .loadPosts:
            state.isLoading = true
            loadPosts()
        case .loadMore:
            loadMore()
        case let .rowOnAppear(id: id):
            guard isLastCell(id: id) else {
                return
            }
            loadMore()
        case .search:
            search()
        }
    }
    
    func intialzie() {
        state.searchBarViewModel.searchPublisher.sink { [weak self] text in
            guard let self else {
                return
            }
            state.parameters.query = text
            trigger(.search)
        }
        .store(in: &cancellable)
    }

    func loadPosts() {
        Task { @MainActor in
            do {
                let posts = try await searchApi.searchPosts(state.parameters)
                state.canLoadMore = posts.total == state.posts.count
                if state.parameters.skip == 0 {
                    state.posts.removeAll()
                }
                let toDomain = postsDomain.toDomainModel(posts)
                state.posts.append(contentsOf: toDomain)
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

    func search() {
        state.parameters.skip = 0
        loadPosts()
    }

    func isLastCell(id: Int) -> Bool {
        state.posts.last?.id == id && state.canLoadMore
    }
}
