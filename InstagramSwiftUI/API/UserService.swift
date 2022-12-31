//
//  UserService.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 21.12.2022.
//

import Firebase

class UserService {
    static func follow(uid: String, completion: @escaping ((Error?) -> Void)) {
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
    
    static func unFollow(uid: String, completion: @escaping ((Error?) -> Void)) {
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
    
    static func checkIfUserIsFollowed(uid: String, completion: @escaping(Bool)-> Void) {
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
