//
//  ResetPasswordView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 10.12.2022.
//

import SwiftUI

struct ResetPasswordView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.presentationMode) var mode
    @Binding  private var email: String
    
    init(email: Binding<String>) {
        self._email = email
    }
    
    var body: some View {
        ZStack {
            // Gradient background
            LinearGradient(gradient: Gradient(colors: [.purple, .red, .orange]), startPoint: .top, endPoint: .bottom)
                .opacity(0.8)
                .ignoresSafeArea()
            
            VStack {
                // Header
                Color(.white)
                    .mask {
                        Image("instagramLogo")
                            .resizable()
                            .scaledToFill()
                    }
                    .frame(width: 230, height: 60)
                    .padding(.top, 60)
                    .padding(.bottom)
        
                VStack(spacing: 20) {
                    // Email field
                    CustomTextfield(text: $email, placeholder: Text("Email"), imageName: "envelope")
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .padding(.horizontal, 32)
                }
                // Reset password
                Button {
                    viewModel.resetPassword(withEmail: email)
                } label: {
                        Text("Send reset password link")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 360, height: 50)
                        .background(Color(.purple).opacity(0.7))
                        .clipShape(Capsule())
                }
                .padding(.top)
                
                Spacer()
                // Sign in
                Button {
                    mode.wrappedValue.dismiss()
                } label: {
                    HStack {
                        Text("Already have an account")
                            .font(.system(size: 14))
                        Text("Sign in")
                            .font(.system(size: 14, weight: .semibold))
                    }
                }
                .foregroundColor(.white)
                .padding(.bottom)
            }
        }
        .onReceive(viewModel.$didSendResetPasswordLink) { _ in
            self.mode.wrappedValue.dismiss()
        }
    }
    
}

