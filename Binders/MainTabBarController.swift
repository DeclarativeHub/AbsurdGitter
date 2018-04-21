//
//  MainTabBarController.swift
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

class MainTabBarController: UITabBarController {}

/// MainTabBarController is application window's `rootViewController` when the user IS logged in.
extension MainTabBarController {

    /// Binder is a function that creates and configures the view controller. It binds the data
    /// from the service to the view controller and user actions from the view controller
    /// to the service.
    static func makeViewController(_ session: AuthenticatedSession) -> MainTabBarController {
        let tabBarController = MainTabBarController()

        // Use binders to create child view controllers:
        tabBarController.setViewControllers([
            RoomNavigationController.makeViewController(session),
            ProfileViewController.makeViewController(session)
        ], animated: false)

        return tabBarController
    }
}
