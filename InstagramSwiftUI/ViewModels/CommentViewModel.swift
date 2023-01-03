//
//  CommentViewModel.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 03.01.2023.
//

import SwiftUI
import Firebase

class CommentViewModel: ObservableObject {
    
    private let post: Post
    private let user: User
    init(post: Post, user: User) {
        self.post = post
        self.user = user
    }
    func uploadComment(commentText: String) {
        guard let uid = user.id else { return }
        guard let postId = post.id else { return }
        let data: [String: Any] = ["username": user.username,
                                   "profileImageURL": user.profileImageURL,
                                   "uid": uid,
                                   "timeStamp": Timestamp(date: Date()),
                                   "postOwnerUid": post.ownerUid,
                                   "commentText": commentText]
        
        COLLECTION_POSTS
            .document(postId)
            .collection("post-comments")
            .addDocument(data: data) { error in
                if let error = error {
                    print("DEBUG: Failed to upload comment" + error.localizedDescription)
                }
            }
        
    }
    
    func fetchComment() {
        
    }
}
