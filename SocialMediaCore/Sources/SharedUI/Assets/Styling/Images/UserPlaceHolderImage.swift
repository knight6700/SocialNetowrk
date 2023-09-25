import Foundation

public enum UserPlaceHolderImage: String, ImageProvider {
    case person1
    case person2
    case person3
    case person4
    
    public var name: String {
        rawValue
    }
    
    public var bundle: Bundle {
        .module
    }

}
