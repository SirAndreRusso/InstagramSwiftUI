//
//  Notification.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 05.01.2023.
//

import FirebaseFirestoreSwift
import Firebase

enum NotificationType: Int, Decodable {
    case like
    case comment
    case follow
    
    var notificationMessage: String {
        switch self {
            
        case .like:
            return "liked your post."
        case .comment:
            return "commented your post."
        case .follow:
            return "started following you."
        }
    }
}

struct Notification: Identifiable, Decodable {
    @DocumentID var id: String?
    let postId: String?
    let username: String
    let profileImageURL: String
    let timestamp: Timestamp
    let type: NotificationType
    let uid: String
    var isFollowed: Bool? = false
    var post: Post?
    var user: User?
}
