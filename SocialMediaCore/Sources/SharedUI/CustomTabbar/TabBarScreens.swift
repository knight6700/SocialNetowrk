//
//  TabBarCases.swift
//  SocialNetwork
//
//  Created by MahmoudFares on 19/09/2023.
//

import SwiftUI

public enum TabBarScreens: String, ImageProvider {
    case feeds
    case shop
    case discount
    case gallery
    case profile

    public var name: String {
        rawValue
    }

    public var bundle: Bundle {
        .module
    }
}
