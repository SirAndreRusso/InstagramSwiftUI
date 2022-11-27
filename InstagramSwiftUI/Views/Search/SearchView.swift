//
//  SearchView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 25.11.2022.
//

import SwiftUI

struct SearchView: View {
    @State var searchText = ""
    var body: some View {
        ScrollView {
            SearchBar(text: $searchText)
                .padding()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
