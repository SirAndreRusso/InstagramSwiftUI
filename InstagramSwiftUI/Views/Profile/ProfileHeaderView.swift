//
//  ProfileHeaderView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 06.12.2022.
//

import SwiftUI
import Kingfisher

struct ProfileHeaderView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                KFImage(URL(string: viewModel.user.profileImageURL))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 95, height: 95)
                    .clipShape(Circle())
                Spacer()
                
                if let stats = viewModel.userStats {
                    UserStatsView(value: stats.posts, title: "Posts")
                    UserStatsView(value: stats.followers, title: "Followers")
                    UserStatsView(value: stats.following, title: "Following")
                } else {
                    UserStatsView(value: 0, title: "Posts")
                    UserStatsView(value: 0, title: "Followers")
                    UserStatsView(value: 0, title: "Following")
                }
            }
            .padding(.horizontal)
            
            Text(viewModel.user.fullname)
                .font(.system(size: 15, weight: .semibold))
                .padding([.leading, .top], 8)
            Text(viewModel.user.username)
                .font(.system(size: 15))
                .padding(.leading, 8)
            
            HStack {
                Spacer()
                ProfileActionButtonView(viewModel: viewModel)
                Spacer()
            }
            .padding(.top, 8)
        }
    }
    
}


