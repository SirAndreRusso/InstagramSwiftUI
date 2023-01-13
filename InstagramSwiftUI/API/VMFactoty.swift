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
        
        FeedViewModel(user: user, notificationService: serviceFactory.makeNotificationService())
    }
    
    func makeSearchViewModel() -> SearchViewModel {
        SearchViewModel()
    }
    
    func makeNotificationsViewModel() -> NotificationsViewModel {
        NotificationsViewModel(user: user,
                                      notificationsService: serviceFactory.makeNotificationService())
    }
    
    func makeProfileViewModel(user: User? = nil) -> ProfileViewModel {
        if let user = user {
            return ProfileViewModel(user: user,
                                    followingService: serviceFactory.makeFollowingService(),
                                    notificationService: serviceFactory.makeNotificationService())
        }
        
        return ProfileViewModel(user: self.user,
                                followingService: serviceFactory.makeFollowingService(),
                                notificationService: serviceFactory.makeNotificationService())
    }
    
    func makeCommentsViewModel(user: User, post: Post) -> CommentsViewModel {
        CommentsViewModel(post: post,
                         user: user,
                         notificationService: serviceFactory.makeNotificationService())
    }
    
}
