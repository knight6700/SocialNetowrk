//
//  MainCoordinator.swift
//  
//
//  Created by MahmoudFares on 22/09/2023.
//

import Foundation
@MainActor
public class MainCoordinator: ObservableObject {
    // MARK: Stored Properties


    @Published var loginCoordinator: LoginCoordinator!
    @Published var tabBarCoordinator: TabBarCoordinator!
    @Published var showLogin: Bool = true
    public init() {
        loginCoordinator = .init(parent: self)
        tabBarCoordinator = .init()
    }
    
    func intailzieObservable() {
//        loginCoordinator.viewModel.
    }
}
