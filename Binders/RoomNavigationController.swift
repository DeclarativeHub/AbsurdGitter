//
//  RoomNavigationController.swift
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

class RoomNavigationController: UINavigationController {}

/// Navigation controller for the first tab: Rooms.
extension RoomNavigationController {

    /// Binder is a function that creates and configures the view controller. It binds the data
    /// from the service to the view controller and user actions from the view controller
    /// to the service.
    static func makeViewController(_ session: AuthenticatedSession) -> RoomNavigationController {

        // Room list view controller is navigation controller's root view controller
        let roomListViewController = RoomListViewController.makeViewController(session)
        let navigationController = RoomNavigationController(rootViewController: roomListViewController)

        return navigationController
    }
}
