//
//  AuthService.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 09.01.2023.
//

import UIKit
import Firebase
import Combine

protocol AuthService {
    
    func fetchUser() -> AnyPublisher<User, Error>
    func fetchCurrentUserSession()
    func login(withEmail email: String, password: String) -> AnyPublisher<Bool, Error>
    func register(withEmail email: String,
                  password: String,
                  image: UIImage?,
                  fullname: String,
                  username: String) -> AnyPublisher<Bool, Error>
    func resetPassword(withEmail email: String) -> AnyPublisher<Bool, Error>
    func signOut() -> AnyPublisher<Bool, Error>
    
}

final class DefaultAuthService: AuthService {
    
    private weak var imageUploader: ImageUploader?
    private var userSession: FirebaseAuth.User? = nil
    let authServiceQueue = DispatchQueue.global(qos: .userInitiated)
    
    init(imageUploader: ImageUploader) {
        self.imageUploader = imageUploader
        fetchCurrentUserSession()
    }
    
    func fetchUser() -> AnyPublisher<User, Error> {
        if let uid = userSession?.uid {
           
            return Future<User, Error> { [weak self] promise in
                self?.authServiceQueue.async {
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
                                print("DEBUG: Failed to decode user"
                                      + "\(error.localizedDescription)")
                            }
                        }
                }
            }
            .eraseToAnyPublisher()
        } else {
            return Future<User, Error> { promise in
                promise(.failure(CustomErrors.currentUserIsNil))
            }
            .eraseToAnyPublisher()
        }
    }
    
    func fetchCurrentUserSession() {
        userSession = Auth.auth().currentUser
    }
    
    func login(withEmail email: String, password: String) -> AnyPublisher<Bool, Error> {
        Future<Bool, Error> { [weak self] promise in
            self?.authServiceQueue.async {
                Auth.auth().signIn(withEmail: email,
                                   password: password,
                                   completion: { result, error in
                    if let error = error {
                        promise(.failure(error))
                    }
                    guard let user = result?.user else { return }
                    self?.userSession = user
                    promise(.success(true))
                })
            }
        }
        .eraseToAnyPublisher()
    }
    
    func register(withEmail email: String,
                  password: String,
                  image: UIImage?,
                  fullname: String,
                  username: String) -> AnyPublisher<Bool, Error> {
        Future<Bool, Error> {  [weak self] promise in
            self?.authServiceQueue.async {
                guard let image = image else { return }
                guard let self = self else { return }
                self.imageUploader?
                    .uploadImage(image: image,
                                 type: .profileImage) { imageUrl in
                        Auth.auth().createUser(withEmail: email,
                                               password: password) { result, error in
                            if let error = error {
                                promise(.failure(error))
                            }
                            guard let user = result?.user else { return }
                            
                            self.userSession = user
                            
                            let data = ["email" : email,
                                        "username" : username,
                                        "fullname" : fullname,
                                        "profileImageURL" : imageUrl,
                                        "uid" : user.uid]
                            
                            COLLECTION_USERS
                                .document(user.uid)
                                .setData(data) { error in
                                    if let error = error {
                                        promise(.failure(error))
                                    }
                                    promise(.success(true))
                                }
                        }
                    }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func resetPassword(withEmail email: String) -> AnyPublisher<Bool, Error> {
        Future<Bool, Error> { [weak self] promise in
            self?.authServiceQueue.async {
                Auth.auth().sendPasswordReset(withEmail: email) { error in
                    if let error = error {
                        promise(.failure(error))
                    }
                    let didSentResetPassworlLink = true
                    promise(.success(didSentResetPassworlLink))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func signOut() -> AnyPublisher<Bool, Error> {
        Future { [weak self] promise in
            self?.authServiceQueue.async {
                do {
                    try Auth.auth().signOut()
                    let didSignedOut = true
                    promise(.success(didSignedOut))
                    print("Signed out")
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
}

enum CustomErrors: Error {
    case currentUserIsNil
}
