//
//  ProfileView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 25.11.2022.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    let user: User
    init(user: User) {
        self.user = user
        // Search for better place to initialize viewModels
        self.viewModel = ProfileViewModel(user: user)
    }
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                ProfileHeaderView(viewModel: viewModel)
                PostGridView(config: .profile(user.id ?? "")) 
            }
            .padding(.top)
        }
    }
}

