//
//  RoomViewController.swift
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

extension RoomViewController {

    /// Routes type defines all the navigation paths that can be taken from this view controller.
    enum Routes {
        /// Sending this to the `router` should present EditMessageViewController for the given message.
        case editMessage(Message)
    }

    /// Binder is a function that creates and configures the wireframe. It binds the data
    /// from the service to the view controller and user actions from the view controller
    /// to the service. Returns a wireframe containing the view controller and the router (if any).
    static func makeWireframe(_ messageService: MessageService) -> Wireframe<RoomViewController, Routes> {
        let viewContoller = RoomViewController()
        let router = Router<Routes>()

        // Date that is available at the binding time can just be assigned...
        viewContoller.navigationItem.title = messageService.room.name

        // ...while the data available asynchronously (as a signal) should be bound to the view controller
        // or its subviews.
        messageService.messages
            .consumeLoadingState(by: viewContoller) // Display a spinner while loading the data.
            .bind(to: viewContoller.messagesCollectionView, cellType: MessageCell.self) { cell, message in
                cell.bodyLabel.text = message.text
                cell.userNameLabel.text = message.fromUser.displayName
            }

        return Wireframe(for: viewContoller, router: router)
    }
}
