//
//  AuthViewModel.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 15.12.2022.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    //    static let shared = AuthViewModel()
    init() {
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { result, error in
            if let error = error {
                print("DEBUG: Login failed \(error.localizedDescription)")
                return
            }
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser()
            print("login")
        })
        
    }
                           
    func register(withEmail email: String, password: String, image: UIImage?, fullname: String, username: String) {
        guard let image = image else { return }
        ImageUploader.uploadImage(image: image, type: .profileImage) { imageUrl in
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
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
                COLLECTION_USERS.document(user.uid).setData(data) { error in
                    if let error = error {
                        print("DEBUG: Can't upload user data to firestore" + error.localizedDescription)
                        return
                    }
                    self.userSession = user
                    self.fetchUser()
                    print("User data uploaded")
                }
            }
        }
    }
                           
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
        } catch {
            print(error.localizedDescription)
        }
        
        
    }
    func fetchUser() {
        guard let uid = userSession?.uid else { return }
        COLLECTION_USERS.document(uid).getDocument { snapShot, error in
            if let error = error {
                print("DEBUG: failed to fetch user \(error.localizedDescription)")
                return
            }
            do {
                let user = try snapShot?.data(as: User.self)
                self.currentUser = user
            } catch {
                print("DEBUG: Failed to decode user \(error.localizedDescription)")
            }
        }
    }
    func resetPassword() {
        
    }
}
