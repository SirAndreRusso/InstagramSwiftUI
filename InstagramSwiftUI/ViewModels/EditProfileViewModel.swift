//
//  EditProfileViewModel.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 21.01.2023.
//

import SwiftUI

class EditProfileViewModel: ObservableObject {
    
    @Published var saveDataComplete: Bool = false
    private var user: User
    private let userService: UserService
    
    init(user: User, userService: UserService) {
        self.user = user
        self.userService = userService
    }
    
    func saveUserData(bio: String) {
        guard let uid = user.id else { return }
        userService.saveUserData(uid: uid, bio: bio) { [weak self] in
            self?.user.bio = bio
            self?.saveDataComplete = true
        }
    }
    
}
