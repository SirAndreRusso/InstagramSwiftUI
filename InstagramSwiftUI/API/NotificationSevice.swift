//
//  NotificationSevice.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 08.01.2023.
//

import Firebase

protocol NotificationService {
    
    var user: User { get }
    func fetchNotifications(completion: @escaping ([Notification]) -> Void)
    func uploadNotification(toUid: String, type: NotificationType, post: Post?)
    func fetchNotificationPost(postId: String?, completion: @escaping (Post?) -> Void)
    func fetchNotificationUser(uid: String, completion: @escaping (User?) -> Void)
    
}

class DefaultNotificationService: NotificationService {
    
    let user: User
    
    init(user: User) {
        self.user = user
    }
    
    func fetchNotifications(completion: @escaping ([Notification]) -> Void) {
        guard let uid = user.id else { return }
        let query = COLLECTION_NOTIFICATIONS
            .document(uid)
            .collection("user-notifications")
            .order(by: "timestamp", descending: true)
        
        query.getDocuments { snapshot, error in
            if let error = error {
                print("DEBUG: Failed to fetch notifications"
                      + error.localizedDescription)
            }
            
            guard let documents = snapshot?.documents else { return }
            let notifications = documents.compactMap({ try? $0.data(as: Notification.self)})
            
            completion(notifications)
        }
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
            .collection("user-notifications")
            .addDocument(data: data) { error in
                if let error = error {
                    print("DEBUG: Failed to add notifacation"
                          + error.localizedDescription)
                }
            }
    }
    
    func fetchNotificationPost(postId: String?, completion: @escaping (Post?) -> Void) {
        guard let postId = postId else { return }
        COLLECTION_POSTS
            .document(postId)
            .getDocument { snapshot, error in
                if let error = error {
                    print("DEBUG: Failed to fetch post from notification"
                          + error.localizedDescription)
                }
                let notificationPost = try? snapshot?.data(as: Post.self)
                
                completion(notificationPost)
            }
    }
    
    func fetchNotificationUser(uid: String, completion: @escaping (User?) -> Void) {
        COLLECTION_USERS
            .document(uid)
            .getDocument { snapshot, error in
                if let error = error {
                    print("DEBUG: Failed to fetch user from notification"
                          + error.localizedDescription)
                }
                guard let user = try? snapshot?.data(as: User.self) else { return }
                
                completion(user)
            }
    }
    
}
