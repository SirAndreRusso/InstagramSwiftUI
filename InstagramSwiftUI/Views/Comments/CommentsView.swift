//
//  CommentsView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 25.11.2022.
//

import SwiftUI

struct CommentsView: View {
    
    @State var commentText = ""
    @ObservedObject var viewModel: CommentsViewModel
    
    init(viewModel: CommentsViewModel) {
        self.viewModel  = viewModel
    }
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 24) {
                    ForEach(viewModel.comments) { comment in
                        CommentCell(comment: comment)
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


