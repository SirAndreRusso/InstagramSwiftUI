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
    @Published var didSendResetPasswordLink: Bool = false
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    func login(withEmail email: String, password: String) {
        authService.login(withEmail: email, password: password) { [weak self] result in
            switch result {
            case .success(let user):
                self?.userSession = user
                self?.fetchUser()
                print("login")
            case .failure(let error):
                print("DEBUG: Login failed \(error.localizedDescription)")
            }
        }
    }
                           
    func register(withEmail email: String,
                  password: String,
                  image: UIImage?,
                  fullname: String,
                  username: String) {
        authService.register(withEmail: email,
                             password: password,
                             image: image,
                             fullname: fullname,
                             username: username) { [weak self] result in
            switch result {
            case .success(let user):
                self?.userSession = user
                self?.fetchUser()
                print("User data uploaded")
            case .failure(let error):
                print("DEBUG: Can't upload user data to firestore"
                      + error.localizedDescription)
            }
        }
    }
                           
    func signOut() {
        authService.signOut { [weak self] in
            self?.userSession = nil
            print("Signed out")
        }
    }
    
    func fetchUser() {
        guard let uid = userSession?.uid else { return }
        authService.fetchUser(uid: uid) { [weak self] result in
            switch result {
            case .success(let user):
                self?.currentUser = user
                print("User fetched")
            case .failure(let error):
                print("DEBUG: failed to fetch user"
                      + "\(error.localizedDescription)")
            }
        }
    }
    
    func resetPassword(withEmail email: String) {
        authService.resetPassword(withEmail: email) { [weak self] didSendResetPasswordLink in
            self?.didSendResetPasswordLink = didSendResetPasswordLink
        }
    }
    
}
