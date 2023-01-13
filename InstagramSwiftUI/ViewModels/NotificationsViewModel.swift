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
        notificationsService.uploadNotification(toUid: toUid, type: type, post: post)
    }
}
