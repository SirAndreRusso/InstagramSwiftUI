//
//  ProfileViewModel.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 21.12.2022.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    
    @Published var user: User
    @Published var userStats: UserStats? = nil
    private let followingService: FollowingService
    private let notificationService: NotificationService
    private let userService: UserService
    
    init(user: User,
         followingService: FollowingService,
         notificationService: NotificationService,
         userService: UserService) {
        self.user = user
        self.followingService = followingService
        self.notificationService = notificationService
        self.userService = userService
        checkIfUserIsfollowed()
        fetchUserStats()
    }
    
    func follow() {
        guard let uid = user.id else { return }
        followingService.follow(uid: uid) { [weak self] error in
            if let error = error {
                print("DEBUG: Failed to follow \(self?.user.username ?? "")"
                      + error.localizedDescription)
            } else {
                self?.notificationService.uploadNotification(toUid: uid, type: .follow, post: nil)
                self?.user.isFolowed = true
            }
        }
    }
    
    func unFollow() {
        guard let uid = user.id else { return }
        followingService.unFollow(uid: uid) { [weak self] error in
            if let error = error {
                print("DEBUG: Failed to unfollow \(self?.user.username ?? "")"
                      + error.localizedDescription)
            } else {
                self?.user.isFolowed = false
            }
        }
    }
    
    func checkIfUserIsfollowed() {
        guard
            !user.isCurrentUser,
            let uid = user.id else { return }
        followingService.checkIfUserIsFollowed(uid: uid) { [weak self] isFollowed in
            self?.user.isFolowed = isFollowed
        }
    }
    
    func fetchUserStats() {
        guard let uid = user.id else { return }
        userService.fetchUserStats(uid: uid) { [weak self] userStats in
            self?.userStats = userStats
        }
    }
    
}
