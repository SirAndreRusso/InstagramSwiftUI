//
//  ProfileHeaderView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 06.12.2022.
//

import SwiftUI

struct ProfileHeaderView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("Kenny")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 95, height: 95)
                    .clipShape(Circle())
                Spacer()
                UserStatsView()
            }
            .padding(.horizontal)
            Text("Kenny McCormick")
                .font(.system(size: 15, weight: .semibold))
                .padding([.leading, .top], 8)
            Text("Badass")
                .font(.system(size: 15))
                .padding(.leading, 8)
            
            HStack {
                Spacer()
                Button {
                    
                } label: {
                    Text("Edit profile")
                        .font(.system(size: 15, weight: .semibold))
                        .frame(width: 360, height: 32)
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth: 1))
                }
                Spacer()
            }
            .padding(.top, 8)
        }
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView()
    }
}
