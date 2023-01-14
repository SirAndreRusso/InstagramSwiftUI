//
//  SearchView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 25.11.2022.
//

import SwiftUI

struct SearchView: View {
    init(viewModel: SearchViewModel, vmFactory: VMFactoty, postService: PostService) {
        self.viewModel = viewModel
        self.vmFactory = vmFactory
        self.postService = postService
    }
    let postService: PostService
    let vmFactory: VMFactoty
    @State var searchText = ""
    @State var inSearchMode = false
    @ObservedObject var viewModel : SearchViewModel
    var body: some View {
        ScrollView {
            SearchBar(text: $searchText, isEditing: $inSearchMode)
                .padding()
            ZStack {
                if inSearchMode {
                    UserListView(vmFactory: vmFactory, postService: postService, viewModel: viewModel, searchText: $searchText)
                } else {
                    PostGridView(config: .search, vmFactory: vmFactory, postService: postService)
                }
            }
        }
    }
}


