//
//  NotificationCell.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 06.12.2022.
//

import Kingfisher
import SwiftUI

struct NotificationCell: View {
    
    var notification: Notification
    
    var body: some View {
        HStack {
            KFImage(URL(string: notification.profileImageURL))
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            
            Text(notification.username)
                .font(.system(size: 14, weight: .semibold)) +
            Text(" " + notification.type.notificationMessage)
                .font(.system(size: 15))
            Spacer()
            
            if notification.type != .follow {
                Image("kenny")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
            } else {
                Button {
                    
                } label: {
                    Text("Follow")
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                        .background(Color(.systemBlue))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .font(.system(size: 14, weight: .semibold))
                }
            }
        }
        .padding(.horizontal, 8)
    }
    
}
