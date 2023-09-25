//
//  File.swift
//
//
//  Created by MahmoudFares on 19/09/2023.
//

import Foundation

public enum LoginImages: String, ImageProvider {
    case loginPlaceHolder = "login-placeholder"
    public var name: String {
        rawValue
    }

    public var bundle: Bundle {
        .module
    }
}
