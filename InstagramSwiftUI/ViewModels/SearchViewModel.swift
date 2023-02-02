//
//  SearchViewModel.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 18.12.2022.
//

import SwiftUI
import Combine

class SearchViewModel: ObservableObject {
    
    @Published var users = [User]()
    private let userService: UserService
    private var cancellables: Set<AnyCancellable> = []
    weak var router: Router?
    
    init(userService: UserService, router: Router) {
        self.userService = userService
        self.router = router
        fetchUsers()
    }
    
    func  fetchUsers() {
        Task {
            await userService.fetchUsers()
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("DEBUG: Failed to fetch user" + error.localizedDescription)
                    }
                } receiveValue: { [weak self] users in
                    self?.users = users
                }
                .store(in: &cancellables)
        }
    }

    func filteredUsers(_ query: String) -> [User] {
        userService.filteredUsers(users: users, query)
    }
    
    deinit {
        print("DEINIT search ViewModel")
    }
    
}
