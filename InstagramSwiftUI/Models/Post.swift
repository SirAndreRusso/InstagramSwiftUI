//
//  Post.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 27.12.2022.
//

import FirebaseFirestoreSwift
import Firebase

struct Post: Identifiable, Decodable {
    @DocumentID var id: String?
    let ownerUid: String
    let ownerUsername: String
    let caption: String
    var likes: Int
    let imageURL: String
    let ownerImageURL: String
    let timeStamp: Timestamp
    var didLike: Bool? = false
}
