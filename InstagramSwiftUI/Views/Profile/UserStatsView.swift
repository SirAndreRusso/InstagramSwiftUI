//
//  UserStatsView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 07.12.2022.
//

import SwiftUI

struct UserStatsView: View {
    var body: some View {
        HStack(spacing: 10) {
            VStack {
                Text("1")
                    .font(.system(size: 15, weight: .semibold))
                Text("Posts")
                    .font(.system(size: 15))
            }
            .frame(width: 70)
            
            VStack {
                Text("2")
                    .font(.system(size: 15, weight: .semibold))
                Text("Folowers")
                    .font(.system(size: 15))
            }
            .frame(width: 70)
            
            VStack {
                Text("3")
                    .font(.system(size: 15, weight: .semibold))
                Text("Folowing")
                    .font(.system(size: 15))
            }
            .frame(width: 70)
        }
    }
}

struct UserStateView_Previews: PreviewProvider {
    static var previews: some View {
        UserStatsView()
    }
}
