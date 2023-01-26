//
//  NotificationsViewModel.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 05.01.2023.
//

import SwiftUI

class NotificationsViewModel: ObservableObject {
    
    @Published var notifications = [Notification]()
    let user: User
    private let notificationsService: NotificationService
    weak var router: Router?
    
    init(user: User, router: Router, notificationsService: NotificationService) {
        self.user = user
        self.router = router
        self.notificationsService = notificationsService
        fetchNotifications(currentUser: user)
    }
    
    func fetchNotifications(currentUser: User) {
        notificationsService.fetchNotifications(currentUser: currentUser) { [weak self] notifications in
            self?.notifications = notifications
        }
    }
    
    deinit {
        print("DEINIT Notifications ViewModel")
    }
}
