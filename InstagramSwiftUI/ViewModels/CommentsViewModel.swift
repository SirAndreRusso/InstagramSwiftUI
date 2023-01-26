//
//  CommentViewModel.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 03.01.2023.
//

import SwiftUI

class CommentsViewModel: ObservableObject {
    
    @Published var comments = [Comment]()
    private let post: Post
    private let user: User
    private let notificationService: NotificationService
    private let commentService: CommentService
    weak var router: Router?
    
    init(post: Post,
         user: User,
         notificationService: NotificationService,
         commentService: CommentService,
         router: Router) {
        self.post = post
        self.user = user
        self.notificationService = notificationService
        self.commentService = commentService
        self.router = router
        fetchComments()
    }
    
    func uploadComment(commentText: String) { 
        commentService.uploadComment(user: user, post: post, commentText: commentText)
        
        self.notificationService.uploadNotification(user: user, toUid: self.post.ownerUid,
                                                            type: .comment,
                                                            post: self.post)
    }
    
    func fetchComments() {
        commentService.fetchComments(post: post) { [weak self] comments in
            self?.comments.append(contentsOf: comments)
        }
    }
    
    deinit {
        print("DEINIT Comments ViewModel")
    }
    
}
