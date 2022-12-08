//
//  UploadPostView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 25.11.2022.
//

import SwiftUI

struct UploadPostView: View {
    @State private var selectedImage: UIImage?
    @State var postImage: Image?
    @State var captionText = ""
    var body: some View {
        VStack {
            if postImage != nil {
                Button {
                    
                } label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 180, height: 180)
                        .foregroundColor(.black)
                        .clipped()
                }
                Text("Select a photo")
                    .font(.title)
            } else {
                HStack(alignment: .top) {
                   Image("Kenny")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                    TextField("Enter your caption...", text: $captionText)
                }
                .padding()
                
                Button {
                    
                } label: {
                    Text("Share")
                        .font(.system(size: 16, weight: .semibold))
                        .frame(width: 360, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                }
                
                Spacer()
            }
        }
    }
}

struct UploadPostView_Previews: PreviewProvider {
    static var previews: some View {
        UploadPostView()
    }
}
