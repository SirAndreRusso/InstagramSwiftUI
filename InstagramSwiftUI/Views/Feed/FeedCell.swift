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
    let vmfactory: VMFactory
    
    var body: some View {
            VStack(alignment: .leading) {
                HStack {
                    NavigationLink {
                        if let user = viewModel.postOwner {
                            let profileViewModel = vmfactory.makeProfileViewModel(user: user)
                            ProfileView(viewModel: profileViewModel, vmFactory: vmfactory)
                        }
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
                
                KFImage(URL(string: viewModel.post.imageURL))
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                    .clipped()
                    
                    
                
                HStack(spacing: 16) {
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
                    
                    NavigationLink {
                        CommentsView(viewModel: vmfactory.makeCommentsViewModel(user: viewModel.currentUser, post: viewModel.post))
                    } label: {
                        Image(systemName: "bubble.right")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 20, height: 20)
                            .font(.system(size: 20))
                            .padding(4)
                    }
                    
                    
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
                
                Text(viewModel.likeString)
                    .font(.system(size: 14, weight: .semibold))
                    .padding(.horizontal, 8)
                    .padding(.bottom, 2)
                
                HStack {
                    Text(viewModel.post.ownerUsername)
                        .font(.system(size: 14, weight: .semibold))
                    + Text(" " + viewModel.post.caption)
                        .font(.system(size: 15))
                }
                .padding(.horizontal, 8)
                Text(viewModel.timeStampString)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .padding(.leading, 8)
                    .padding(.top, -2)
            }
        }
    
}



