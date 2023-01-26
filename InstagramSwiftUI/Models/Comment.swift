//
//  Comment.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 03.01.2023.
//

import FirebaseFirestoreSwift
import Firebase

struct Comment: Identifiable, Decodable {
    
    @DocumentID var id: String?
    let username: String
    let postOwnerUid: String
    let profileImageURL: String
    let commentText: String
    let timestamp: Timestamp
    let uid: String
    var timestampString: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfYear, .month]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        
        return formatter.string(from: timestamp.dateValue(), to: Date())
    }
    
}
