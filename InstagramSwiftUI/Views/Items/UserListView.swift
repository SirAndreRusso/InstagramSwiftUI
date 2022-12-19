//
//  UserListView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 02.12.2022.
//

import SwiftUI

struct UserListView: View {
    @ObservedObject var viewModel: SearchViewModel
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                ForEach(viewModel.users) { _ in
                    NavigationLink {
                        ProfileView()
                    } label: {
                        UserCell()
                            .padding(.leading)
                    }

                }
            }
        }
    }
}


