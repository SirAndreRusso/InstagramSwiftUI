//
//  LazyView.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 19.01.2023.
//

import SwiftUI

struct LazyView<Content: View>: View {
    
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    
    var body: some View {
        build()
    }
}
