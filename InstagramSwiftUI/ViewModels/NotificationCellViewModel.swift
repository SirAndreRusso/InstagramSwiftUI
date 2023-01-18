//
//  NotificationCellViewModel.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 16.01.2023.
//

import SwiftUI

class NotificationCellViewModel: ObservableObject {
    
    @Published var notification: Notification
    let followingService: FollowingService
    let notificationService: NotificationService
    
    init(notification: Notification,
         followingService: FollowingService,
         notificationService: NotificationService) {
        self.notification = notification
        self.followingService = followingService
        self.notificationService = notificationService
        checkIfUserIsfollowed()
        fetchNotificationPost()
        fetchNotificationUser()
    }
    
    func follow() {
        followingService.follow(uid: notification.uid) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                print("DEBUG: Failed to follow \(self.notification.username)"
                      + error.localizedDescription)
            } else {
                self.notificationService.uploadNotification(toUid: self.notification.uid,
                                                            type: .follow,
                                                            post: nil)
                self.notification.isFollowed = true
                print("DEBUG: Successfully folowed the user \(self.notification.username)")
            }
        }
    }
    
    func unFollow() {
        followingService.unFollow(uid: notification.uid) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                print("DEBUG: Failed to unfollow \(self.notification.username)" + error.localizedDescription)
            } else {
                self.notification.isFollowed = false
                print("DEBUG: Successfully unfolowed the user \(self.notification.username)")
            }
        }
    }
    
    func checkIfUserIsfollowed() {
        guard notification.type == .follow else { return }
        followingService.checkIfUserIsFollowed(uid: notification.uid) { [weak self] isFollowed in
            guard let self = self else { return }
            self.notification.isFollowed = isFollowed
        }
    }
    
    func fetchNotificationPost() {
        notificationService
            .fetchNotificationPost(postId: notification.postId) { notificationPost in
                self.notification.post = notificationPost
        }
    }
    
    func fetchNotificationUser() {
        notificationService
            .fetchNotificationUser(uid: self.notification.uid) { notificationUser in
                self.notification.user = notificationUser
            }
    }
    
}
