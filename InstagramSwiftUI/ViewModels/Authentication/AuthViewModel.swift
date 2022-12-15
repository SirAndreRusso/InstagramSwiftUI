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
    init() {
        userSession = Auth.auth().currentUser
    }
    
    func login() {
        print("login")
    }
    func register(withEmail email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let user = result?.user else { return }
            self.userSession = user
            print("User registred successfully")
        }
    }
    func signOut() {
        
    }
    func fetchUser() {
        
    }
    func resetPassword() {
        
    }
}
