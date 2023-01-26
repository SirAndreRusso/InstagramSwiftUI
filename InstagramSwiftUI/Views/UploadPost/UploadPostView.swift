//
//  UploadPostView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 25.11.2022.
//

import SwiftUI
import PhotosUI

struct UploadPostView: View {

    @StateObject var viewModel: UploadPostViewModel
    @Binding var tabIndex: Int
    @State private var selectedImage: PhotosPickerItem? = nil
    @State private var postImage: Image?
    @State private var postUIImage: UIImage?
    @State var captionText = ""
    
    var body: some View {
        VStack {
            // Image picker
            if postImage == nil {
                PhotosPicker(
                    selection: $selectedImage,
                    matching: .images,
                    photoLibrary: .shared()) {
                        VStack {
                            ZStack {
                                Color(.white)
                                LinearGradient(colors: [.purple, .red, .orange], startPoint: .leading, endPoint: .trailing)
                                    .mask(Image(systemName: "plus.circle")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 180, height: 180)
                                        .clipped())
                            }
                            .frame(height: 180)
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
                                postUIImage = uiImage
                                postImage = Image(uiImage: uiImage)
                            }
                        }
                    }
            } else if let image = postImage {
                Divider()
                // Picked image with capture
                HStack(alignment: .top) {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipped()
                    
                    TextArea(text: $captionText, placeholder: "Enter your caption..")
                        .frame(height: 100)
                }
                .padding()
                
                Divider()
                
                HStack(spacing: 16) {
                    // Share button
                    Button {
                        guard let image = postUIImage else { return }
                        viewModel.uploadPost(caption: captionText, image: image) { error in
                            if let error = error {
                                print("DEBUG: Failed to upload post" + error.localizedDescription)
                                return
                            }
                            captionText = ""
                            postImage = nil
                            postUIImage = nil
                            tabIndex = 0
                        }
                    } label: {
                        Text("Share")
                            .font(.system(size: 16, weight: .semibold))
                            .frame(width: 172, height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(5)
                    }
                    // Cancel button
                    Button {
                        captionText = ""
                        postImage = nil
                        postUIImage = nil
                        
                    } label: {
                        Text("Cancel")
                            .font(.system(size: 16, weight: .semibold))
                            .frame(width: 172, height: 50)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(5)
                    }
                }
                Spacer()
            }
        }
    }
    
}

