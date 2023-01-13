//
//  FollowingService.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 21.12.2022.
//

import Firebase

protocol FollowingService {
    
    func follow(uid: String, completion: @escaping ((Error?) -> Void))
    func unFollow(uid: String, completion: @escaping ((Error?) -> Void))
    func checkIfUserIsFollowed(uid: String, completion: @escaping(Bool)-> Void)
    
}

class DefaultFollowingService: FollowingService {
    
    func follow(uid: String, completion: @escaping ((Error?) -> Void)) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_FOLLOWING
            .document(currentUid)
            .collection("user-following")
            .document(uid)
            .setData([:]) { _ in
                COLLECTION_FOLLOWERS
                    .document(uid)
                    .collection("user-followers")
                    .document(currentUid)
                    .setData([:], completion: completion)
            }
    }
    
    func unFollow(uid: String, completion: @escaping ((Error?) -> Void)) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_FOLLOWING
            .document(currentUid)
            .collection("user-following")
            .document(uid)
            .delete { _ in
                COLLECTION_FOLLOWERS
                    .document()
                    .collection("followers")
                    .document(currentUid)
                    .delete(completion: completion)
            }
    }
    
    func checkIfUserIsFollowed(uid: String, completion: @escaping(Bool)-> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_FOLLOWING
            .document(currentUid)
            .collection("user-following")
            .document(uid)
            .getDocument { snapShot, error in
                guard
                    error == nil,
                    let isFollowed = snapShot?.exists else { return }
                completion(isFollowed)
            }
    }
    
}
