//
//  FeedViewModel.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 27.12.2022.
//

import SwiftUI

class FeedViewModel: ObservableObject {
    @Published var user: User
    init(user: User) {
        self.user = user
        fetchPosts()
    }
    @Published var posts = [Post]()
    
    func fetchPosts() {
        COLLECTION_POSTS.getDocuments { snapShot, error in
            if let error = error {
                print("DEBUG: Failed to fetch posts \(error.localizedDescription)")
                return
            }
            guard let documents = snapShot?.documents else { return }
            self.posts = documents.compactMap({ try? $0.data(as: Post.self)})
            print(self.posts)
        }
    }
}
