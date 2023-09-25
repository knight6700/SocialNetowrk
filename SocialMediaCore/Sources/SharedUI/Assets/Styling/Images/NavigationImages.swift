//
//  navigationImages.swift
//  SocialNetwork
//
//  Created by MahmoudFares on 19/09/2023.
//

import Foundation

public enum NavigationImages: String, ImageProvider {
    case logo
    case search
    case close

    public var name: String {
        rawValue
    }

    public var bundle: Bundle {
        .module
    }
}
