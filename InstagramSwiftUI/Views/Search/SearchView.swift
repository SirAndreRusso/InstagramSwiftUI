//
//  SearchView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 25.11.2022.
//

import SwiftUI

struct SearchView: View {
//    init(viewModel: SearchViewModel) {
//        self.viewModel = viewModel
//    }
    @State var searchText = ""
    @State var inSearchMode = false
    // try to find out better way to instantiate viewmodel
    @ObservedObject var viewModel =  SearchViewModel()
    var body: some View {
        ScrollView {
            SearchBar(text: $searchText, isEditing: $inSearchMode)
                .padding()
            ZStack {
                if inSearchMode {
                    UserListView(viewModel: viewModel, searchText: $searchText)
                } else {
                    PostGridView(config: .search)
                }
            }
        }
    }
}


