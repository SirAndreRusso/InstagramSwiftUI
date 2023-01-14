//
//  ContentView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 25.11.2022.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State var selectedIndex = 0
    var body: some View {
        Group {
            if viewModel.userSession == nil {
                LoginView()
            } else {
                if let user = viewModel.currentUser {
                    let serviceFacroty = DefaultServiceFactory(user: user)
                    let vmFactory = VMFactoty(user: user, serviceFactory: serviceFacroty)
                    let postsService = serviceFacroty.makePostsService()
                    
                    MainTabView(vmFactory: vmFactory, postsService: postsService, selectedIndex: $selectedIndex)
                }
            }
        }
    }
}

