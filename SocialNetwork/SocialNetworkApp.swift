//
//  SocialNetworkApp.swift
//  SocialNetwork
//
//  Created by MahmoudFares on 18/09/2023.
//

import App
import netfox
import SwiftUI
@main
struct SocialNetworkApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @AppStorage("isDarkMode") var isDarkMode = false

    var body: some Scene {
        WindowGroup {
            MainCoordinatorView(coordinator: .init())
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        startNetworkLogger()
        return true
    }
}

extension AppDelegate {
    func startNetworkLogger() {
        #if DEBUG
            NFX.sharedInstance().start()
        #endif
    }
}
