//
//  UploadPostViewModel.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 24.12.2022.
//

import SwiftUI

class UploadPostViewModel: ObservableObject {
    
    private let user: User
    private let postService: PostService
    weak var router: Router?
    
    init (user: User, postsService: PostService, router: Router) {
        self.user = user
        self.postService = postsService
        self.router = router
    }
    
    func uploadPost(caption: String, image: UIImage, completion:  ((Error?) -> Void)?) {
        postService.uploadPost(user: user, caption: caption, image: image, completion: completion)
    }
    
    deinit {
        print("DEINIT uploadpost ViewModel")
    }
    
}
