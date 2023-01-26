import Foundation
import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var authViewModel: AuthViewModel
    @State var selectedIndex = 0
    
    var body: some View {
        Group {
            if authViewModel.userSession == nil {
                authViewModel.router?.showLoginView()
            } else {
                if let _ = authViewModel.currentUser {
                    authViewModel.router?.showMainTabView(selectedIndex: $selectedIndex)
                }
            }
        }
    }
    
}
