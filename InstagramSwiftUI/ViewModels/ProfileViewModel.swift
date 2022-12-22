//
//  ProfileViewModel.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 21.12.2022.
//

import SwiftUI
class ProfileViewModel: ObservableObject {
    let user: User
    init(user: User) {
        self.user = user
    }
    
    func follow() {
        guard let uid = user.id else { return }
        UserService.follow(uid: uid) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                print("DEBUG: Failed to follow \(self.user.username)" + error.localizedDescription)
            } else {
                print("DEBUG: Successfully folowed the user \(self.user.username)")
            }
        }
    }
    
    func unFollow() {
        print("DEBUG: unfollow \(user)")
    }
    
    func checkIfUserIsfollowed() {
        
    }
}
