import Foundation
public struct User: Codable {
    public let id: Int
    public let username, email, firstName, lastName: String
    public let image: String
    public let token: String

    public init(
        id: Int,
        username: String,
        email: String,
        firstName: String,
        lastName: String,
        image: String,
        token: String
    ) {
        self.id = id
        self.username = username
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.image = image
        self.token = token
    }
}
