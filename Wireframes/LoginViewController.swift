//
//  LoginViewController.swift
//  Binders
//
//  Created by Srdan Rasic on 18/02/2018.
//  Copyright © 2018 DeclarativeHub. All rights reserved.
//

import Views
import Services
import Entities
import Bond
import ReactiveKit

/// LoginViewController is application window's `rootViewController` when the user IS NOT logged in.
extension LoginViewController {

    /// Creates login view controller.
    static func makeWireframe(_ loginService: LoginService) -> Wireframe<LoginViewController, Void> {
        let viewController = LoginViewController()

        // All data, including strings, should be set from the binder (this method).
        viewController.loginButton.setTitle("Log in", for: .normal)

        // When user taps the login button, call `loginService.startLogin`.
        viewController.loginButton.reactive.tap
            // Binding to the VC ensures that the binding
            // is active only while the VC is alive.
            .bind(to: viewController) { _ in
                loginService.startLogin()
            }

        return Wireframe(for: viewController)
    }
}
