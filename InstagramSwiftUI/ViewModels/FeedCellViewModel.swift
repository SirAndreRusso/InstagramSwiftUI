//
//  FeedCellViewModel.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 01.01.2023.
//

import SwiftUI
import Combine

class FeedCellViewModel: ObservableObject {
    
    @Published var post: Post
    @Published var currentUser: User
    @Published var postOwner: User? = nil
    @Published var timestampString = ""
    @Published var likeString = ""
    private let notificationService: NotificationService
    private let likeService: LikeService
    private let userService: UserService
    private var cancellables: Set<AnyCancellable> = []
    weak var router: Router?
    
    
    
    
    func getLikeString() {
        let label = post.likes == 1 ? "like" : "likes"
        self.likeString =  "\(post.likes) \(label)"
    }
    func getTimestampString(){
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfYear, .month]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        self.timestampString = formatter.string(from: post.timeStamp.dateValue(), to: Date()) ?? ""
    }
    
    init(post: Post,
         user: User,
         notificationService: NotificationService,
         likeService: LikeService,
         userService: UserService,
         router: Router) {
        self.post = post
        self.currentUser = user
        self.notificationService = notificationService
        self.likeService = likeService
        self.userService = userService
        self.router = router
        checkIfUserLikedPost()
        fetchPostOwner()
        getLikeString()
        getTimestampString()
    }
    
    func like() {
        likeService.like(post: post) { [weak self] in
            guard let self = self else { return }
            self.post.didLike = true
            self.post.likes += 1
            if self.post.ownerUid != self.currentUser.id {
                self.notificationService.uploadNotification(fromUser: self.currentUser,
                                                            toUid: self.post.ownerUid,
                                                            type: .like,
                                                            post: self.post)
                self.getLikeString()
            }
        }
    }
    
    func unLike() {
        likeService.unLike(post: post) { [weak self] in
            guard let self = self else { return }
            self.post.didLike = false
            self.post.likes -= 1
            self.getLikeString()
        }
    }
    
    func checkIfUserLikedPost() {
        self.likeService.checkIfUserLikedPost(post: post) { [weak self] didLike in
            guard let self = self else { return }
            self.post.didLike = didLike
        }
    }
    
    func fetchPostOwner() {
        Task {
            await userService.fetchPostOwner(uid: post.ownerUid)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("DEBUG: Failed to fetch post owner" + error.localizedDescription)
                    }
                } receiveValue: { [weak self] postOwner in
                    self?.postOwner = postOwner
                }
                .store(in: &cancellables)
        }
    }
    
    deinit {
        print("DEINIT feedcell ViewModel")
    }
    
}
