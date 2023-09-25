import Foundation

public enum PostPlaceHolderImages: String, ImageProvider, Equatable {
    case post1 = "postPlaceHolder"
    case post2 = "postPlaceHolder-1"
    case post3 = "postPlaceHolder-2"
    case post4 = "postPlaceHolder-3"
    case post5 = "postPlaceHolder-4"
    case post6 = "postPlaceHolder-5"
    case post7 = "postPlaceHolder-6"
    
    public var name: String {
        rawValue
    }
    
    public var bundle: Bundle {
        .module
    }
}

