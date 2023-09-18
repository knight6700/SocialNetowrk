//
//  SocialNetworkApp.swift
//  SocialNetwork
//
//  Created by MahmoudFares on 18/09/2023.
//

import SwiftUI

@main
struct SocialNetworkApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
