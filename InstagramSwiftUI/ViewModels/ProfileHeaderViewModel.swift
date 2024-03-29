//
//  ProfileHeaderViewModel.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 26.01.2023.
//

import SwiftUI
import Combine

class ProfileHeaderViewModel: ObservableObject {
    
    @Published var user: User
    @Published var userStats: UserStats? = nil
    @Published var saveDataComplete: Bool = false
    weak var router: Router?
    private let followingService: FollowingService
    private let notificationService: NotificationService
    private let userService: UserService
    private var cancellables: Set<AnyCancellable> = []
    
    init(user: User,
         router: Router,
         followingService: FollowingService,
         notificationService: NotificationService,
         userService: UserService) {
        self.user = user
        self.followingService = followingService
        self.notificationService = notificationService
        self.userService = userService
        self.router = router
        checkIfUserIsfollowed()
        fetchUserStats()
        fetchUser()
    }
    
    func follow() {
        guard let uid = user.id else { return }
        followingService.follow(uid: uid) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                print("DEBUG: Failed to follow \(self.user.username)"
                      + error.localizedDescription)
            } else {
                self.notificationService.uploadNotification(fromUser: self.user, toUid: uid, type: .follow, post: nil)
                self.user.isFolowed = true
                self.fetchUserStats()
            }
        }
    }
    
    func unFollow() {
        guard let uid = user.id else { return }
        followingService.unFollow(uid: uid) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                print("DEBUG: Failed to unfollow \(self.user.username)"
                      + error.localizedDescription)
            } else {
                self.user.isFolowed = false
                print("DEBUG: Successfully unfolowed the user \(self.user.username)")
                self.fetchUserStats()
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
    
    func fetchUserStats() {
        guard let uid = user.id else { return }
        Task {
            await userService.fetchUserStats(uid: uid)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("DEBUG: Failed to fetch user" + error.localizedDescription)
                    }
                } receiveValue: { [weak self] userStats in
                    self?.userStats = userStats
                }
                .store(in: &cancellables)
        }
    }
    
    func fetchUser() {
        guard let uid = user.id else { return }
        Task {
            await userService.fetchUser(uid: uid)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("DEBUG: Failed to fetch user" + error.localizedDescription)
                    }
                } receiveValue: { [weak self] user in
                    self?.user = user
                }
                .store(in: &cancellables)
        }
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
                        print("DEBUG: Failed to save user data" + error.localizedDescription)
                    }
                } receiveValue: { [weak self] saveDataComplete in
                    self?.user.bio = bio
                    self?.saveDataComplete = saveDataComplete
                }
                .store(in: &cancellables)
        }
    }
    
}

