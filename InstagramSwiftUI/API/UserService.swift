//
//  UserService.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 15.01.2023.
//

protocol UserService {
    
    func fetchUser(uid: String,
                   completion: @escaping (Result<User, Error>) -> Void)
    func fetchUsers(completion: @escaping ([User]) -> Void)
    func fetchUserStats(uid: String, completion: @escaping (UserStats) -> Void)
    func filteredUsers(users: [User], _ query: String) -> [User]
    func fetchPostOwner(uid: String, completion: @escaping (User?) -> Void)
    func saveUserData(uid: String, bio: String, completion: @escaping () -> Void)
    
}

final class DefaultUserService: UserService {
    
    func fetchUser(uid: String,
                   completion: @escaping (Result<User, Error>) -> Void) {
        COLLECTION_USERS
            .document(uid)
            .getDocument { snapShot, error in
            if let error = error {
                completion(.failure(error))
            }
            do {
                guard let user = try snapShot?.data(as: User.self) else {
                    return
                }
                completion(.success(user))
            } catch {
                print("DEBUG: Failed to decode user"
                      + "\(error.localizedDescription)")
            }
        }
    }
    
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
    
    func fetchUserStats(uid: String, completion: @escaping (UserStats) -> Void) {
        COLLECTION_FOLLOWING
            .document(uid)
            .collection("user-following")
            .getDocuments { snapshot, error in
                if let error = error {
                    print("DEBUG: Failed to fetch user-following documents"
                          + error.localizedDescription)
                }
                guard let following = snapshot?.documents.count else { return }
                
                COLLECTION_FOLLOWERS
                    .document(uid)
                    .collection("user-followers")
                    .getDocuments { snapshot, error in
                        if let error = error {
                            print("DEBUG: Failed to fetch user-followers documents"
                                  + error.localizedDescription)
                        }
                        guard let followers = snapshot?.documents.count else { return }
                        
                        COLLECTION_POSTS
                            .whereField("ownerUid", isEqualTo: uid)
                            .getDocuments { snapshot, error in
                                if let error = error {
                                    print("DEBUG: Failed to fetch posts by uid"
                                          + error.localizedDescription)
                                }
                                guard let posts = snapshot?.documents.count else { return }
                                let userStats = UserStats(following: following,
                                                          followers: followers,
                                                          posts: posts)
                                
                                completion(userStats)
                            }
                    }
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
    
    func saveUserData(uid: String, bio: String, completion: @escaping () -> Void) {
        COLLECTION_USERS
            .document(uid)
            .updateData(["bio": bio]) { error in
                if let error = error {
                    print("DEBUG: Failed to save user data"
                          + error.localizedDescription)
                    return
                }
                completion()
            }
    }
    
}
