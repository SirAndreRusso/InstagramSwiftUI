//
//  AuthService.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 09.01.2023.
//

import UIKit
import Firebase
import Combine

protocol AuthService: Actor {
    
    func fetchUser(uid: String) -> AnyPublisher<User, Error>
    func login(withEmail email: String,
               password: String) -> AnyPublisher<Firebase.User, Error>
    func register(withEmail email: String,
                  password: String,
                  image: UIImage?,
                  fullname: String,
                  username: String) -> AnyPublisher<Firebase.User, Error>
    func resetPassword(withEmail email: String) -> AnyPublisher<Bool, Error>
    func signOut() -> AnyPublisher<Bool, Error> 
    
}

final actor DefaultAuthService: AuthService {
    
    private weak var imageUploader: ImageUploader?
    
    init(imageUploader: ImageUploader) {
        self.imageUploader = imageUploader
    }
    
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
                        print("DEBUG: Failed to decode user"
                              + "\(error.localizedDescription)")
                    }
                }
        }
        .eraseToAnyPublisher()
    }
    
    func login(withEmail email: String,
               password: String) -> AnyPublisher<Firebase.User, Error> {
        Future<Firebase.User, Error> { promise in
            Auth.auth().signIn(withEmail: email,
                               password: password,
                               completion: { result, error in
                if let error = error {
                    promise(.failure(error))
                }
                guard let user = result?.user else { return }
                promise(.success(user))
            })
        }
        .eraseToAnyPublisher()
    }
    
    func register(withEmail email: String,
                  password: String,
                  image: UIImage?,
                  fullname: String,
                  username: String) -> AnyPublisher<Firebase.User, Error> {
        Future<Firebase.User, Error> { [weak self] promise in
            guard let image = image else { return }
            guard let self = self else { return }
            Task {
                await self.imageUploader?
                    .uploadImage(image: image,
                                 type: .profileImage) { imageUrl in
                        Auth.auth().createUser(withEmail: email,
                                               password: password) { result, error in
                            if let error = error {
                                promise(.failure(error))
                            }
                            guard let user = result?.user else { return }
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
                                    promise(.success(user))
                                }
                        }
                    }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func resetPassword(withEmail email: String) -> AnyPublisher<Bool, Error> {
        Future<Bool, Error> { promise in
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if let error = error {
                    promise(.failure(error))
                }
                let didSentResetPassworlLink = true
                promise(.success(didSentResetPassworlLink))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func signOut() -> AnyPublisher<Bool, Error> {
        Future { promise in
            do {
                try Auth.auth().signOut()
                let didSignedOut = true
                promise(.success(didSignedOut))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
}
