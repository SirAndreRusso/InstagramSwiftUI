//
//  NotificationCellViewModel.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 16.01.2023.
//

import SwiftUI

class NotificationCellViewModel: ObservableObject {
    
    @Published var notification: Notification
    var timestampString = ""
    var user: User
    let followingService: FollowingService
    let notificationService: NotificationService
    weak var router: Router?
    
    init(notification: Notification,
         followingService: FollowingService,
         notificationService: NotificationService,
         user: User,
         router: Router) {
        self.notification = notification
        self.followingService = followingService
        self.notificationService = notificationService
        self.user = user
        self.router = router
        checkIfUserIsfollowed()
        fetchNotificationPost()
        fetchNotificationUser()
        getTimestampString()
    }
    
    func getTimestampString() {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfYear, .month]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        
        self.timestampString = formatter.string(from: notification.timestamp.dateValue(), to: Date()) ?? ""
    }
    
    func follow() {
        followingService.follow(uid: notification.uid) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                print("DEBUG: Failed to follow \(self.notification.username)"
                      + error.localizedDescription)
            } else {
                self.notificationService.uploadNotification(fromUser: self.user,
                                                            toUid: self.notification.uid,
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
            self?.notification.isFollowed = isFollowed
        }
    }
    
    func fetchNotificationPost() {
        notificationService
            .fetchNotificationPost(postId: notification.postId) { [weak self] notificationPost in
                self?.notification.post = notificationPost
        }
    }
    
    func fetchNotificationUser() {
        notificationService
            .fetchNotificationUser(uid: self.notification.uid) { [weak self] notificationUser in
                self?.notification.user = notificationUser
            }
    }
    
    deinit {
        print("DEINIT Notifications cell ViewModel")
    }
    
}
