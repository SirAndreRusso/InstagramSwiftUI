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
    func register() {
        print("register")
    }
    func signOut() {
        
    }
    func fetchUser() {
        
    }
    func resetPassword() {
        
    }
}
