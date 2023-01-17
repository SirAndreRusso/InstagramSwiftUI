//
//  ProfileView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 25.11.2022.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel: ProfileViewModel
    let vmFactory: VMFactory
//    let postService: PostService
   
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                if let postGreedViewModel = vmFactory.makePostGreedViewModel(config: .profile(viewModel.user.id ?? "")) {
                    ProfileHeaderView(viewModel: viewModel)
                    PostGridView(viewModel: postGreedViewModel, vmFactory: vmFactory)
                }
            }
            .padding(.top)
        }
    }
    
}

