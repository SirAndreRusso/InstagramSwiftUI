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
    
    init(post: Post, user: User, notificationService: NotificationService) {
        self.post = post
        self.user = user
        self.notificationService = notificationService
        fetchComments()
    }
    
    func uploadComment(commentText: String) {
        guard let uid = user.id else { return }
        guard let postId = post.id else { return }
        let data: [String: Any] = ["username": user.username,
                                   "profileImageURL": user.profileImageURL,
                                   "uid": uid,
                                   "timestamp": Timestamp(date: Date()),
                                   "postOwnerUid": post.ownerUid,
                                   "commentText": commentText]
        
        COLLECTION_POSTS
            .document(postId)
            .collection("post-comments")
            .addDocument(data: data) { error in
                if let error = error {
                    print("DEBUG: Failed to upload comment" + error.localizedDescription)
                }
                self.notificationService.uploadNotification(toUid: self.post.ownerUid,
                                                            type: .comment,
                                                            post: self.post)
            }
    }
    
    func fetchComments() {
        guard let postId = post.id else { return }
        let query = COLLECTION_POSTS
            .document(postId)
            .collection("post-comments")
            .order(by: "timestamp", descending: true)
        
        query.addSnapshotListener { snapshot, error in
            if let error = error {
                print("DEBUG: Failed to add snapshot listener" + error.localizedDescription)
            }
            guard let addedDocs = snapshot?.documentChanges.filter({$0.type == .added}) else {
                return
            }
            self.comments.append(contentsOf: addedDocs.compactMap({try? $0.document.data(as: Comment.self)}))
        }
    }
    deinit {
        // delete snapshot listener
    }
}
