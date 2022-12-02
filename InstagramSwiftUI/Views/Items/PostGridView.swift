//
//  PostGridView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 02.12.2022.
//

import SwiftUI

struct PostGridView: View {
    private let items = [GridItem(), GridItem(), GridItem()]
    private let width = UIScreen.main.bounds.width / 3
    var body: some View {
        LazyVGrid(columns: items, spacing: 2, content: {
            ForEach(0 ..< 9) { _ in
                Image("Kenny")
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: width)
            }
        })
    }
}

struct PostGridView_Previews: PreviewProvider {
    static var previews: some View {
        PostGridView()
    }
}
