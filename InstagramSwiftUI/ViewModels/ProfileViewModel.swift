//
//  ProfileViewModel.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 21.12.2022.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    
   @Published var user: User
    let followingService: FollowingService
    
    init(user: User, followingService: FollowingService) {
        self.user = user
        self.followingService = followingService
        checkIfUserIsfollowed()
    }
    
    func follow() {
        guard let uid = user.id else { return }
        followingService.follow(uid: uid) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                print("DEBUG: Failed to follow \(self.user.username)" + error.localizedDescription)
            } else {
                self.user.isFolowed = true
                print("DEBUG: Successfully folowed the user \(self.user.username)")
            }
        }
    }
    
    func unFollow() {
        guard let uid = user.id else { return }
        followingService.unFollow(uid: uid) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                print("DEBUG: Failed to unfollow \(self.user.username)" + error.localizedDescription)
            } else {
                self.user.isFolowed = false
                print("DEBUG: Successfully unfolowed the user \(self.user.username)")
            }
        }
    }
    
    func checkIfUserIsfollowed() {
        guard
            !user.isCurrentUser,
            let uid = user.id else { return }
        followingService.checkIfUserIsFollowed(uid: uid) { [weak self] isFollowed in
            guard let self = self else { return }
            self.user.isFolowed = isFollowed
        }
    }
}
