//
//  RootViewController.swift
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

extension UIWindow {

    /// Binder for the main window? Why not. Updates window's rootViewController whenever the session is changed.
    public static func makeMainWindow(_ sessionManager: SessionManager) -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)

        // Observe currentSession and update rootViewController accordingly.
        sessionManager.currentSession.bind(to: window) { window, session in
            switch session {
            case .authenticated(let session):
                window.rootViewController = MainTabBarController.makeViewController(session)
            case .unauthenticated(let session):
                window.rootViewController = LoginViewController.makeViewController(session.loginService)
            }
        }

        return window
    }
}
