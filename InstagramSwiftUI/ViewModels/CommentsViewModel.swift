//
//  CommentViewModel.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 03.01.2023.
//

import SwiftUI
import Firebase

class CommentsViewModel: ObservableObject {
    
    @Published var comments = [Comment]()
    private let post: Post
    private let user: User
    let notificationService: NotificationService
    let commentService: CommentService
    
    init(post: Post,
         user: User,
         notificationService: NotificationService,
         commentService: CommentService) {
        self.post = post
        self.user = user
        self.notificationService = notificationService
        self.commentService = commentService
        fetchComments()
    }
    
    func uploadComment(commentText: String) {
        commentService.uploadComment(user: user, post: post, commentText: commentText)
        
                self.notificationService.uploadNotification(toUid: self.post.ownerUid,
                                                            type: .comment,
                                                            post: self.post)
    }
    
    func fetchComments() {
        commentService.fetchComments(post: post) { comments in
            self.comments.append(contentsOf: comments)
        }
        
    }
    deinit {
        // delete snapshot listener
    }
}
