//
//  NotificationsViewModel.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 05.01.2023.
//

import SwiftUI
import  Firebase

class NotificationsViewModel: ObservableObject {
    
    private let user: User
    let notificationsService: NotificationService
    @Published var notifications = [Notification]()
    
    init(user: User, notificationsService: NotificationService) {
        self.user = user
        self.notificationsService = notificationsService
    }
    
    func fetchNotifications() {
        
    }
    
    func uploadNotification(toUid: String, type: NotificationType, post: Post? = nil) {
//        guard let uid = user.id else { return }
//        var data: [String: Any] = [
//            "timestamp": Timestamp(date: Date()),
//            "username": user.username,
//            "uid": uid,
//            "profileImageURL": user.profileImageURL,
//            "type": type.rawValue,
//        ]
//        if let post = post, let id = post.id {
//            data["postId"] = id
//        }
//        COLLECTION_NOTIFICATIONS
//            .document(uid)
//            .collection("user-notiications")
//            .addDocument(data: data) { error in
//                if let error = error {
//                    print("DEBUG: Failed to add notifacation" + error.localizedDescription)
//                }
//            }
        notificationsService.uploadNotification(toUid: toUid, type: type, post: post)
    }
}
