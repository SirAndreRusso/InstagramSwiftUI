//
//  UploadPostViewModel.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 24.12.2022.
//

import SwiftUI

class UploadPostViewModel: ObservableObject {
    
    var user : User
    var postService: PostService
    
    init (user: User, postsService: PostService) {
        self.user = user
        self.postService = postsService
    }
    
    func uploadPost(caption: String, image: UIImage, completion:  ((Error?) -> Void)?) {
        postService.uploadPost(user: user, caption: caption, image: image, completion: completion)
    }
    
}
