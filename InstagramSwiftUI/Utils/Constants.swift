//
//  Constants.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 18.12.2022.
//

import Foundation
import Firebase

let COLLECTION_USERS = Firestore.firestore().collection("users")
let COLLECTION_FOLLOWING = Firestore.firestore().collection("following")
let COLLECTION_FOLLOWERS = Firestore.firestore().collection("followers")
