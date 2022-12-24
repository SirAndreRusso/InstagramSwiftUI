//
//  MainTabView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 25.11.2022.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    let user: User
    var body: some View {
        NavigationView {
            TabView {
                FeedView()
                    .tabItem {
                        Image(systemName: "house")
                    }
                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                    }
                UploadPostView(user: user)
                    .tabItem {
                        Image(systemName: "plus.square")
                    }
                NotificationsView()
                    .tabItem {
                        Image(systemName: "heart")
                    }
                ProfileView(user: user)
                    .tabItem {
                        Image(systemName: "person")
                    }
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: LogOutButton)
            .tint(.black)
        }
    }
    var LogOutButton: some View {
        Button {
            viewModel.signOut()
        } label: {
            Text("Logout")
                .foregroundColor(.black)
        }

    }
}


