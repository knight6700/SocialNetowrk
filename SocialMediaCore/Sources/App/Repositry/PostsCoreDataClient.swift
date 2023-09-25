import Dependencies
import HorizonStorage

struct PostsCoreDataClient {
    var fetch: () async throws ->  [FBPostModel]
    var save: ([FBPostModel]) async throws -> Void
    var deleteAll: (FBPostEntity.Type) async throws -> Void
}

extension PostsCoreDataClient: DependencyKey {
    static var liveValue: Self {
        @Dependency(\.postsDomain) var postsDomain
        return .init(fetch: {
            postsDomain.fromCoreData(CoreDataManager.shared.fetch(FBPostEntity.self))

        }, save: { posts in
            var entities: [FBPostEntity] = []
            for model in posts {
                let entity = FBPostEntity(context: CoreDataStack.shared.mainContext)
                entity.id = model.id
                entity.name = model.name
                entity.body = model.body
                entity.title = model.title
                // Set other properties if needed
                entities.append(entity)
            }
            CoreDataManager.shared.saveArrayToCoreData(entities)
        }, deleteAll: {
            CoreDataManager.shared.deleteAllPosts($0)
        })
    }
}

extension PostsCoreDataClient: TestDependencyKey {
    static var testValue: Self {
        .init(
            fetch: {
                .posts
            }, save: { _ in },
            deleteAll: { _ in }
        )
    }

    static var previewValue: Self {
        .testValue
    }
}

extension DependencyValues {
    var postsCoreDataClient: PostsCoreDataClient {
        get { self[PostsCoreDataClient.self] }
        set { self[PostsCoreDataClient.self] = newValue }
    }
}
