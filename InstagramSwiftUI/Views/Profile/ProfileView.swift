//
//  ProfileView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 25.11.2022.
//

import SwiftUI

struct ProfileView: View {
    let User: User
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                ProfileHeaderView(user: User)
                PostGridView()
            }
            .padding(.top)
        }
    }
}
//
//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}
