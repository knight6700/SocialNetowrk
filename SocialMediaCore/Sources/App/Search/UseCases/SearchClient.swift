import Dependencies
import NetworkHerizon
import SharedModels

struct SearchClient {
    var searchPosts: @Sendable (_ parameters: PostsParameters) async throws -> PostsDTO

}

extension SearchClient: DependencyKey {
    static var liveValue: Self {
        .init(searchPosts: {
            try await ApiClient.load(
                PostsDTO.self,
                with: .init(
                    endpoint: "posts/search",
                    body: $0,
                    method: .get
                )
            )
        })
    }
}

extension SearchClient: TestDependencyKey {
    static var testValue: Self {
        .init(searchPosts: { _ in
            .mock
        })
    }
    
    static var previewValue: Self {
        .testValue
    }
}


extension DependencyValues {
    var searchClient: SearchClient {
    get { self[SearchClient.self] }
    set { self[SearchClient.self] = newValue }
  }
}
