//
//  NotificationCell.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 06.12.2022.
//

import SwiftUI

struct NotificationCell: View {
    @State private var showPostImage = true
    var body: some View {
        HStack {
            Image("Kenny")
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            
            Text("KennyMcCormick")
                .font(.system(size: 14, weight: .semibold)) +
            Text(" liked your post")
                .font(.system(size: 15))
            Spacer()
            
            if showPostImage {
                Image("Kenny")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
            } else {
                Button {
                    
                } label: {
                    Text("Follow")
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                        .background(Color(.systemBlue))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .font(.system(size: 14, weight: .semibold))
                    
                }

            }
        }
        .padding(.horizontal, 8)
    }
}

struct NotificationCell_Previews: PreviewProvider {
    static var previews: some View {
        NotificationCell()
    }
}
