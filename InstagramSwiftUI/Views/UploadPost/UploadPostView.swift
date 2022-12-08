//
//  UploadPostView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 25.11.2022.
//

import SwiftUI
import PhotosUI

struct UploadPostView: View {
    @State private var selectedImage: PhotosPickerItem? = nil
    //    @State var photoPickerPresented = true
    //    @State var selectedImageData: Data?
    @State var postImage: Image?
    @State var captionText = ""
    var body: some View {
        VStack {
            if postImage == nil {
                
                PhotosPicker(
                    selection: $selectedImage,
                    matching: .images,
                    photoLibrary: .shared()) {
                        VStack {
                            Image(systemName: "plus.circle")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 180, height: 180)
                                .foregroundColor(.black)
                                .clipped()
                            Text("Select a photo")
                                .font(.title)
                                .tint(.black)
                        }
                    }
                    .onChange(of: selectedImage) { newItem in
                        Task {
                            // Retrieve selected asset in the form of Data
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                guard let uiImage = UIImage(data: data) else { return }
                                postImage = Image(uiImage: uiImage)
                            }
                        }
                    }
            } else if let image = postImage {
                HStack(alignment: .top) {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipped()
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
