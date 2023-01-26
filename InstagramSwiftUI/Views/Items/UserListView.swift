//
//  UserListView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 02.12.2022.
//

import SwiftUI

struct UserListView: View {

    @ObservedObject var viewModel: SearchViewModel
    @Binding var searchText: String
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                ForEach(searchText.isEmpty
                        ? viewModel.users
                        : viewModel.filteredUsers(searchText)) { user in
                    NavigationLink {
                        LazyView(viewModel.router?.showProfileView(user: user))
                    } label: {
                        UserCell(user: user)
                            .padding(.leading)
                    }
                }
            }
        }
    }
    
}


