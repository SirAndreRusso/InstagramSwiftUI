//
//  ServiceFactory.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 09.01.2023.
//

protocol ServiceProvider {
   
    var authService: AuthService { get }
    var commentService: CommentService { get }
    var followingService: FollowingService { get }
    var imageUploader: ImageUploader { get }
    var likeService: LikeService { get }
    var notificationService: NotificationService { get }
    var postService: PostService { get }
    var userService: UserService { get }
    
}

final class DefaultServiceProvider {
    
    lazy private(set) var authService: AuthService = DefaultAuthService(imageUploader: imageUploader)
    lazy private(set) var commentService:  CommentService = DefaultCommentService()
    lazy private(set) var followingService: FollowingService = DefaultFollowingService()
    lazy private(set) var imageUploader: ImageUploader = DefaultImageUploader()
    lazy private(set) var likeService: LikeService = DefaultLikeService()
    lazy private(set) var notificationService: NotificationService = DefaultNotificationService()
    lazy private(set) var postService: PostService = DefaultPostService(imageUploader: imageUploader)
    lazy private(set) var userService: UserService = DefaultUserService()
    
}

extension DefaultServiceProvider: ServiceProvider {}
