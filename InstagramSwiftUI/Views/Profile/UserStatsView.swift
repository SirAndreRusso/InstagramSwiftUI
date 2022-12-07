//
//  UserStatsView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 07.12.2022.
//

import SwiftUI

struct UserStatsView: View {
    var value: Int
    var title: String
    var body: some View {
            VStack {
                Text("\(value)")
                    .font(.system(size: 15, weight: .semibold))
                Text(title)
                    .font(.system(size: 15))
            }
            .frame(width: 70)
    }
}

struct UserStateView_Previews: PreviewProvider {
    static var previews: some View {
        UserStatsView(value: 1, title: "Posts")
    }
}
