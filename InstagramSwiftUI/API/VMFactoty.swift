//
//  VMBuilder.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 09.01.2023.
//

class VMFactoty {
    
    let user: User
    
    init(user: User) {
        self.user = user
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
        return NotificationsViewModel(user: user)
    }
    
    func makeProfileViewModel() -> ProfileViewModel {
        return ProfileViewModel(user: user)
    }
}
