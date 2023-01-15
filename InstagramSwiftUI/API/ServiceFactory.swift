//
//  ServiceFactory.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 09.01.2023.
//

protocol ServiceFactory {
   
    var user: User { get }
    
    func makeAuthService()
    func makeCommentService() -> CommentService
    func makeFollowingService() -> FollowingService
    func makeImageUploader() -> ImageUploader
    func makeLikeService() -> LikeService
    func makeNotificationService() -> NotificationService
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
    
    func makeCommentService() -> CommentService {
        DefaultCommentService()
    }
    
    func makeFollowingService() -> FollowingService {
        DefaultFollowingService()
    }
    
    func makeImageUploader() -> ImageUploader {
        DefaultImageUploader()
    }
    
    func makeLikeService() -> LikeService {
        DefaultLikeService()
    }
    
    func makeNotificationService() -> NotificationService {
        DefaultNotificationService(user: user)
    }
    
    func makePostsService() -> PostService {
        DefaultPostService(imageUploader: makeImageUploader())
    }
    
    func makeUserService() -> UserService {
        DefaultUserService()
    }
    
}
