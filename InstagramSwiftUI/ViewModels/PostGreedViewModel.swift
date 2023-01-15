//
//  PostGreedViewModel.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 31.12.2022.
//

import SwiftUI

enum PostGreedConfiguration {
    
    case search
    case profile(String)
    
}

class PostGreedViewModel: ObservableObject {
    
    @Published var posts = [Post]()
    private let postService: PostService
    private let config: PostGreedConfiguration
    
    init(config: PostGreedConfiguration, postService: PostService) {
        self.config = config
        self.postService = postService
        fetchPosts(forConfig: config)
    }
    
    func fetchPosts(forConfig config: PostGreedConfiguration) {
        switch config {
            
        case .search:
            fetchSearchPosts()
        case .profile(let uid):
            fetchUserPosts(forUid: uid)
        }
    }
    
    func fetchSearchPosts() {
        postService.fetchSearchPosts { posts in
            self.posts = posts
        }
    }
    
    func fetchUserPosts(forUid uid: String) {
        postService.fetchUserPosts(forUid: uid) { posts in
            self.posts = posts
        }
    }
    
}
