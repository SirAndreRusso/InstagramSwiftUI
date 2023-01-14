//
//  FeedView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 25.11.2022.
//

import SwiftUI

struct FeedView: View {
    
    @ObservedObject var viewModel: FeedViewModel
    let vmFactory: VMFactoty
    
    init(viewModel: FeedViewModel, vmFactory: VMFactoty) {
        self.viewModel = viewModel
        self.vmFactory = vmFactory
        
    }
  
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 32) {
                ForEach(viewModel.posts) { post in
                    FeedCell(viewModel: FeedCellViewModel(post: post,
                                                          user: viewModel.user,
                                                          notificationService: viewModel.notificationService,
                                                          likeService: viewModel.likeService),
                             vmfactory: vmFactory)
                }
            }
            .padding(.top)
        }
    }
}


