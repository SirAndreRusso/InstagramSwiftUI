//
//  SearchView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 25.11.2022.
//

import SwiftUI

struct SearchView: View {
    init(user: User) {
        self.viewModel = SearchViewModel()
        self.user = user
    }
    private let user: User
    @State var searchText = ""
    @State var inSearchMode = false
    @ObservedObject var viewModel : SearchViewModel
    var body: some View {
        ScrollView {
            SearchBar(text: $searchText, isEditing: $inSearchMode)
                .padding()
            ZStack {
                if inSearchMode {
                    UserListView(viewModel: viewModel, searchText: $searchText)
                } else {
                    PostGridView(config: .search, user: user)
                }
            }
        }
    }
}


