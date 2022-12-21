//
//  ProfileViewModel.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 21.12.2022.
//

import SwiftUI
class ProfileViewModel: ObservableObject {
    let user: User
    init(user: User) {
        self.user = user
    }
    
    func follow() {
       print("DEBUG: follow \(user)")
    }
    
    func unFollow() {
        print("DEBUG: unfollow \(user)")
    }
    
    func checkIfUserIsfollowed() {
        
    }
}
