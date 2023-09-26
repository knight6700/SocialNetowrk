//
//  PostsDTO.swift
//
//
//  Created by MahmoudFares on 20/09/2023.
//

import Foundation
public struct PostsDTO: Decodable {
    public let posts: [Post]
    public let total, skip, limit: Int
}

// MARK: - Post

public struct Post: Codable {
    public let id: Int
    public let title, body: String
    public let userId: Int
    public let tags: [String]
    public let reactions: Int
}

public extension PostsDTO {
    static let mock: Self = Self(posts: .mockPosts, total: 10, skip: 0, limit: 10)
}

public extension Array where Element == Post {
    static let mockPosts: [Post] = [
        Post(
            id: 1,
            title: "Post 1",
            body: "This is the content of Post 1",
            userId: 101,
            tags: ["Tag1", "Tag2"],
            reactions: 25
        ),
        Post(
            id: 2,
            title: "Post 2",
            body: "This is the content of Post 2",
            userId: 102,
            tags: ["Tag2", "Tag3"],
            reactions: 30
        ),
        Post(id: 3,
             title: "Post 3",
             body: "This is the content of Post 3",
             userId: 103,
             tags: ["Tag1"],
             reactions: 15
        ),
        Post(
            id: 4,
            title: "Post 4"
            , body: "This is the content of Post 4",
            userId: 104,
            tags: ["Tag4"],
            reactions: 10
        ),
        Post(
            id: 5,
            title: "Post 5",
            body: "This is the content of Post 5",
            userId: 105,
            tags: ["Tag3", "Tag5"],
            reactions: 42
        ),
        Post(
            id: 6,
            title: "Post 6",
            body: "This is the content of Post 6",
            userId: 106,
            tags: ["Tag1", "Tag4"],
            reactions: 18
        ),
        Post(
            id: 7,
            title: "Post 7",
            body: "This is the content of Post 7",
            userId: 107,
            tags: ["Tag2"],
            reactions: 22
        ),
        Post(
            id: 8,
            title: "Post 8",
            body: "This is the content of Post 8",
            userId: 108,
            tags: ["Tag5"],
            reactions: 12
        ),
        Post(
            id: 9,
            title: "Post 9",
            body: "This is the content of Post 9",
            userId: 109,
            tags: ["Tag1", "Tag3"],
            reactions: 38
        ),
        Post(
            id: 10,
            title: "Post 10",
            body: "This is the content of Post 10",
            userId: 110,
            tags: ["Tag2", "Tag4"],
            reactions: 29
        ),
    ]
}
