//
//  NotificationCell.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 06.12.2022.
//

import Kingfisher
import SwiftUI

struct NotificationCell: View {
    
    @ObservedObject var viewModel: NotificationCellViewModel
    var isFollowed: Bool { viewModel.notification.isFollowed ?? false }
    
    var body: some View {
        HStack {
            KFImage(URL(string: viewModel.notification.profileImageURL))
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            
            Text(viewModel.notification.username)
                .font(.system(size: 14, weight: .semibold)) +
            Text(" " + viewModel.notification.type.notificationMessage)
                .font(.system(size: 15))
            Spacer()
            
            if viewModel.notification.type != .follow {
                if let post = viewModel.notification.post {
                    KFImage(URL(string: post.imageURL))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                }
            } else {
                Button {
                    isFollowed ? viewModel.unFollow() : viewModel.follow()
                } label: {
                    Text(isFollowed ? "Following" : "Follow")
                        .font(.system(size: 15, weight: .semibold))
                        .frame(width: 100, height: 32)
                        .foregroundColor(isFollowed ? .black : .white)
                        .background(Color(isFollowed ? .white : .systemBlue))
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray, lineWidth: isFollowed ? 1 : 0))
                }
                .cornerRadius(5)
            }
        }
        .padding(.horizontal, 8)
    }
    
}
