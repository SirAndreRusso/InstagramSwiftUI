//
//  FeedCellViewModel.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 01.01.2023.
//

import SwiftUI

class FeedCellViewModel: ObservableObject {
    
    @Published var post: Post
    
    init(post: Post) {
        self.post = post
    }
    
    func like() {
       print("Like")
    }
    
    func unLike() {
        print("unLike")
    }
    
    func checkIfUserLikedPost() {
        
    }
    
}
