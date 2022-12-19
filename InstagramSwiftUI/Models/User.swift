//
//  User.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 18.12.2022.
//
import FirebaseFirestoreSwift
struct User: Decodable, Identifiable {
    let username: String
    let fullname: String
    let email: String
    let profileImageURL: String
    @DocumentID var id: String?
}
