@testable import App
import Dependencies
import XCTest

final class PostsViewModelTests: XCTestCase {
    @MainActor func testPosts() async throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let model = withDependencies {
            // 1️⃣ Override any dependencies that your feature uses.
            $0.postsRepository = .testValue
        } operation: {
            PostsViewModel(coordinator: .init(parent: .init()))
        }
        // Initial State
        XCTAssertEqual(
            model.state,
            .init(
                parameters: .init(skip: 0),
                posts: [],
                canLoadMore: false,
                isLoading: true
            )
        )

        // 2️⃣ Trigger the asynchronous operation
        model.trigger(.loadPosts)
        // 3️⃣ Wait for the asynchronous operation to complete
        try await ImmediateClock().sleep(for: .seconds(0.01))
        // 4️⃣ Make assertions after the asynchronous operation is complete
        XCTAssertEqual(
            model.state,
            .init(parameters: .init(skip: 0),
                  posts: .posts,
                  canLoadMore: true,
                  isLoading: false
            )
        )
        // 5️⃣ add More Posts

        var morePosts = model.state.posts
        morePosts.append(contentsOf: [FBPostModel].morePosts)
        // 6️⃣ trigger load more Posts
        model.trigger(.loadMore)
        try await ImmediateClock().sleep(for: .seconds(0.01))
        XCTAssertEqual(
            model.state,
            .init(parameters: .init(skip: 10),
                  posts: morePosts,
                  canLoadMore: true,
                  isLoading: false
            )
        )
    }
}
