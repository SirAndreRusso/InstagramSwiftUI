//
//  VMBuilder.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 09.01.2023.
//
protocol VMFactory {
    
    var user: User { get }
    var serviceFactory: ServiceFactory { get }
    
    func makeCommentsViewModel(user: User, post: Post) -> CommentsViewModel
    func makeFeedViewModel() -> FeedViewModel
    func makeFeedCellViewModel(post: Post?,
                               user: User?,
                               notificationService: NotificationService?,
                               likeService: LikeService?) -> FeedCellViewModel?
    func makeNotificationsViewModel() -> NotificationsViewModel
    func makeNotificationCellViewModel(notification: Notification?) -> NotificationCellViewModel?
    func makePostGreedViewModel(config: PostGreedConfiguration?) -> PostGreedViewModel?
    func makeProfileViewModel(user: User?) -> ProfileViewModel
    func makeSearchViewModel() -> SearchViewModel
    func makeUploadPostViewModel() -> UploadPostViewModel
    
}

class DefaultVMFactory: VMFactory {
    
    let user: User
    let serviceFactory: ServiceFactory
    
    init(user: User, serviceFactory: ServiceFactory) {
        self.user = user
        self.serviceFactory = serviceFactory
    }
    
    func makeUploadPostViewModel() -> UploadPostViewModel {
        let postsService = serviceFactory.makePostsService()
        return UploadPostViewModel(user: user, postsService: postsService)
    }
    
    func makeFeedViewModel() -> FeedViewModel {
        let notificationService = serviceFactory.makeNotificationService()
        let likeService = serviceFactory.makeLikeService()
        let postsService = serviceFactory.makePostsService()
        return FeedViewModel(user: user,
                             notificationService: notificationService,
                             likeService: likeService,
                             postsService: postsService)
    }
    
    func makeFeedCellViewModel(post: Post? = nil,
                               user: User? = nil,
                               notificationService: NotificationService? = nil,
                               likeService: LikeService? = nil) -> FeedCellViewModel? {
        guard let user = user,
              let post = post,
              let notificationService = notificationService,
              let likeService = likeService else {
            return nil
        }
        
        return FeedCellViewModel(post: post, user: user, notificationService: notificationService, likeService: likeService)
    }
    
    func makeSearchViewModel() -> SearchViewModel {
        let userService = serviceFactory.makeUserService()
        return SearchViewModel(userService: userService)
    }
    
    func makeNotificationsViewModel() -> NotificationsViewModel {
        let notificationService = serviceFactory.makeNotificationService()
        return NotificationsViewModel(user: user, notificationsService: notificationService)
    }
    
    func makeNotificationCellViewModel(notification: Notification? = nil) -> NotificationCellViewModel? {
        guard let notification = notification else { return nil }
        let followingService = serviceFactory.makeFollowingService()
        let notificationService = serviceFactory.makeNotificationService()
        
        return NotificationCellViewModel(notification: notification,
                                         followingService: followingService,
                                         notificationService: notificationService)
    }
    
    func makePostGreedViewModel(config: PostGreedConfiguration? = nil) -> PostGreedViewModel? {
        guard let config = config else { return nil }
        let postService = serviceFactory.makePostsService()
        
        return PostGreedViewModel(config: config, postService: postService)
    }
    
    func makeProfileViewModel(user: User? = nil) -> ProfileViewModel {
        let followingService = serviceFactory.makeFollowingService()
        let notificationService = serviceFactory.makeNotificationService()
        
        if let user = user {
            return ProfileViewModel(user: user,
                                    followingService: followingService,
                                    notificationService: notificationService)
        }
        
        return ProfileViewModel(user: self.user,
                                followingService: followingService,
                                notificationService: notificationService)
    }
    
    func makeCommentsViewModel(user: User, post: Post) -> CommentsViewModel {
        let notificationService = serviceFactory.makeNotificationService()
        let commentService = serviceFactory.makeCommentService()
        return CommentsViewModel(post: post,
                         user: user,
                                 notificationService: notificationService,
                                 commentService: commentService)
    }
    
}
