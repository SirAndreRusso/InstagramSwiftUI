//
//  ProfileViewModel.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 21.12.2022.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    
    @Published var user: User
    weak var router: Router?
    
    init(user: User,
         router: Router) {
        self.user = user
        self.router = router
    }
    
    deinit {
        print("DEINIT profile ViewModel")
    }
    
}
