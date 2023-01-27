//
//  Router.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 21.01.2023.
//

import SwiftUI

protocol Router: AnyObject {

    func showLoginView() -> LoginView
    func showRegistrationView() -> RegistrationView
    func showResetPasswordView(email: Binding<String>) -> ResetPasswordView
    func showMainTabView(selectedIndex: Binding<Int>) -> MainTabView
    func showFeedView(user: User) -> FeedView
    func showFeedCellView(user: User, post: Post) -> FeedCell
    func showPostGreedView(config: PostGreedConfiguration) -> PostGridView
    func showNotificationCell(notification: Notification, user: User) -> NotificationCell
    func showProfileView(user: User) -> ProfileView
    func showProfileHeaderView(user: User) -> ProfileHeaderView
    func showSearchView() -> SearchView
    func showUserListView (viewModel: SearchViewModel, searchText: Binding<String>) -> UserListView
    func showUploadPostView(user: User, tabIndex: Binding<Int>) -> UploadPostView
    func showNotificationsView(user: User) -> NotificationsView
    func showCommentsView(user: User, post: Post) -> CommentsView
    
}

class DefaultRouter: Router {
    
    private let vmFactory: VMFactory
    private let serviceProvider: ServiceProvider
    
    init(vmFactory: VMFactory, serviceFactory: ServiceProvider) {
        self.vmFactory = vmFactory
        self.serviceProvider = serviceFactory
    }
    
    func showLoginView() -> LoginView {
        LoginView()
    }
    
    func showRegistrationView() -> RegistrationView {
        RegistrationView()
    }
    
    func showMainTabView(selectedIndex: Binding<Int>) -> MainTabView {
        MainTabView(selectedIndex: selectedIndex)
    }
    
    func showFeedView(user: User) -> FeedView  {
        let feedViewModel = vmFactory.makeFeedViewModel(user: user, router: self)
        return FeedView(viewModel: feedViewModel)
    }
    
    func showFeedCellView(user: User, post: Post) -> FeedCell {
        let feedCellViewModel = vmFactory.makeFeedCellViewModel(post: post, user: user, router: self, likeService: nil, notificationService: nil)
        return FeedCell(viewModel: feedCellViewModel)
    }
    
    func showPostGreedView(config: PostGreedConfiguration) -> PostGridView {
        let postGreedViewModel = vmFactory.makePostGreedViewModel(config: config, router: self)
        return PostGridView(viewModel: postGreedViewModel)
    }
    
    func showNotificationCell(notification: Notification, user: User) -> NotificationCell {
        let notificationCellViewModel = vmFactory.makeNotificationCellViewModel(notification: notification, router: self, user: user)
        return NotificationCell(viewModel: notificationCellViewModel)
    }
    
    func showProfileView(user: User) -> ProfileView {
        let profileViewModel = vmFactory.makeProfileViewModel(user: user, router: self)
        return ProfileView(viewModel: profileViewModel)
    }
    
    func showProfileHeaderView(user: User) -> ProfileHeaderView {
        let profileHeaderViewModel = vmFactory.makeProfileHeaderViewModel(user: user, router: self)
        return ProfileHeaderView(viewModel: profileHeaderViewModel)
    }
    
    func showSearchView() -> SearchView {
        let searchViewModel = vmFactory.makeSearchViewModel(router: self)
        return SearchView(viewModel: searchViewModel)
    }
    
    func showUserListView(viewModel: SearchViewModel, searchText: Binding<String>) -> UserListView {
        UserListView(viewModel: viewModel, searchText: searchText)
    }
    
    func showUploadPostView(user: User, tabIndex: Binding<Int>) -> UploadPostView {
        let uploadPostViewModel = vmFactory.makeUploadPostViewModel(user: user, router: self)
        return UploadPostView(viewModel: uploadPostViewModel, tabIndex: tabIndex)
    }
    
    func showNotificationsView(user: User) -> NotificationsView {
        let notificationViewModel = vmFactory.makeNotificationsViewModel(user: user, router: self)
        return NotificationsView(viewModel: notificationViewModel)
    }
    
    func showCommentsView(user: User, post: Post) -> CommentsView {
        let commentsViewModel = vmFactory.makeCommentsViewModel(user: user, post: post, router: self)
        return CommentsView(viewModel: commentsViewModel)
    }
    
    func showResetPasswordView(email: Binding<String>) -> ResetPasswordView {
        ResetPasswordView(email: email)
    }
    
}

