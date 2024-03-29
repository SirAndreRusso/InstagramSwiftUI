//
//  SearchView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 25.11.2022.
//

import SwiftUI

struct SearchView: View {

    @ObservedObject var viewModel : SearchViewModel
    @State private var searchText = ""
    @State private var inSearchMode = false
    
    var body: some View {
        ScrollView {
            SearchBar(text: $searchText, isEditing: $inSearchMode)
                .padding()
            
            ZStack {
                if inSearchMode {
                    UserListView(viewModel: viewModel, searchText: $searchText)
                } else {
                    viewModel.router?.showPostGreedView(config: .search)
                }
            }
        }
    }
    
}


