//
//  FeedViewModel.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 27.12.2022.
//

import SwiftUI

class FeedViewModel: ObservableObject {
    
    @Published var user: User
    @Published var posts = [Post]()
    private let postsService: PostService
    let notificationService: NotificationService
    let likeService: LikeService
    
    init(user: User,
         notificationService: NotificationService,
         likeService: LikeService,
         postsService: PostService) {
        self.user = user
        self.notificationService = notificationService
        self.likeService = likeService
        self.postsService = postsService
        fetchPosts()
    }
    
    func fetchPosts() {
        postsService.fetchPosts { [weak self] posts in
            self?.posts = posts
        }
    }
    
}
