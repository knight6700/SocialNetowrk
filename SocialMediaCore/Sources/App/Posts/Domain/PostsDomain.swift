import Dependencies
import SharedModels
import HorizonStorage

struct PostsDomain {
    var toDomainModel: @Sendable (_ postsDTO: PostsDTO) -> [FBPostModel]
    var fromCoreData: @Sendable (_ posts: [FBPostEntity]) -> [FBPostModel]
}

extension PostsDomain: DependencyKey {
    static var liveValue: Self {
        .init(
            toDomainModel: { postsDTO in
                postsDTO.posts.map {
                    FBPostModel(
                        id: $0.id,
                        name: FBPostModel.randomModel()?.name ?? "",
                        body: $0.body,
                        title: $0.title,
                        imageName: FBPostModel.randomModel()?.imageName ?? .person4,
                        photos: FBPostModel.randomModel()?.photos ?? []
                    )
                }
            }, fromCoreData: { postsEntities in
                postsEntities.map {
                    FBPostModel(
                        id: $0.id,
                        name: FBPostModel.randomModel()?.name ?? "",
                        body: $0.body,
                        title: $0.title,
                        imageName: FBPostModel.randomModel()?.imageName ?? .person4,
                        photos: FBPostModel.randomModel()?.photos ?? []
                    )
                    
                }
            }
        )
    }
}

extension PostsDomain: TestDependencyKey {
    static var testValue: Self {
        .init(
            toDomainModel: { _ in
                .posts
            }, fromCoreData: { _ in
                .posts
            }
        )
    }

    static var previewValue: Self {
        .testValue
    }
}

extension DependencyValues {
    var postsDomain: PostsDomain {
        get { self[PostsDomain.self] }
        set { self[PostsDomain.self] = newValue }
    }
}
