//
//  FeedView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 25.11.2022.
//

import SwiftUI

struct FeedView: View {
  
    private let user: User
    @ObservedObject var viewModel: FeedViewModel
    
    init(user: User) {
        viewModel = FeedViewModel()
        self.user = user
    }
  
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 32) {
                ForEach(viewModel.posts) { post in
                    FeedCell(viewModel: FeedCellViewModel(post: post),
                             user: user)
                }
            }
            .padding(.top)
        }
    }
}


