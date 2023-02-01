//
//  AuthViewModel.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 15.12.2022.
//

import SwiftUI
import Firebase
import Combine

class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var didSendResetPasswordLink: Bool = false
    private let authService: AuthService
    private var cancellables: Set<AnyCancellable> = []
    var router: Router?
    
    init(authService: AuthService, router: Router) {
        self.authService = authService
        self.router = router
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    func login(withEmail email: String, password: String)  {
        Task {
            await authService.login(withEmail: email, password: password)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("Failed to login" + error.localizedDescription)
                    }
                } receiveValue: { [weak self] userSession in
                    self?.userSession = userSession
                }
                .store(in: &cancellables)
        }
    }
    
    func register(withEmail email: String,
                  password: String,
                  image: UIImage?,
                  fullname: String,
                  username: String) {
        Task {
            await authService.register(withEmail: email, password: password, image: image, fullname: fullname, username: username)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("Failed to register" +  error.localizedDescription)
                    }
                } receiveValue: { [weak self] userSession in
                    self?.userSession = userSession
                }
                .store(in: &cancellables)
        }
        
    }
    
    func signOut() {
        Task {
            await authService.signOut()
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("Failed to sign out" +  error.localizedDescription)
                    }
                } receiveValue: { [weak self] didSignedOut in
                    
                    self?.userSession = nil
                }
                .store(in: &cancellables)
        }
    }
    
    func fetchUser() {
        guard let uid = userSession?.uid else { return }
        Task {
            await authService.fetchUser(uid: uid)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("Failed to fetch user" + error.localizedDescription)
                    }
                } receiveValue: { [weak self] user in
                    self?.currentUser = user
                }
                .store(in: &cancellables)
        }
    }
    
    func resetPassword(withEmail email: String) {
        Task {
            await authService.resetPassword(withEmail: email)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("Failed send reset password link" + error.localizedDescription)
                    }
                } receiveValue: { [weak self] didSendResetPasswordLink in
                    self?.didSendResetPasswordLink = didSendResetPasswordLink
                }
                .store(in: &cancellables)
        }
    }
    
}
