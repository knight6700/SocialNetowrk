//
//  WidthModifier.swift
//  SocialNetwork
//
//  Created by MahmoudFares on 18/09/2023.
//

import SwiftUI

public struct WidthModifier: ViewModifier {
    let isStatic: Bool
    let height: CGFloat

    public func body(content: Content) -> some View {
        if isStatic {
            content
                .frame(height: 200)
        } else {
            content
                .frame(width: 180, height: height)
        }
    }
}

public extension View {
    // Create an extension on View to easily apply the custom modifier
    func customFrame(
        isStatic: Bool,
        height: CGFloat
    ) -> some View {
        modifier(
            WidthModifier(
                isStatic: isStatic,
                height: height
            )
        )
    }
}
