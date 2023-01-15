//
//  SearchView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 25.11.2022.
//

import SwiftUI

struct SearchView: View {

    @State var searchText = ""
    @State var inSearchMode = false
    @ObservedObject var viewModel : SearchViewModel
    let postService: PostService
    let vmFactory: VMFactory
    
    var body: some View {
        ScrollView {
            SearchBar(text: $searchText, isEditing: $inSearchMode)
                .padding()
            ZStack {
                if inSearchMode {
                    UserListView(vmFactory: vmFactory, postService: postService, viewModel: viewModel, searchText: $searchText)
                } else {
                    if let postGreedViewModel = vmFactory.makePostGreedViewModel(config: .search) {
                        PostGridView(viewModel: postGreedViewModel, vmFactory: vmFactory)
                    }
                }
            }
        }
    }
    
}


