import Foundation

public struct LoginParameters: Encodable {
    let username, password: String

    public init(
        username: String,
        password: String
    ) {
        self.username = username
        self.password = password
    }
}
