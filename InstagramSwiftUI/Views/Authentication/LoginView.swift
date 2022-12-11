//
//  LoginView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 10.12.2022.
//

import SwiftUI
import UIKit

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.purple, .red, .orange]), startPoint: .top, endPoint: .bottom)
                    .opacity(0.8)
                    .ignoresSafeArea()
                
                VStack {
                    Image("instagramLogo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 230, height: 60)
                        .padding(.top, 60)
                    
                    VStack(spacing: 20) {
                        // email field
                        CustomTextfield(text: $email, placeholder: Text("Email"), imageName: "envelope")
                            .padding()
                            .background(Color(.init(white: 1, alpha: 0.15)))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .padding(.horizontal, 32)
                        
                        //password field
                        CustomSecureField(text: $password, placeholder: Text("Password"), imageName: "lock")
                            .padding()
                            .background(Color(.init(white: 1, alpha: 0.15)))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .padding(.horizontal, 32)
                    }
                    
                    //forgot password
                    HStack {
                        Spacer()
                        Button {
                            
                        } label: {
                            Text("Forgot password?")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.top)
                                .padding(.trailing, 32)
                        }
                    }
                    
                    //sign in
                    Button {
                                
                    } label: {
                            Text("Sign in")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 360, height: 50)
                            .background(Color(.purple).opacity(0.7))
                            .clipShape(Capsule())
                    }
                    
                    Spacer()
                    NavigationLink(destination: RegistrationView().navigationBarHidden(true), label: {
                        HStack {
                            Text("Don't have an account yet?")
                                .font(.system(size: 14))
                            Text("Sign up")
                                .font(.system(size: 14, weight: .semibold))
                        }
                    })
                    .foregroundColor(.white)
                    .padding(.bottom)
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
