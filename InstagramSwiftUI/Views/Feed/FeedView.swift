//
//  FeedView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 25.11.2022.
//

import SwiftUI

struct FeedView: View {
    
    @ObservedObject  var viewModel: FeedViewModel
    let vmFactory: VMFactory
  
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 32) {
                ForEach(viewModel.posts) { post in
                    let feedCellViewModel = vmFactory
                        .makeFeedCellViewModel(post: post,
                                               likeService: viewModel.likeService,
                                               notificationService: viewModel.notificationService)
                        FeedCell(viewModel: feedCellViewModel, vmfactory: vmFactory)
                }
            }
            .padding(.top)
        }
    }
    
}


