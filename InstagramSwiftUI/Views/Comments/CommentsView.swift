//
//  CommentsView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 25.11.2022.
//

import SwiftUI

struct CommentsView: View {
    
    
    @State var commentText = ""
    @ObservedObject var viewModel: CommentViewModel
    
    init(post: Post, user: User) {
        self.viewModel  = CommentViewModel(post: post, user: user)
        
    }
    
//    init(commentText: String, viewModel: CommentViewModel) {
//        self.commentText = commentText
//        self.viewModel = viewModel
//    }
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 24) {
                    ForEach(0 ..< 10) { _ in
                        CommentCell()
                    }
                }
            }
            .padding(.top)
            
            InputView(inputText: $commentText) {
                viewModel.uploadComment(commentText: commentText)
                commentText = ""
            }
        }
    }
}


