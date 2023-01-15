//
//  MainTabView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 25.11.2022.
//

import SwiftUI

struct MainTabView: View {
    var vmFactory: VMFactory
    var postService: PostService
    @EnvironmentObject var viewModel: AuthViewModel
    @Binding var selectedIndex: Int
    var body: some View {
        NavigationView {
            TabView(selection: $selectedIndex) {
                FeedView(viewModel: vmFactory.makeFeedViewModel(), vmFactory: vmFactory )
                    .onTapGesture {
                        selectedIndex = 0
                    }
                    .tabItem {
                        Image(systemName: "house")
                    }.tag(0)
                
                SearchView(viewModel: vmFactory.makeSearchViewModel(),
                           postService: postService,
                           vmFactory: vmFactory)
                    .onTapGesture {
                        selectedIndex = 1
                    }
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                    }.tag(1)
                
                UploadPostView(viewModel: vmFactory.makeUploadPostViewModel(),
                               tabIndex: $selectedIndex)
                    .onTapGesture {
                        selectedIndex = 2
                    }
                    .tabItem {
                        Image(systemName: "plus.square")
                    }.tag(2)
                
                NotificationsView(viewModel: vmFactory.makeNotificationsViewModel())
                    .onTapGesture {
                        selectedIndex = 3
                    }
                    .tabItem {
                        Image(systemName: "heart")
                    }.tag(3)
                
                ProfileView(viewModel: vmFactory.makeProfileViewModel(user: viewModel.currentUser),
                            vmFactory: vmFactory,
                            postService: postService)
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
    
    var LogOutButton: some View {
        Button {
            viewModel.signOut()
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


