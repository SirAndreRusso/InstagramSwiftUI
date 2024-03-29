//
//  AuthViewModel.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 15.12.2022.
//

import SwiftUI
import Combine

class AuthViewModel: ObservableObject {
    
    @Published var isLoadig = false
    @Published var currentUser: User?
    @Published var didSendResetPasswordLink: Bool = false
    private let authService: AuthService
    private var cancellables: Set<AnyCancellable> = []
    var router: Router?
    
    init(authService: AuthService, router: Router) {
        self.authService = authService
        self.router = router
        fetchUser()
    }
    
    func fetchUser() {
        isLoadig = true
        authService.fetchUser()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("DEBUG: Failed to fetch user" + error.localizedDescription)
                }
            } receiveValue: { [weak self] user in
                self?.currentUser = user
                self?.isLoadig = false
            }
            .store(in: &cancellables)
        
    }
    
    func login(withEmail email: String, password: String)  {
        authService.login(withEmail: email, password: password)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("DEBUG: Failed to login" + error.localizedDescription)
                }
            } receiveValue: { [weak self] userIsLogedIn in
                self?.fetchUser()
            }
            .store(in: &cancellables)
    }
    
    func register(withEmail email: String,
                  password: String,
                  image: UIImage?,
                  fullname: String,
                  username: String) {
        authService.register(withEmail: email, password: password, image: image, fullname: fullname, username: username)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("DEBUG: Failed to register" +  error.localizedDescription)
                }
            } receiveValue: { [weak self] userIsLogedIn in
                self?.fetchUser()
            }
            .store(in: &cancellables)
    }
    
    func signOut() {
        authService.signOut()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.currentUser = nil
                case .failure(let error):
                    print("DEBUG: Failed to sign out" +  error.localizedDescription)
                }
            } receiveValue: { _ in
                
            }
            .store(in: &cancellables)
    }
    
    func resetPassword(withEmail email: String) {
        authService.resetPassword(withEmail: email)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("DEBUG: Failed send reset password link" + error.localizedDescription)
                }
            } receiveValue: { [weak self] didSendResetPasswordLink in
                self?.didSendResetPasswordLink = didSendResetPasswordLink
            }
            .store(in: &cancellables)
    }
    
}
