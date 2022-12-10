//
//  CustomTextfield.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 10.12.2022.
//

import SwiftUI

struct CustomTextfield: View {
    @Binding var text: String
    let placeholder: Text
    let imageName: String
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder
                    .foregroundColor(Color(.init(white: 1, alpha: 0.8)))
                    .padding(.leading, 40)
            }
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
                TextField("", text: $text)
            }
        }
    }
}

struct CustomTextfield_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextfield(text: .constant(""), placeholder: Text("email"), imageName: "envelope")
    }
}
