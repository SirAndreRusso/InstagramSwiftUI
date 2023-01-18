//
//  UserService.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 15.01.2023.
//

import Foundation

protocol UserService {
    
    func  fetchUsers(completion: @escaping ([User]) -> Void)
    func filteredUsers(users: [User], _ query: String) -> [User]
    func fetchPostOwner(uid: String, completion: @escaping (User?) -> Void)
    
}

class DefaultUserService: UserService {
    
    func  fetchUsers(completion: @escaping ([User]) -> Void) {
        COLLECTION_USERS.getDocuments { snapShot, error in
            if let error = error {
                print("DEBUG: Failed to fetch users \(error.localizedDescription)")
                return
            }
            guard let documents = snapShot?.documents else { return }
            let users = documents.compactMap({ try? $0.data(as: User.self)})
            
            completion(users)
        }
    }

    func filteredUsers(users: [User], _ query: String) -> [User] {
        let lowercasedQuery = query.lowercased()
        return users.filter({ $0.fullname.lowercased().contains(lowercasedQuery)
            ||  $0.username.contains(lowercasedQuery)})
    }
    
    func fetchPostOwner(uid: String, completion: @escaping (User?) -> Void) {
        COLLECTION_USERS
            .document(uid)
            .getDocument { snapshot, error in
                if let error = error {
                    print("DEBUG: Failed to fetch post owner"
                          + error.localizedDescription)
                }
                let postOwner = try? snapshot?.data(as: User.self)
                
                completion(postOwner)
            }
    }
    
}
