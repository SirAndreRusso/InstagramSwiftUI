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
        let imageUploader = ImageUploaderServiceImpl()
        return UploadPostViewModel(user: user, imageUploader: imageUploader)
    }
    
    func makeFeedViewModel() -> FeedViewModel {
        
        return FeedViewModel(user: user)
    }
    
    func makeSearchViewModel() -> SearchViewModel {
        return SearchViewModel()
    }
    
    func makeNotificationsViewModel() -> NotificationsViewModel {
        return NotificationsViewModel(user: user,
                                      notificationsService: serviceFactory.makeNotificationService())
    }
    
    func makeProfileViewModel(user: User? = nil) -> ProfileViewModel {
        if let user = user {
            return ProfileViewModel(user: user)
        }
        return ProfileViewModel(user: self.user)
    }
    
}
