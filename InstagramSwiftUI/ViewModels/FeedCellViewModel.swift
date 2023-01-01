//
//  FeedCellViewModel.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 01.01.2023.
//

import SwiftUI
import Firebase

class FeedCellViewModel: ObservableObject {
    
    @Published var post: Post
    var likeString: String {
        let label = post.likes == 1 ? "like" : "likes"
        return "\(post.likes) \(label)"
    }
    
    init(post: Post) {
        self.post = post
    }
    
    func like() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let postId = post.id else { return }
        COLLECTION_POSTS.document(postId)
            .collection("post-likes")
            .document(uid)
            .setData([:]) { error in
                if let error = error {
                    print("DEBUG: Failed to set data in post-likes collection" + error.localizedDescription)
                }
                COLLECTION_USERS.document(uid)
                    .collection("user-likes")
                    .document(postId)
                    .setData([:]) { [weak self] error in
                        if let error = error {
                            print("DEBUG: Failed to set data in user-likes collection" + error.localizedDescription)
                        }
                        guard let self = self else { return }
                        COLLECTION_POSTS.document(postId).updateData(["likes" : self.post.likes + 1])
                        self.post.didLike = true
                        self.post.likes += 1
                    }
            }
    }
    
    func unLike() {
        print("unLike")
    }
    
    func checkIfUserLikedPost() {
        
    }
    
}
