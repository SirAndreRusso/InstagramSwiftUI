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
    let config: PostGreedConfiguration
    
    init(config: PostGreedConfiguration) {
        self.config = config
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
        COLLECTION_POSTS.getDocuments { snapShot, error in
            if let error = error {
                print("DEBUG: Failed to fetch search page posts \(error.localizedDescription)")
                return
            }
            guard let documents = snapShot?.documents else { return }
            self.posts = documents.compactMap({ try? $0.data(as: Post.self)})
            print(self.posts)
        }
    }
    
    func fetchUserPosts(forUid uid: String) {
        COLLECTION_POSTS.whereField("ownerUid", isEqualTo: uid).getDocuments { snapShot, error in
            if let error = error {
                print("DEBUG: Failed to fetch user's posts \(error.localizedDescription)")
                return
            }
            guard let documents = snapShot?.documents else { return }
            self.posts = documents.compactMap({ try? $0.data(as: Post.self)})
            print(self.posts)
        }
    }
}
