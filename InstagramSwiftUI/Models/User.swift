//
//  User.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 18.12.2022.
//
import FirebaseFirestoreSwift
import Firebase
struct User: Decodable, Identifiable {
    let username: String
    let fullname: String
    let email: String
    let profileImageURL: String
    @DocumentID var id: String?
    var stats: UserStats?
    var isFolowed: Bool? = false
    var isCurrentUser: Bool {
        return Auth.auth().currentUser?.uid == id
    }
}

struct UserStats: Decodable {
    var following: Int
    var followers: Int
    var posts:  Int
}
