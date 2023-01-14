//
//  ImageUploader.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 16.12.2022.
//

import UIKit
import Firebase
import FirebaseStorage

protocol ImageUploader {
    
    func uploadImage(image: UIImage, type: uploadType, completion: @escaping(String) -> Void)
    
}

enum uploadType {
    
    case profileImage
    case post
    
    var filePath: StorageReference {
        let filename = NSUUID().uuidString
        switch self {
        case .profileImage:
           return Storage.storage().reference(withPath: "/profile_images/\(filename)")
        case .post:
           return Storage.storage().reference(withPath: "/post_images/\(filename)")
        }
    }
    
}

class DefaultImageUploader: ImageUploader {
    
        func uploadImage(image: UIImage, type: uploadType, completion: @escaping(String) -> Void) {
            
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        let ref = type.filePath
            
        ref.putData(imageData) { _ , error in
            if let error = error {
                print("DEBUG: Failed to upload image" + error.localizedDescription)
                return
            } else {
                ref.downloadURL { url, error in
                    if let error = error {
                        print("DEBUG: Failed to download URL" + error.localizedDescription)
                        return
                    } else {
                        guard let imageURL = url?.absoluteString else { return }
                        
                        completion(imageURL)
                    }
                }
            }
        }
    }
    
}
