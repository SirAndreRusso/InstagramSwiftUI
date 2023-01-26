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
    weak var router: Router?
    
    init(user: User,
         notificationService: NotificationService,
         likeService: LikeService,
         postsService: PostService,
         router: Router) {
        self.user = user
        self.notificationService = notificationService
        self.likeService = likeService
        self.postsService = postsService
        self.router = router
        fetchPosts()
    }
    
    func fetchPosts() {
        postsService.fetchPosts { [weak self] posts in
            self?.posts = posts
        }
    }
    
    deinit {
        print("DEINIT feed ViewModel")
    }
    
}
