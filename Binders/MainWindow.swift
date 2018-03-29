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

    /// Wireframe for the main window? Why not.
    public struct Wireframe {
        public let window: UIWindow
    }

    /// Wireframe for the main window? Why not. Updates window's rootViewController whenever the session is changed.
    public static func makeWireframe(_ sessionManager: SessionManager) -> Wireframe {
        let window = UIWindow(frame: UIScreen.main.bounds)

        // Observe currentSession and update rootViewController accordingly.
        sessionManager.currentSession.bind(to: window) { window, session in
            switch session {
            case .authenticated(let session):
                window.rootViewController = MainTabBarController.makeWireframe(session).viewController
            case .unauthenticated(let session):
                window.rootViewController = LoginViewController.makeWireframe(session.loginService).viewController
            }
        }

        return Wireframe(window: window)
    }
}
