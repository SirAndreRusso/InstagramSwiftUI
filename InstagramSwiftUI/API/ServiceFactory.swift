//
//  ServiceFactory.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 09.01.2023.
//



class ServiceFactory {
    let user: User
    
    init(user: User) {
        self.user = user
    }
    
    func makeAuthService() {
        
    }
    
    func makeImageUploaderService() {
        
    }
    
    func makeUserService() {
        
    }
    
    func makeNotificationService() -> NotificationService {
        return NotificationServiceImpl(user: user)
    }
}
