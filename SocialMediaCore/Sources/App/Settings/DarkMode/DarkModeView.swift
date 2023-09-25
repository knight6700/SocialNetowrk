//
//  DarkModeView.swift
//  SocialNetwork
//
//  Created by MahmoudFares on 19/09/2023.
//

import Combine
import SwiftUI

struct DarkModeView: View {
    @State var isDarkModeToggle = false
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some View {
        Button {
            isDarkModeToggle.toggle()
        } label: {
            HStack {
                Image(systemName: isDarkModeToggle ? "moon.fill" : "moon")
                Text("Dark Mode")
            }
        }
        .onChange(of: isDarkModeToggle, perform: { newValue in
            isDarkMode = newValue
        })
        .onAppear {
            isDarkModeToggle = isDarkMode
        }
    }
}
