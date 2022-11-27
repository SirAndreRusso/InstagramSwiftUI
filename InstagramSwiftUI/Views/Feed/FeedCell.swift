//
//  FeedCell.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 26.11.2022.
//

import SwiftUI

struct FeedCell: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("Kenny")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 36, height: 36)
                    .clipped()
                    .cornerRadius(18)
                Text("Joker")
                    .font(.system(size: 14, weight: .semibold))
            }
            .padding([.leading, .bottom], 8)
            Image("Kenny")
                .resizable()
                .scaledToFill()
                .frame(maxHeight: 440)
                .clipped()
                .cornerRadius(18)
            HStack(spacing: 16) {
                Button {
                    
                } label: {
                    Image(systemName: "heart")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .font(.system(size: 20))
                        .padding(4)
                }
                Button {
                    
                } label: {
                    Image(systemName: "bubble.right")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .font(.system(size: 20))
                        .padding(4)
                }
                Button {
                    
                } label: {
                    Image(systemName: "paperplane")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .font(.system(size: 20))
                        .padding(4)
                }
            }
            .padding(.leading, 4)
            .foregroundColor(.black)
            
            Text("3 likes")
                .font(.system(size: 14, weight: .semibold))
                .padding(.horizontal, 8)
                .padding(.bottom, 2)
            
            HStack {
                Text("KennyMcCormick")
                    .font(.system(size: 14, weight: .semibold)) +
                Text(" gimme da mone")
                    .font(.system(size: 15))
            }
            .padding(.horizontal, 8)
            Text("2d")
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .padding(.leading, 8)
                .padding(.top, -2)
        }
    }
}

struct FeedCell_Previews: PreviewProvider {
    static var previews: some View {
        FeedCell()
    }
}
