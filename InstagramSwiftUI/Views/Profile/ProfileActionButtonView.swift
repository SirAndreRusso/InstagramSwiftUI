//
//  ProfileActionButtonView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 07.12.2022.
//

import SwiftUI

struct ProfileActionButtonView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    @State var showEditProfile: Bool = false
    var isFollowed: Bool { return viewModel.user.isFolowed ?? false }
    
    var body: some View {
        if viewModel.user.isCurrentUser {
            Button {
                showEditProfile.toggle()
            } label: {
                Text("Edit profile")
                    .font(.system(size: 15, weight: .semibold))
                    .frame(width: 360, height: 32)
                    .foregroundColor(.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(Color.gray, lineWidth: 1))
            }
            .cornerRadius(3)
            .sheet(isPresented: $showEditProfile) {
                EditProfileView()
            }
        } else {
            // Follow and message buttons
            HStack {
                Button {
                    isFollowed ? viewModel.unFollow() : viewModel.follow()
                } label: {
                    Text(isFollowed ? "Following" : "Follow")
                        .font(.system(size: 15, weight: .semibold))
                        .frame(width: 172, height: 32)
                        .foregroundColor(isFollowed ? .black : .white)
                        .background(Color(isFollowed ? .white : .systemBlue))
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray, lineWidth: isFollowed ? 1 : 0))
                }
                .cornerRadius(5)
                
                Button {
                    
                } label: {
                    Text("Message")
                        .font(.system(size: 15, weight: .semibold))
                        .frame(width: 172, height: 32)
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray, lineWidth: 1))
                }
                .cornerRadius(5)
            }
        }
    }
    
}

