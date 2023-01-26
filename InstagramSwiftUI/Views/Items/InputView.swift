//
//  InputView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 03.01.2023.
//

import SwiftUI

struct InputView: View {
    
    @Binding var inputText: String
    var action: () -> Void
    
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(Color(.separator))
                .frame(width: UIScreen.main.bounds.width, height: 0.75)
                .padding(.bottom, 8)
            
            HStack {
                TextField("Comment...", text: $inputText)
                    .textFieldStyle(.plain)
                    .frame(minHeight: 30)
                Button(action: action) {
                    Text("Send")
                        .bold()
                        .foregroundColor(.black)
                }
            }
            .padding(.bottom, 8)
            .padding(.horizontal)
        }
    }
    
}

