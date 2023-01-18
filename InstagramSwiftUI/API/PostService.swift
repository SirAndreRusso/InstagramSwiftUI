//
//  PostSservice.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 14.01.2023.
//

import UIKit
import Firebase

protocol PostService {
    
    var imageUploader: ImageUploader { get }
    
    func fetchPosts(completion: @escaping ([Post]) -> Void)
    func fetchSearchPosts(completion: @escaping ([Post]) -> Void)
    func fetchUserPosts(forUid uid: String, completion: @escaping ([Post]) -> Void)
    func uploadPost(user: User, caption: String, image: UIImage, completion:  ((Error?) -> Void)?)
    
}

class DefaultPostService: PostService, ObservableObject {
    
    let imageUploader: ImageUploader
    
    init(imageUploader: ImageUploader) {
        self.imageUploader = imageUploader
    }
    
    func fetchPosts(completion: @escaping ([Post]) -> Void)  {
        COLLECTION_POSTS
            .order(by: "timeStamp", descending: true)
            .getDocuments { snapShot, error in
            if let error = error {
                print("DEBUG: Failed to fetch posts \(error.localizedDescription)")
                return
            }
            guard let documents = snapShot?.documents else { return }
            let posts = documents.compactMap({ try? $0.data(as: Post.self)})
            
            completion(posts)
        }
    }
    
    func uploadPost(user: User,
                    caption: String,
                    image: UIImage,
                    completion:  ((Error?) -> Void)?) {
        imageUploader.uploadImage(image: image, type: .post) { imageURL in
            let data: [String : Any] = ["caption" : caption,
                                        "timeStamp": Timestamp(date: Date()),
                                        "likes" : 0,
                                        "imageURL" : imageURL,
                                        "ownerUid" : user.id ?? "",
                                        "ownerImageURL" : user.profileImageURL,
                                        "ownerUsername" : user.username] as [String : Any]
            COLLECTION_POSTS
                .addDocument(data: data, completion: completion)
        }
    }
    
    func fetchSearchPosts(completion: @escaping ([Post]) -> Void) {
        COLLECTION_POSTS
            .order(by: "timeStamp", descending: true)
            .getDocuments { snapShot, error in
            if let error = error {
                print("DEBUG: Failed to fetch search page posts"
                      + error.localizedDescription)
                return
            }
            guard let documents = snapShot?.documents else { return }
            let posts = documents.compactMap({ try? $0.data(as: Post.self)})
            
            completion(posts)
        }
    }
    
    func fetchUserPosts(forUid uid: String, completion: @escaping ([Post]) -> Void) {
        COLLECTION_POSTS
            .whereField("ownerUid", isEqualTo: uid)
            .getDocuments { snapShot, error in
            if let error = error {
                print("DEBUG: Failed to fetch user's posts"
                      + error.localizedDescription)
                return
            }
            guard let documents = snapShot?.documents else { return }
            let posts = documents.compactMap({ try? $0.data(as: Post.self)})
                let sortedPosts = posts.sorted(by:
                    { $0.timeStamp.dateValue() > $1.timeStamp.dateValue() })
            
            completion(sortedPosts)
        }
    }
    
}

