//
//  UIApplication + Extension.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 03.12.2022.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
