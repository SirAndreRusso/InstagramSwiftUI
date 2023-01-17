//
//  SearchView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 25.11.2022.
//

import SwiftUI

struct SearchView: View {

    @StateObject var viewModel : SearchViewModel
    @State private var searchText = ""
    @State private var inSearchMode = false
    let postService: PostService
    let vmFactory: VMFactory
    
    var body: some View {
        ScrollView {
            SearchBar(text: $searchText, isEditing: $inSearchMode)
                .padding()
            ZStack {
                if inSearchMode {
                    UserListView(vmFactory: vmFactory,
                                 viewModel: viewModel,
                                 searchText: $searchText)
                } else {
                    if let postGreedViewModel = vmFactory
                        .makePostGreedViewModel(config: .search) {
                        PostGridView(viewModel: postGreedViewModel, vmFactory: vmFactory)
                    }
                }
            }
        }
    }
    
}


