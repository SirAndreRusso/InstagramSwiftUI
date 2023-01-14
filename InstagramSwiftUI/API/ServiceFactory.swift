//
//  ServiceFactory.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 09.01.2023.
//

protocol ServiceFactory {
   
    var user: User { get }
    
    func makeAuthService()    
    func makeImageUploader() -> ImageUploader
    func makeFollowingService() -> FollowingService
    func makeNotificationService() -> NotificationService
    func makeLikeService() -> LikeService
    func makePostsService() -> PostService
    func makeUserService() -> UserService
    
}

class DefaultServiceFactory: ServiceFactory {
    
    let user: User
    
    init(user: User) {
        self.user = user
    }
    
    func makeAuthService() {
        
    }
    
    func makeImageUploader() -> ImageUploader {
        DefaultImageUploader()
    }
    
    func makeFollowingService() -> FollowingService {
        DefaultFollowingService()
    }
    
    func makeNotificationService() -> NotificationService {
        DefaultNotificationService(user: user)
    }
    
    func makeLikeService() -> LikeService {
        DefaultLikeService()
    }
    
    func makePostsService() -> PostService {
        DefaultPostService(imageUploader: makeImageUploader())
    }
    
    func makeUserService() -> UserService {
        DefaultUserService()
    }
    
}
