//
//  UploadPostViewModel.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 24.12.2022.
//

import SwiftUI
import Firebase

class UploadPostViewModel: ObservableObject {
    
    var user : User
    var postsService: PostService
    
    init (user: User, postsService: PostService) {
        self.user = user
        self.postsService = postsService
    }
    
    func uploadPost(caption: String, image: UIImage, completion:  ((Error?) -> Void)?) {
        postsService.uploadPost(user: user, caption: caption, image: image, completion: completion)
    }
    
}
