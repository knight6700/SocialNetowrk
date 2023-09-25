import Foundation

enum ValidationStatus {
    case valid
    case invalid(String)
}

struct Validator {
    
    // Username Validator
    static func validateUsername(_ username: String) -> Bool {
        let usernameRegex = "^[a-zA-Z]{2}[a-zA-Z0-9_-]{1,13}$"
        let usernamePredicate = NSPredicate(format: "SELF MATCHES %@", usernameRegex)
        
        return usernamePredicate.evaluate(with: username)
    }

    
    // Password Validator
    static func validatePassword(_ password: String) -> Bool {
        let passRegEx = "(?=[^a-z]*[a-z])[^0-9]*[0-9].*"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passRegEx)
        return passwordTest.evaluate(with: password)
    }

}
