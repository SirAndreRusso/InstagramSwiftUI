//
//  NotificationsView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 25.11.2022.
//

import SwiftUI

struct NotificationsView: View {
    
    @StateObject var viewModel: NotificationsViewModel
    var vmFactory: VMFactory
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                ForEach(viewModel.notifications) { notification in
                    if let viewModel = vmFactory
                        .makeNotificationCellViewModel(notification: notification) {
                        NotificationCell(viewModel: viewModel)
                            .padding(.top)
                    }
                }
            }
        }
    }
    
}

