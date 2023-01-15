//
//  FeedView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 25.11.2022.
//

import SwiftUI

struct FeedView: View {
    
    @ObservedObject var viewModel: FeedViewModel
    let vmFactory: VMFactory
  
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 32) {
                ForEach(viewModel.posts) { post in
                    if let feedCellViewModel = vmFactory.makeFeedCellViewModel(post: post, user: viewModel.user, notificationService: viewModel.notificationService, likeService: viewModel.likeService) {
                        FeedCell(viewModel: feedCellViewModel, vmfactory: vmFactory)
                    }
                }
            }
            .padding(.top)
        }
    }
    
}


