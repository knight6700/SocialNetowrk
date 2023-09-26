import Foundation
/// A struct that represents parameters for fetching a list of posts.
public struct PostsParameters: Encodable, Equatable {
    /// The maximum number of posts to retrieve in a single request.
    /// The default value is 10, but you can change it to any desired limit.
    public var limit: Int = 10

    /// The number of posts to skip before retrieving the next set of posts.
    /// Use this for pagination, increasing it by the specified `limit` for each request.
    public var skip: Int

    /// A search query to filter posts based on specific criteria.
    /// You can provide a query string to narrow down the search results.
    public var query: String?

    /// Coding keys to customize the parameter names when encoding to JSON.
    enum CodingKeys: String, CodingKey {
        case limit
        case skip
        case query = "q"
    }

    /// Initialize the struct with default values.
    ///
    /// - Parameters:
    ///   - limit: The maximum number of posts to retrieve (default is 10).
    ///   - skip: The number of posts to skip before retrieving the next set.
    ///   - query: A search query to filter posts (default is nil).
    public init(
        limit: Int = 10,
        skip: Int,
        query: String? = nil
    ) {
        self.limit = limit
        self.skip = skip
        self.query = query
    }
}
