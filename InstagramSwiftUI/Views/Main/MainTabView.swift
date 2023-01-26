//
//  MainTabView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 25.11.2022.
//

import SwiftUI

struct MainTabView: View {
    
    @EnvironmentObject private var authViewModel: AuthViewModel
    @Binding var selectedIndex: Int
    
    var body: some View {
        if let user = authViewModel.currentUser {
            NavigationView {
                TabView(selection: $selectedIndex) {
                    authViewModel.router?.showFeedView(user: user)
                        .onTapGesture {
                            selectedIndex = 0
                        }
                        .tabItem {
                            Image(systemName: "house")
                        }.tag(0)
                    
                    authViewModel.router?.showSearchView()
                        .onTapGesture {
                            selectedIndex = 1
                        }
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                        }.tag(1)
                    
                    authViewModel.router?.showUploadPostView(user: user, tabIndex: $selectedIndex)
                        .onTapGesture {
                            selectedIndex = 2
                        }
                        .tabItem {
                            Image(systemName: "plus.square")
                        }.tag(2)
                    
                    
                    authViewModel.router?.showNotificationsView(user: user)
                        .onTapGesture {
                            selectedIndex = 3
                        }
                        .tabItem {
                            Image(systemName: "heart")
                        }.tag(3)
                    
                    
                    authViewModel.router?.showProfileView(user: user)
                        .onTapGesture {
                            selectedIndex = 4
                        }
                        .tabItem {
                            Image(systemName: "person")
                        }.tag(4)
                }
                .navigationTitle(tabTitle)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: LogOutButton)
                .tint(.black)
            }
        }
    }
    
    var LogOutButton: some View {
        Button {
            authViewModel.signOut()
            self.selectedIndex = 0
        } label: {
            Text("Logout")
                .foregroundColor(.black)
        }
        
    }
    
    var tabTitle: String {
        switch selectedIndex {
        case 0: return "Feed"
        case 1: return "Explore"
        case 2: return "New post"
        case 3: return "Notifications"
        case 4: return "Profile"
        default: return ""
        }
    }
    
}


