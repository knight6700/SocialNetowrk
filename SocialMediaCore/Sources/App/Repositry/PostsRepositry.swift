import Dependencies
import SharedModels
import HorizonStorage


struct PostsRepository {
    @Dependency(\.postsClient) static var postApi
    @Dependency(\.postsDomain) static var postsDomain
    @Dependency(\.postsCoreDataClient) static var postsCoreDataClient

    var fetchPosts: @Sendable (_ parameters: PostsParameters) async throws -> (posts: [FBPostModel], totalCount: Int)
}

extension PostsRepository: DependencyKey {
    static var liveValue: Self {
        return .init(fetchPosts: { parameters in
            if let remoteData = try? await postApi.fetchPosts(parameters) {
                let model = postsDomain.toDomainModel(remoteData)
                try await postsCoreDataClient.deleteAll(FBPostEntity.self)
                try await postsCoreDataClient.save(model)
                return ( model, remoteData.total)
            }else {
                let cacheData = try await postsCoreDataClient.fetch()
                return (cacheData, cacheData.count)
            }
        })
    }
}

extension PostsRepository: TestDependencyKey {
    static var testValue: Self {
        .init(fetchPosts: { parameters in
            if parameters.skip > 0 {
                return (.morePosts, 20)
            }else {
                return (.posts, 20)
            }
        })
    }
    
    static var previewValue: Self {
        .testValue
    }
}


extension DependencyValues {
    var postsRepository: PostsRepository {
    get { self[PostsRepository.self] }
    set { self[PostsRepository.self] = newValue }
  }
}

