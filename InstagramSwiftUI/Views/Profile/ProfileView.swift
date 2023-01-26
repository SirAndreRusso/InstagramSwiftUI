//
//  ProfileView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 25.11.2022.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
   
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                viewModel.router?.showProfileHeaderView(user: viewModel.user)
                viewModel.router?.showPostGreedView(config: .profile(viewModel.user.id ?? ""))
            }
            .padding(.top)
        }
    }
        
}

