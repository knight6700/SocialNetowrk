//
//  CustomTabbar.swift
//  SocialNetwork
//
//  Created by MahmoudFares on 19/09/2023.
//

import SwiftUI

public struct CustomTabView: View {
    @Binding var selectedTab: TabBarScreens
    public init(selectedTab: Binding<TabBarScreens>) {
        self._selectedTab = selectedTab
    }
    public var body: some View {
        HStack {
            TabView(image: .feeds, selectedTab: $selectedTab)
            TabView(image: .shop, selectedTab: $selectedTab)
            TabView(image: .discount, selectedTab: $selectedTab)
            TabView(image: .profile, selectedTab: $selectedTab)
        }
        .padding()
        .background(Color.horizon(.tabBarColor))
        .overlay(
            Rectangle()
                .inset(by: 0.5)
                .stroke(Color.horizon(.tabBarBorderColor), lineWidth: 1)
        )
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView(selectedTab: .constant(.feeds))
    }
}

struct TabView: View {
    let image: TabBarScreens
    @Binding var selectedTab: TabBarScreens

    var body: some View {
        GeometryReader { _ in
            Button {
                withAnimation(.linear(duration: 0.3)) {
                    selectedTab = image
                }
            } label: {
                VStack {
                    RoundedRectangle(cornerRadius: 1)
                        .frame(width: 12, height: 2)
                        .foregroundColor(selectedTab == image ? .horizon(.primaryColor) : Color.horizon(.whiteColor))
                        .opacity(selectedTab == image ? 1.0 : 0.0)
                        .padding(.top, -15)

                    Image.horizon(image)
                        .offset(y: selectedTab == image ? -5 : 0)
                        .scaleEffect(selectedTab == image ? 1.2 : 1.0)
                        .foregroundColor(selectedTab == image ? .horizon(.primaryColor) : .horizon(.tabBarSelectedColor))
                        .padding(.bottom)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(height: 50)
    }
}
