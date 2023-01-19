//
//  UserListView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 02.12.2022.
//

import SwiftUI

struct UserListView: View {
    let vmFactory: VMFactory
//    let postService: PostService
    @ObservedObject var viewModel: SearchViewModel
    @Binding var searchText: String
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                ForEach(searchText.isEmpty
                        ? viewModel.users
                        : viewModel.filteredUsers(searchText)) { user in
                    NavigationLink {
                        LazyView(ProfileView(viewModel: vmFactory.makeProfileViewModel(user: user), vmFactory: vmFactory))
                    } label: {
                        UserCell(user: user)
                            .padding(.leading)
                    }
                }
            }
        }
    }
}


