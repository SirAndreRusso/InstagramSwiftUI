//
//  CommentCell.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 03.01.2023.
//

import SwiftUI
import Kingfisher

struct CommentCell: View {
    
    let comment: Comment
    
    var body: some View {
        HStack {
            KFImage(URL(string: comment.profileImageURL))
                .resizable()
                .scaledToFill()
                .frame(width: 36, height: 36)
                .clipShape(Circle())
            
            Text(comment.username)
                .font(.system(size: 14, weight: .semibold))
                .padding(.trailing, -2)
            
            Text(comment.commentText)
                .font(.system(size: 14))
            
            Spacer()
            
            Text(comment.timestampString ?? "")
                .font(.system(size: 12))
                .foregroundColor(.gray)
        }
        .padding(.horizontal)
    }
    
}
