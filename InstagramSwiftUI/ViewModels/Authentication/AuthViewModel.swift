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
    //    static let shared = AuthViewModel()
    init() {
        userSession = Auth.auth().currentUser
    }
    
    func login() {
        print("login")
    }
    func register(withEmail email: String, password: String, image: UIImage?, fullname: String, username: String) {
        guard let image = image else { return }
        ImageUoloader.uploadImage(image: image) { imageUrl in
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
                Firestore.firestore().collection("users").document(user.uid).setData(data) { error in
                    if let error = error {
                        print("DEBUG: Can't upload user data to firestore" + error.localizedDescription)
                        return
                    }
                    self.userSession = user
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
        
    }
    func resetPassword() {
        
    }
}
