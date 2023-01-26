//
//  EditProfileView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 20.01.2023.
//

import SwiftUI

struct EditProfileView: View {
    
    @ObservedObject var viewModel: ProfileHeaderViewModel
    @Environment(\.presentationMode) var mode
    @State private var bio: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    mode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                        .bold()
                        .foregroundColor(.red)
                }
                
                Spacer()
                
                Button {
                    viewModel.saveUserData(bio: bio)
                    self.mode.wrappedValue.dismiss()
                } label: {
                    Text("Done")
                        .bold()
                        .foregroundColor(.black)
                }
            }
            .padding(.top)
            .padding(.horizontal)
            
            Divider()
            
            TextArea(text: $bio, placeholder: "Tell about you...")
                .frame(width: UIScreen.main.bounds.width - 16, height: 200)
            
            Divider()
            
            Spacer()
        }
    }
    
}
