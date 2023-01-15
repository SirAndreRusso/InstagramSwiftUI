//
//  NotificationsViewModel.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 05.01.2023.
//

import SwiftUI

class NotificationsViewModel: ObservableObject {
    
    @Published var notifications = [Notification]()
    private let user: User
    private let notificationsService: NotificationService
    
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
