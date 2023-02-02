//
//  UserService.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 15.01.2023.
//
import Combine

protocol UserService: Actor {
    func fetchUser(uid: String) -> AnyPublisher<User, Error>
    func fetchUsers() -> AnyPublisher<[User], Error>
    func fetchUserStats(uid: String) -> AnyPublisher<UserStats, Error>
    func fetchPostOwner(uid: String) -> AnyPublisher<User?, Error>
    nonisolated func filteredUsers(users: [User], _ query: String) -> [User]
    func saveUserData(uid: String, bio: String) -> AnyPublisher<Bool, Error>
    
}

final actor DefaultUserService: UserService {
    
    func fetchUser(uid: String) -> AnyPublisher<User, Error> {
        Future<User, Error> { promise in
            COLLECTION_USERS
                .document(uid)
                .getDocument { snapShot, error in
                    if let error = error {
                        promise(.failure(error))
                    }
                    do {
                        guard let user = try snapShot?.data(as: User.self) else {
                            return
                        }
                        promise(.success(user))
                    } catch {
                        promise(.failure(error))
                    }
                }
        }
        .eraseToAnyPublisher()
    }
    
    func fetchUsers() -> AnyPublisher<[User], Error> {
        Future { promise in
            COLLECTION_USERS.getDocuments { snapShot, error in
                if let error = error {
                    promise(.failure(error))
                }
                guard let documents = snapShot?.documents else { return }
                let users = documents.compactMap({ try? $0.data(as: User.self)})
                
                promise(.success(users))
            }
        }
        .eraseToAnyPublisher()
        
    }
    
    func fetchUserStats(uid: String) -> AnyPublisher<UserStats, Error> {
        Future { promise in
            COLLECTION_FOLLOWING
                .document(uid)
                .collection("user-following")
                .getDocuments { snapshot, error in
                    if let error = error {
                        promise(.failure(error))
                    }
                    guard let following = snapshot?.documents.count else { return }
                    
                    COLLECTION_FOLLOWERS
                        .document(uid)
                        .collection("user-followers")
                        .getDocuments { snapshot, error in
                            if let error = error {
                                promise(.failure(error))
                            }
                            guard let followers = snapshot?.documents.count else { return }
                            
                            COLLECTION_POSTS
                                .whereField("ownerUid", isEqualTo: uid)
                                .getDocuments { snapshot, error in
                                    if let error = error {
                                        promise(.failure(error))
                                    }
                                    guard let posts = snapshot?.documents.count else { return }
                                    let userStats = UserStats(following: following,
                                                              followers: followers,
                                                              posts: posts)
                                    
                                    promise(.success(userStats))
                                }
                        }
                }
        }
        .eraseToAnyPublisher()
    }
    
    func fetchPostOwner(uid: String) -> AnyPublisher<User?, Error> {
        Future<User?, Error> { promise in
            COLLECTION_USERS
                .document(uid)
                .getDocument { snapshot, error in
                    if let error = error {
                        promise(.failure(error))
                    }
                    let postOwner = try? snapshot?.data(as: User.self)
                    promise(.success(postOwner))
                }
        }
        .eraseToAnyPublisher()
    }

    nonisolated func filteredUsers(users: [User], _ query: String) -> [User] {
        let lowercasedQuery = query.lowercased()
        return users.filter({ $0.fullname.lowercased().contains(lowercasedQuery)
            ||  $0.username.contains(lowercasedQuery)})
    }
    
    func saveUserData(uid: String, bio: String) -> AnyPublisher<Bool, Error> {
        Future { promise in
            COLLECTION_USERS
                .document(uid)
                .updateData(["bio": bio]) { error in
                    if let error = error {
                        promise(.failure(error))
                    }
                    let didSaveUserData = true
                    promise(.success(didSaveUserData))
                }
        }
        .eraseToAnyPublisher()
    }
    
}
