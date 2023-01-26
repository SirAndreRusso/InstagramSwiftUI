//
//  SearchViewModel.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 18.12.2022.
//

import SwiftUI

class SearchViewModel: ObservableObject {
    
    @Published var users = [User]()
    private let userService: UserService
    weak var router: Router?
    
    init(userService: UserService, router: Router) {
        self.userService = userService
        self.router = router
        fetchUsers()
    }
    
    func  fetchUsers() {
        userService.fetchUsers {[weak self] users in
            self?.users = users
        }
    }

    func filteredUsers(_ query: String) -> [User] {
        userService.filteredUsers(users: users, query)
    }
    
    deinit {
        print("DEINIT search ViewModel")
    }
    
}
