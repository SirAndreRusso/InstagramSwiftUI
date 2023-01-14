//
//  LikeService.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 14.01.2023.
//

import Firebase

protocol LikeService {
    
    func like(post: Post, completion: @escaping () -> Void)
    func unLike(post: Post, completion: @escaping () -> Void)
    func checkIfUserLikedPost(post: Post, completion: @escaping (Bool) -> Void)
    
}

class DefaultLikeService: LikeService {
    
    func like(post: Post, completion: @escaping () -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let postId = post.id else { return }
        
        COLLECTION_POSTS
            .document(postId)
            .collection("post-likes")
            .document(uid)
            .setData([:]) { error in
                if let error = error {
                    print("DEBUG: Failed to set data in post-likes collection"
                          + error.localizedDescription)
                }
                
                COLLECTION_USERS
                    .document(uid)
                    .collection("user-likes")
                    .document(postId)
                    .setData([:]) { error in
                        if let error = error {
                            print("DEBUG: Failed to set data in user-likes collection"
                                  + error.localizedDescription)
                        }
                        
                        COLLECTION_POSTS
                            .document(postId)
                            .updateData(["likes" : post.likes + 1])
                        
                        completion()
                    }
            }
    }
    
    func unLike(post: Post, completion: @escaping () -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let postId = post.id else { return }
        guard post.likes > 0 else { return }
        
        COLLECTION_POSTS
            .document(postId)
            .collection("post-likes")
            .document(uid)
            .delete { error in
                if let error = error {
                    print("DEBUG: Failed to delete data from post-likes collection"
                          + error.localizedDescription)
                }
                
                COLLECTION_USERS
                    .document(uid)
                    .collection("user-likes")
                    .document(postId)
                    .delete { error in
                        if let error = error {
                            print("DEBUG: Failed to delete data from user-likes collection"
                                  + error.localizedDescription)
                        }
                        
                        COLLECTION_POSTS
                            .document(postId)
                            .updateData(["likes" : post.likes - 1])
                        
                        completion()
                    }
            }
    }
    
    func checkIfUserLikedPost(post: Post, completion: @escaping (Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let postId = post.id else { return }
        
        COLLECTION_USERS
            .document(uid)
            .collection("user-likes")
            .document(postId)
            .getDocument { snapShot, error in
                if let error = error {
                    print("DEBUG: Failed to check if user liked a post"
                          + error.localizedDescription)
                }
                guard let didLike = snapShot?.exists else { return }
                
                    completion(didLike)
            }
    }
    
}
