//
//  TextArea.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 26.12.2022.
//

import SwiftUI

struct TextArea: View {
    init(text: Binding<String>, placeholder: String) {
        self._text = text
        self.placeholder = placeholder
        UITextView.appearance().backgroundColor = .clear
    }
    @Binding var text: String
    let placeholder: String
    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color(UIColor.placeholderText))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 12)
            }
            TextEditor(text: $text)
                .padding(4)
        }
        .font(.body)
    }
}


