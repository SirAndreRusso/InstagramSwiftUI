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
                UserStatsView(value: 1, title: "Posts")
                UserStatsView(value: 1, title: "Followers")
                UserStatsView(value: 1, title: "Following")
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


