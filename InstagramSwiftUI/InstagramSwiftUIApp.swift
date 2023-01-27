//
//  InstagramSwiftUIApp.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 25.11.2022.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
    
}

@main
struct InstagramSwiftUIApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var authViewModel = {
        let serviceProvider: ServiceProvider = DefaultServiceProvider()
        lazy var vmFactory: VMFactory = DefaultVMFactory(serviceFactory: serviceProvider)
        lazy var router = DefaultRouter(vmFactory: vmFactory, serviceFactory: serviceProvider)
        return vmFactory.makeAuthViewModel(authService: serviceProvider.authService, router: router)
    }()
    @State var selectedIndex = 0
    
    var body: some Scene {
        WindowGroup {
            if authViewModel.userSession == nil {
                authViewModel.router?.showLoginView()
                    .environmentObject(authViewModel)
            } else {
                if let _ = authViewModel.currentUser {
                    authViewModel.router?.showMainTabView(selectedIndex: $selectedIndex)
                        .environmentObject(authViewModel)
                }
            }
        }
    }
    
}
