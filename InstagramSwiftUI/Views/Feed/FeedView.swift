//
//  FeedView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 25.11.2022.
//

import SwiftUI

struct FeedView: View {

    @StateObject  var viewModel: FeedViewModel
  
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 32) {
                ForEach(viewModel.posts) { post in
                        LazyView(viewModel.router?.showFeedCellView(user: viewModel.user, post: post))
                }
            }
            .padding(.top)
        }
        .refreshable {
            viewModel.fetchPosts()
        }
    }
    
}


