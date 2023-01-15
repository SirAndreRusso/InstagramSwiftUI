//
//  FeedCellViewModel.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 01.01.2023.
//

import SwiftUI

class FeedCellViewModel: ObservableObject {
    
    @Published var post: Post
    @Published var user: User
    private let notificationService: NotificationService
    private let likeService: LikeService
    var likeString: String {
        let label = post.likes == 1 ? "like" : "likes"
        return "\(post.likes) \(label)"
    }
    
    init(post: Post, user: User, notificationService: NotificationService, likeService: LikeService) {
        self.post = post
        self.user = user
        self.notificationService = notificationService
        self.likeService = likeService
        checkIfUserLikedPost()
    }
    
    func like() {
        likeService.like(post: post) {
            self.post.didLike = true
            self.post.likes += 1
            self.notificationService.uploadNotification(toUid: self.post.ownerUid,
                                                        type: .like,
                                                        post: self.post)
        }
    }
    
    func unLike() {
        likeService.unLike(post: post) {
            self.post.didLike = false
            self.post.likes -= 1
        }
    }
    
    func checkIfUserLikedPost() {
        self.likeService.checkIfUserLikedPost(post: post) { didLike in
            self.post.didLike = didLike
        }
    }
    
}
