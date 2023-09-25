//
//  Settings.swift
//  SocialNetwork
//
//  Created by MahmoudFares on 19/09/2023.
//

import SwiftUI

struct Settings: View {
    var body: some View {
        List {
            DarkModeView()
        }
        .padding(.vertical)
        .listStyle(.plain)
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
