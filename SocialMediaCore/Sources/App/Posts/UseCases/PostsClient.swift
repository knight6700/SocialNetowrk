import Dependencies
import NetworkHerizon
import SharedModels



/// A client for fetching posts with specified parameters.
struct PostsClient {
    /// A method to asynchronously fetch posts with the given parameters.
    ///
    /// - Parameters:
    ///   - parameters: The parameters for the posts request, including limit and skip.
    ///
    /// - Returns: An asynchronous result that represents a `PostsDTO` containing the retrieved posts.
    ///
    /// - Throws: An error if the posts retrieval fails for any reason.
    var fetchPosts: @Sendable (_ parameters: PostsParameters) async throws -> PostsDTO
}


extension PostsClient: DependencyKey {
    /// LiveValue for Api Client used in production.
    static var liveValue: Self {
        .init(
            fetchPosts: {
                try await ApiClient.load(
                    PostsDTO.self,
                    with: .init(
                        endpoint: "posts/",
                        body: $0,
                        method: .get
                    )
                )
            }
        )
    }
}

extension PostsClient: TestDependencyKey {
    /// Test Value for Client Api used in testing.
    static var testValue: Self {
        .init(
            fetchPosts: { _ in
                .mock
            }
        )
    }
    /// Preview Value for Client Api (same as testValue).

    static var previewValue: Self {
        .testValue
    }
}

extension DependencyValues {
    /// Posts Client to Fetch Api as a dependency.
    var postsClient: PostsClient {
        get { self[PostsClient.self] }
        set { self[PostsClient.self] = newValue }
    }
}
