//
//  EditProfileViewModel.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 21.01.2023.
//

import SwiftUI
import Combine

class EditProfileViewModel: ObservableObject {
    
    @Published var saveDataComplete: Bool = false
    private var user: User
    private var cancellables: Set<AnyCancellable> = []
    private let userService: UserService
    weak var router: Router?
    
    init(user: User, userService: UserService, router: Router) {
        self.user = user
        self.userService = userService
        self.router = router
    }
    
    func saveUserData(bio: String) {
        guard let uid = user.id else { return }
        Task {
            await userService.saveUserData(uid: uid, bio: bio)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("DEBUG: Failed to save user's data" + error.localizedDescription)
                    }
                } receiveValue: { [weak self] saveDataComplete in
                    self?.user.bio = bio
                    self?.saveDataComplete = saveDataComplete
                }
                .store(in: &cancellables)
        }
    }
    
    deinit {
        print("DEINIT edit profile ViewModel")
    }
    
}
