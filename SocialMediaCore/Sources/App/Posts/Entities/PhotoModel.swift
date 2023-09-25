import Foundation
import SharedUI

struct Photo: Identifiable, Equatable {
    let id: String
    let description: String?
    let name: PostPlaceHolderImages
}

extension Array where Element == Photo {
    static let mockOnePhoto: [Photo] = [
        Photo(id: "1",
              description: "Photo 1", name: .post1),
    ]
    static let mockTwoPhotos: [Photo] = [
        Photo(id: "1",
              description: "Photo 1", name: .post1),
        Photo(id: "2", description: "Photo 2", name: .post2),
    ]
    static let mockThreePhotos: [Photo] = [
        Photo(id: "1", description: "Photo 1", name: .post1),
        Photo(id: "2", description: "Photo 2", name: .post2),
        Photo(id: "3", description: "Photo 3", name: .post3),
    ]

    static let mockFourPhotos: [Photo] = [
        Photo(id: "1", description: "Photo 1", name: .post1),
        Photo(id: "2", description: "Photo 2", name: .post2),
        Photo(id: "3", description: "Photo 3", name: .post3),
        Photo(id: "4", description: "Photo 4", name: .post4),
    ]

    static let mockMoreThanFour: [Photo] = [
        Photo(id: "1", description: "Photo 1", name: .post1),
        Photo(id: "2", description: "Photo 2", name: .post2),
        Photo(id: "3", description: "Photo 3", name: .post3),
        Photo(id: "4", description: "Photo 4", name: .post4),
        Photo(id: "5", description: "Photo 5", name: .post5),
        Photo(id: "6", description: "Photo 6", name: .post6),
        Photo(id: "7", description: "Photo 7", name: .post7),
    ]
}


