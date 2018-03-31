//
//  ProfileViewController.swift
//  Binders
//
//  Created by Srdan Rasic on 29/03/2018.
//  Copyright © 2018 DeclarativeHub. All rights reserved.
//

import Views
import Services
import Entities
import Bond
import ReactiveKit

extension ProfileViewController {

    /// Binder is a function that creates and configures the wireframe. It binds the data
    /// from the service to the view controller and user actions from the view controller
    /// to the service.
    /// This view controller doesn't present other controllers so there is no Router - we use Void instead.
    static func makeWireframe(_ session: AuthenticatedSession) -> Wireframe<ProfileViewController, Void> {
        let viewController = ProfileViewController()

        // All data, including strings, should be set from the binder (this method).
        viewController.title = "Profile"
        viewController.logoutButton.setTitle("Log out", for: .normal)

        // Data that is available asynchronously should be bound to the view controller
        // or its subviews.
        session.userService.currentUser
            .consumeLoadingState(by: viewController)
            .bind(to: viewController) { viewContoller, user in
                viewContoller.nameLabel.text = user.displayName
                viewContoller.usernameLabel.text = user.username
            }

        // User actions should trigger actions on services.
        viewController.logoutButton.reactive.tap
            .bind(to: viewController) { _ in
                session.invalidate()
            }

        return Wireframe(for: viewController)
    }
}
