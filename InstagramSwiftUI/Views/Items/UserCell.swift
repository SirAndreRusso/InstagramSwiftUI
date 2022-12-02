//
//  UserCell.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 02.12.2022.
//

import SwiftUI

struct UserCell: View {
    var body: some View {
        HStack {
            Image("Kenny")
                .resizable()
                .scaledToFill()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text("Kenny McCormick")
                    .font(.system(size: 14, weight: .semibold))
                
                Text("Still alive")
                    .font(.system(size: 14))
            }
            Spacer()
        }
    }
}

struct UserCell_Previews: PreviewProvider {
    static var previews: some View {
        UserCell()
    }
}
