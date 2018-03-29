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

/// MainTabBarController is application window's rootViewController when the user IS logged in.
extension MainTabBarController {

    /// Wireframe is a struct that contains the view controller instance and
    /// all segues (transitions) that can be initiated by the view controller.
    /// This view controller does not trigger any segues, but it is still a good
    /// idea to be consistent and define a wireframe type.
    struct Wireframe {
        let viewController: MainTabBarController
    }

    /// Binder is a function that creates and configures the wireframe. It binds the data
    /// from the service to the view controller and user actions from the view controller
    /// to the service.
    static func makeWireframe(_ session: AuthenticatedSession) -> Wireframe {
        let tabBarController = MainTabBarController()

        // Use binders to create child view controllers:
        tabBarController.setViewControllers([
            RoomNavigationController.makeWireframe(session).navigationController,
            ProfileViewController.makeWireframe(session).viewController
        ], animated: false)

        return Wireframe(viewController: tabBarController)
    }
}
