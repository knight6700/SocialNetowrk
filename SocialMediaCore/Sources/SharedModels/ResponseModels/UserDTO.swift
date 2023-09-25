import Foundation

public struct UserDTO: Decodable {
    public let id: Int
    public let username, email, firstName, lastName: String
    let gender: Gender
    public let image: String
    public let token: String

    public init(
        id: Int,
        username: String,
        email: String,
        firstName: String,
        lastName: String,
        gender: Gender,
        image: String,
        token: String
    ) {
        self.id = id
        self.username = username
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
        self.image = image
        self.token = token
    }
}

public enum Gender: String, Decodable {
    case male
    case female
}

public extension UserDTO {
    static let mock: Self = Self(
        id: 15,
        username: "kminchelle",
        email: "kminchelle@qq.com",
        firstName: "Jeanne",
        lastName: "Halvorson",
        gender: .male,
        image: "https://robohash.org/autquiaut.png",
        token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9"
    )
}
