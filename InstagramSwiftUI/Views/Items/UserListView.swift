//
//  UserListView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 02.12.2022.
//

import SwiftUI

struct UserListView: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                ForEach(0 ..< 20) { _ in
                    UserCell()
                        .padding(.leading)
                }
            }
        }
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
