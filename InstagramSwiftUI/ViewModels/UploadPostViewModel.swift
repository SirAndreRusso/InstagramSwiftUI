//
//  UploadPostViewModel.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 24.12.2022.
//

import SwiftUI
import Firebase

class UploadPostViewModel: ObservableObject {
    // find out if we can use viewmodel inside viewmodel
    init (user: User, imageUploader: ImageUploader) {
        self.user = user
        self.imageUploader = imageUploader
    }
    var user : User
    var imageUploader: ImageUploader
    
    func uploadPost(caption: String, image: UIImage, completion:  ((Error?) -> Void)?) {
        //        guard let user = authViewModel.currentUser else { return }
        imageUploader.uploadImage(image: image, type: .post) { [weak self] imageURL in
            guard let self = self else { return }
            let data: [String : Any] = ["caption" : caption,
                                        "timeStamp": Timestamp(date: Date()),
                                        "likes" : 0,
                                        "imageURL" : imageURL,
                                        "ownerUid" : self.user.id ?? "",
                                        "ownerImageURL" : self.user.profileImageURL,
                                        "ownerUsername" : self.user.username] as [String : Any]
            
            COLLECTION_POSTS.addDocument(data: data, completion: completion)
            
        }
        
    }
}
