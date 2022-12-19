//
//  SearchViewModel.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 18.12.2022.
//

import Foundation
class SearchViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        fetchUsers()
    }
    func  fetchUsers() {
        COLLECTION_USERS.getDocuments { snapShot, error in
            if let error = error {
                print("DEBUG: Failed to fetch users \(error.localizedDescription)")
                return
            }
            guard let documents = snapShot?.documents else { return }
            self.users = documents.compactMap({ try? $0.data(as: User.self)})
            print(self.users)
        }
    }
}
