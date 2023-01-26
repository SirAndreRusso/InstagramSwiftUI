//
//  VMBuilder.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 09.01.2023.
//

protocol VMFactory {
    
    func makeAuthViewModel(authService: AuthService, router: Router) -> AuthViewModel
    func makeCommentsViewModel(user: User, post: Post, router: Router) -> CommentsViewModel
    func makeEditProfileViewModel(user: User, router: Router) -> EditProfileViewModel
    func makeFeedViewModel(user: User, router: Router) -> FeedViewModel
    func makeFeedCellViewModel(post: Post,
                               user: User,
                               router: Router,
                               likeService: LikeService?,
                               notificationService: NotificationService?
                               ) -> FeedCellViewModel
    func makeNotificationsViewModel(user: User, router: Router) -> NotificationsViewModel
    func makeNotificationCellViewModel(notification: Notification, router: Router) -> NotificationCellViewModel
    func makePostGreedViewModel(config: PostGreedConfiguration, router: Router) -> PostGreedViewModel
    func makeProfileViewModel(user: User, router: Router) -> ProfileViewModel
    func makeProfileHeaderViewModel(user: User, router: Router) -> ProfileHeaderViewModel
    func makeSearchViewModel(router: Router) -> SearchViewModel
    func makeUploadPostViewModel(user: User, router: Router) -> UploadPostViewModel
    
}

final class DefaultVMFactory: VMFactory {
    
    private let serviceProvider: ServiceProvider
    
    init(serviceFactory: ServiceProvider) {
        self.serviceProvider = serviceFactory
    }
    
    func makeAuthViewModel(authService: AuthService, router: Router) -> AuthViewModel {
        AuthViewModel(authService: authService, router: router)
    }
    
    func makeUploadPostViewModel(user: User, router: Router) -> UploadPostViewModel {
        UploadPostViewModel(user: user, postsService: serviceProvider.postService, router: router)
    }
    
    func makeEditProfileViewModel(user: User, router: Router) -> EditProfileViewModel {
        EditProfileViewModel(user: user, userService: serviceProvider.userService, router: router)
    }
    
    func makeFeedViewModel(user: User, router: Router) -> FeedViewModel {
        FeedViewModel(user: user,
                             notificationService: serviceProvider.notificationService,
                             likeService: serviceProvider.likeService,
                             postsService: serviceProvider.postService,
                             router: router)
    }
    
    func makeFeedCellViewModel(post: Post,
                               user: User,
                               router: Router,
                               likeService: LikeService? = nil,
                               notificationService: NotificationService? = nil
                               ) -> FeedCellViewModel {

         FeedCellViewModel(post: post, user: user, notificationService: serviceProvider.notificationService, likeService: serviceProvider.likeService, userService: serviceProvider.userService, router: router)
    }
    
    func makeSearchViewModel(router: Router) -> SearchViewModel {
        SearchViewModel(userService: serviceProvider.userService, router: router)
    }
    
    func makeNotificationsViewModel(user: User, router: Router) -> NotificationsViewModel {
        NotificationsViewModel(user: user, router: router, notificationsService: serviceProvider.notificationService)
    }
    
    func makeNotificationCellViewModel(notification: Notification, router: Router) -> NotificationCellViewModel {
        NotificationCellViewModel(notification: notification,
                                  followingService: serviceProvider.followingService,
                                  notificationService: serviceProvider.notificationService,
                                  router: router)
    }
    
    func makePostGreedViewModel(config: PostGreedConfiguration, router: Router) -> PostGreedViewModel {
        PostGreedViewModel(config: config, postService: serviceProvider.postService, router: router)
    }
    
    func makeProfileViewModel(user: User, router: Router) -> ProfileViewModel {
        ProfileViewModel(user: user, router: router)
    }
    
    func makeProfileHeaderViewModel(user: User, router: Router) -> ProfileHeaderViewModel {
        ProfileHeaderViewModel(user: user, router: router,
                                followingService: serviceProvider.followingService,
                                notificationService: serviceProvider.notificationService,
                                userService: serviceProvider.userService)
    }
    
    func makeCommentsViewModel(user: User, post: Post, router: Router) -> CommentsViewModel {
        CommentsViewModel(post: post,
                         user: user,
                                 notificationService: serviceProvider.notificationService,
                                 commentService: serviceProvider.commentService, router: router)
    }
    
}
