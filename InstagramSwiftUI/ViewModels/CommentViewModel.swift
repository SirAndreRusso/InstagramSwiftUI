//
//  CommentViewModel.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 03.01.2023.
//

import SwiftUI
import Firebase

class CommentViewModel: ObservableObject {
    @Published var comments = [Comment]()
    private let post: Post
    private let user: User
    init(post: Post, user: User) {
        self.post = post
        self.user = user
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
