//
//  FeedCell.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 26.11.2022.
//

import SwiftUI
import Kingfisher

struct FeedCell: View {
    
    @ObservedObject var viewModel : FeedCellViewModel
    var didLike: Bool { return viewModel.post.didLike ?? false}
    
    var body: some View {
            VStack(alignment: .leading) {
                // Postowner
                HStack {
                    NavigationLink {
                        if let user = viewModel.postOwner {
                            LazyView(viewModel.router?.showProfileView(user: user))
                        }
                        Text("")
                    } label: {
                        KFImage(URL(string: viewModel.post.ownerImageURL))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 36, height: 36)
                            .clipped()
                            .cornerRadius(18)
                        Text(viewModel.post.ownerUsername)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.black)
                    }
                }
                .padding([.leading, .bottom], 8)
                // Post
                KFImage(URL(string: viewModel.post.imageURL))
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                    .clipped()
                
                HStack(spacing: 16) {
                    // Like
                    Button {
                        didLike ? viewModel.unLike() : viewModel.like()
                    } label: {
                        Image(systemName: didLike ? "heart.fill" : "heart")
                            .resizable()
                            .scaledToFill()
                            .foregroundColor(didLike ? .red : .black)
                            .frame(width: 20, height: 20)
                            .font(.system(size: 20))
                            .padding(4)
                    }
                    // Comment
                    NavigationLink {
                        LazyView(viewModel.router?.showCommentsView(user: viewModel.currentUser, post: viewModel.post))
                    } label: {
                        Image(systemName: "bubble.right")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 20, height: 20)
                            .font(.system(size: 20))
                            .padding(4)
                    }
                    // Send message
                    Button {
                        
                    } label: {
                        Image(systemName: "paperplane")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 20, height: 20)
                            .font(.system(size: 20))
                            .padding(4)
                    }
                }
                .padding(.leading, 4)
                .foregroundColor(.black)
                // Likes count
                Text(viewModel.likeString)
                    .font(.system(size: 14, weight: .semibold))
                    .padding(.horizontal, 8)
                    .padding(.bottom, 2)
                // Caption
                HStack {
                    Text(viewModel.post.ownerUsername)
                        .font(.system(size: 14, weight: .semibold))
                    + Text(" " + viewModel.post.caption)
                        .font(.system(size: 15))
                }
                .padding(.horizontal, 8)
                // Timestamp
                Text(viewModel.timestampString)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .padding(.leading, 8)
                    .padding(.top, -2)
            }
        }
    
}



