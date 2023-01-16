//
//  NotificationsView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 25.11.2022.
//

import SwiftUI

struct NotificationsView: View {
    
    @ObservedObject var viewModel: NotificationsViewModel
    init(viewModel: NotificationsViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                ForEach(viewModel.notifications) { notification in
                    NotificationCell(notification: notification)
                        .padding(.top)
                }
            }
        }
    }
    
}

