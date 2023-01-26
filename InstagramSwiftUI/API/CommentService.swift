//
//  CommentService.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 15.01.2023.
//

import Firebase

protocol CommentService {
    
    func fetchComments(post: Post, completion: @escaping ([Comment]) -> Void)
    func uploadComment(user: User, post: Post, commentText: String)
    
}

final class DefaultCommentService: CommentService {
    
    func fetchComments(post: Post, completion: @escaping ([Comment]) -> Void) {
        guard let postId = post.id else { return }
        let query = COLLECTION_POSTS
            .document(postId)
            .collection("post-comments")
            .order(by: "timestamp", descending: true)
        
        query.addSnapshotListener { snapshot, error in
            if let error = error {
                print("DEBUG: Failed to add snapshot listener"
                      + error.localizedDescription)
            }
            guard let addedDocs = snapshot?.documentChanges.filter({$0.type == .added}) else {
                return
            }
            let comments = addedDocs.compactMap({try? $0.document.data(as: Comment.self)})
            
            completion(comments)
        }
    }
    
    func uploadComment(user: User, post: Post, commentText: String) {
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
                    print("DEBUG: Failed to upload comment"
                          + error.localizedDescription)
                }
            }
    }
    
}
