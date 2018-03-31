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
/// Handles routes from the view controllers it displays.
extension RoomNavigationController {

    /// Binder is a function that creates and configures the wireframe. It binds the data
    /// from the service to the view controller and user actions from the view controller
    /// to the service.
    static func makeWireframe(_ session: AuthenticatedSession) -> Wireframe<RoomNavigationController, Void> {

        // Room list view controleler is navigation controller's root view controller
        let service = session.roomService
        let roomListWireframe = RoomListViewController.makeWireframe(service)
        let navigationController = RoomNavigationController(rootViewController: roomListWireframe.viewController)

        // We have to handle all routes from the wireframe.
        // Bind the routes signal to the object that will perform the transition - in our
        // case to the navigation controller.
        roomListWireframe.router.routes.bind(to: navigationController) { navigationController, route in
            switch route {
            case .room(let room):
                navigationController.presentRoom(room, session: session)
            }
        }

        return Wireframe(for: navigationController)
    }

    /// Routes can be implemented as function extensions on the view controller.
    func presentRoom(_ room: Room, session: AuthenticatedSession) {
        let service = MessageService(session.client, room: room)
        let wireframe = RoomViewController.makeWireframe(service)

        // We have to handle all routes from the wireframe.
        // Same approach as with the previous one.
        wireframe.router.routes.bind(to: self) { navigationController, route in
            switch route {
            case .editMessage(let message):
                navigationController.presentEditMessage(message, session: session)
            }
        }

        pushViewController(wireframe.viewController, animated: true)
    }

    // Another routing function
    func presentEditMessage(_ message: Message, session: AuthenticatedSession) {
        // TODO
    }
}
