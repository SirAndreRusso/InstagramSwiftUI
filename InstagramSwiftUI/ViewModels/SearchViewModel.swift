//
//  SearchViewModel.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 18.12.2022.
//

import SwiftUI

class SearchViewModel: ObservableObject {
    
    @Published var users = [User]()
    let userService: UserService
    init(userService: UserService) {
        self.userService = userService
        fetchUsers()
    }
    
    func  fetchUsers() {
        userService.fetchUsers { users in
            self.users = users
        }
    }

    func filteredUsers(_ query: String) -> [User] {
        userService.filteredUsers(users: users, query)
    }
    
}
