//
//  AuthService.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 09.01.2023.
//

import UIKit
import Firebase

protocol AuthService {
    
    var imageUploader: ImageUploader { get }
    
    func login(withEmail email: String,
               password: String,
               completion: @escaping (Result<FirebaseAuth.User, Error>) -> Void)
    func register(withEmail email: String,
                  password: String,
                  image: UIImage?,
                  fullname: String,
                  username: String,
                  completion: @escaping (Result<FirebaseAuth.User, Error>) -> Void)
    func signOut(completion: @escaping () -> Void)
    func fetchUser(uid: String, completion: @escaping (Result<User, Error>) -> Void)
    func resetPassword()
    
}

class DefaultAuthService: AuthService {
    
    let imageUploader: ImageUploader
    
    init(imageUploader: ImageUploader) {
        self.imageUploader = imageUploader
    }
    
    func login(withEmail email: String,
               password: String,
               completion: @escaping (Result<FirebaseAuth.User, Error>)
               -> Void) {
        Auth.auth().signIn(withEmail: email,
                           password: password,
                           completion: { result, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let user = result?.user else { return }
            completion(.success(user))
        })
    }
                           
    func register(withEmail email: String,
                  password: String,
                  image: UIImage?,
                  fullname: String,
                  username: String,
                  completion: @escaping (Result<FirebaseAuth.User, Error>)
                  -> Void){
        guard let image = image else { return }
        imageUploader
            .uploadImage(image: image,
                         type: .profileImage) { imageUrl in
            Auth.auth().createUser(withEmail: email,
                                   password: password) { result, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
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
                        completion(.failure(error))
                    }
                    completion(.success(user))
                }
            }
        }
    }
                           
    func signOut(completion: @escaping () -> Void) {
        do {
            try Auth.auth().signOut()
            completion()
        } catch {
            print("DEBUG: Failed to sign out"
                  + error.localizedDescription)
        }
    }
    
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
    
    func resetPassword() {
        
    }
    
}
