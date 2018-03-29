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

    /// Wireframe is a struct that contains the view controller instance and
    /// all segues (transitions) that can be initiated by the view controller.
    /// This view controller does not trigger any segues, but it is still a good
    /// idea to be consistent and define a wireframe type.
    struct Wireframe {
        let navigationController: RoomNavigationController
    }

    /// Binder is a function that creates and configures the wireframe. It binds the data
    /// from the service to the view controller and user actions from the view controller
    /// to the service.
    static func makeWireframe(_ session: AuthenticatedSession) -> Wireframe {

        // Room list view controleler is navigation controller's root view controller
        let service = session.roomService
        let roomListWireframe = RoomListViewController.makeWireframe(service)
        let navigationController = RoomNavigationController(rootViewController: roomListWireframe.viewController)

        // We have to handle all segues from the wireframe.
        // Bind the seques signal to the object that will perform the transition - in our
        // case to the navigation controller.
        roomListWireframe.presentRoom.bind(to: navigationController) { navigationController, room in
            navigationController.presentRoom(room, session: session)
        }

        return Wireframe(navigationController: navigationController)
    }

    /// Segues (routes) can be implemented as function extensions on the view controller.
    func presentRoom(_ room: Room, session: AuthenticatedSession) {
        let service = MessageService(session.client, room: room)
        let wireframe = RoomViewController.makeWireframe(service)

        // We have to handle all segues from the wireframe.
        // Same approach as with the previous one.
        wireframe.presentEditMessage.bind(to: self) { navigationController, message in
            navigationController.presentEditMessage(message, session: session)
        }

        pushViewController(wireframe.viewController, animated: true)
    }

    // Another segue function
    func presentEditMessage(_ message: Message, session: AuthenticatedSession) {
        // TODO
    }
}
