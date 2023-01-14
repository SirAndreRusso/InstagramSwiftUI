//
//  ProfileView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 25.11.2022.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    let vmFactory: VMFactoty
    let postsService: PostService
   
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                ProfileHeaderView(viewModel: viewModel)
                PostGridView(config: .profile(viewModel.user.id ?? ""), vmFactory: vmFactory, postsService: postsService)
            }
            .padding(.top)
        }
    }
}

