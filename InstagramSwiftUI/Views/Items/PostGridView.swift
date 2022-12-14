//
//  PostGridView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 02.12.2022.
//

import SwiftUI
import Kingfisher

struct PostGridView: View {
    
    @ObservedObject var viewModel : PostGreedViewModel
    let vmFactory: VMFactoty
    let config: PostGreedConfiguration
    private let items = [GridItem(), GridItem(), GridItem()]
    private let width = UIScreen.main.bounds.width / 3
    
    init(config: PostGreedConfiguration, vmFactory: VMFactoty) {
        self.config = config
        self.viewModel = PostGreedViewModel(config: config)
        self.vmFactory = vmFactory
    }
    
    var body: some View {
        LazyVGrid(columns: items, spacing: 2, content: {
            ForEach(viewModel.posts) { post in
                NavigationLink {
                    FeedView(viewModel: vmFactory.makeFeedViewModel())
                } label: {
                    KFImage(URL(string: post.imageURL))
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: width)
                        .clipped()
                }

            }
        })
    }
}

