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

    var body: some Scene {
        let authViewModel = AuthViewModel(authService: AuthServiceImpl(imageUploader: ImageUploaderServiceImpl()))
        WindowGroup {
            ContentView().environmentObject(authViewModel)
        }
    }
}
