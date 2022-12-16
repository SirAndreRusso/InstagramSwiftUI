//
//  ImageUploader.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 16.12.2022.
//

import UIKit
import Firebase
import FirebaseStorage

class ImageUoloader {
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {return}
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
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
