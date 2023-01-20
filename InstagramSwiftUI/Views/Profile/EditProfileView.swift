//
//  EditProfileView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 20.01.2023.
//

import SwiftUI

struct EditProfileView: View {
    
    @State private var about: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    
                } label: {
                    Text("Cancel")
                        .bold()
                        .foregroundColor(.red)
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Done")
                        .bold()
                        .foregroundColor(.black)
                }
            }
            .padding(.top)
            .padding(.horizontal)
            
            Divider()
            
            TextArea(text: $about, placeholder: "Tell about you...")
                .frame(width: UIScreen.main.bounds.width - 16, height: 200)
            
            Divider()
            
            Spacer()
        }
    }
}
