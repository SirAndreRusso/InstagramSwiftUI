//
//  NotificationSevice.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 08.01.2023.
//

import Firebase

protocol NotificationService {
    
    var user: User {get }
    func fetchNotifications()
    func uploadNotification(toUid: String, type: NotificationType, post: Post?)
    
}

class DefaultNotificationService: NotificationService {
    
    let user: User
    
    init(user: User) {
        self.user = user
    }
    
    func fetchNotifications() {
        
    }
    
    func uploadNotification(toUid uid: String, type: NotificationType, post: Post? = nil) {
        var data: [String: Any] = [
            "timestamp": Timestamp(date: Date()),
            "username": user.username,
            "uid": user.id ?? "",
            "profileImageURL": user.profileImageURL,
            "type": type.rawValue,
        ]
        
        if let post = post, let id = post.id {
            data["postId"] = id
        }
        
        COLLECTION_NOTIFICATIONS
            .document(uid)
            .collection("user-notiications")
            .addDocument(data: data) { error in
                if let error = error {
                    print("DEBUG: Failed to add notifacation" + error.localizedDescription)
                }
            }
    }
    
}
