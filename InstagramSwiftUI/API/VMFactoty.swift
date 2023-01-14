//
//  VMBuilder.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 09.01.2023.
//

class VMFactoty {
    
    let user: User
    let serviceFactory: ServiceFactory
    
    init(user: User, serviceFactory: ServiceFactory) {
        self.user = user
        self.serviceFactory = serviceFactory
    }
    
    func makeUploadPostViewModel() -> UploadPostViewModel {
        let imageUploader = serviceFactory.makeImageUploader()
        return UploadPostViewModel(user: user, imageUploader: imageUploader)
    }
    
    func makeFeedViewModel() -> FeedViewModel {
        let notificationService = serviceFactory.makeNotificationService()
        let likeService = serviceFactory.makeLikeService()
        return FeedViewModel(user: user,
                             notificationService: notificationService, likeService: likeService)
    }
    
    
    func makeSearchViewModel() -> SearchViewModel {
        SearchViewModel()
    }
    
    func makeNotificationsViewModel() -> NotificationsViewModel {
        let notificationService = serviceFactory.makeNotificationService()
        return NotificationsViewModel(user: user, notificationsService: notificationService)
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
        return CommentsViewModel(post: post,
                         user: user,
                         notificationService: notificationService)
    }
    
}
