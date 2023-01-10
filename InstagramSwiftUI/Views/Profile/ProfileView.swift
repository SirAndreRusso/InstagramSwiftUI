//
//  ProfileView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 25.11.2022.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    private let vmFactory: VMFactoty
    init(viewModel: ProfileViewModel, vmFactory: VMFactoty) {
        self.vmFactory = vmFactory
        self.viewModel = viewModel
    }
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                ProfileHeaderView(viewModel: viewModel)
                PostGridView(config: .profile(viewModel.user.id ?? ""), vmFactory: vmFactory)
            }
            .padding(.top)
        }
    }
}

