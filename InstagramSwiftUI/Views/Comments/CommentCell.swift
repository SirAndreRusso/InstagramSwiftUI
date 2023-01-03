//
//  CommentCell.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 03.01.2023.
//

import SwiftUI

struct CommentCell: View {
    var body: some View {
        HStack {
            Image("kenny")
                .resizable()
                .scaledToFill()
                .frame(width: 36, height: 36)
                .clipShape(Circle())
            
            Text("Kenny McCormick")
                .font(.system(size: 14, weight: .semibold)) +
            Text("Some test comment")
                .font(.system(size: 14))
            
            Spacer()
            
            Text("2m")
                .font(.system(size: 12))
                .foregroundColor(.gray)
        }
        .padding(.horizontal)
    }
}
