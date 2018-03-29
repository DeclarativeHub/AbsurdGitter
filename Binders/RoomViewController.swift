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

    /// Wireframe is a struct that contains the view controller instance and
    /// all segues (transitions) that can be initiated by the view controller.
    struct Wireframe {
        let viewController: RoomViewController
        let presentEditMessage: SafeSignal<Message>
    }

    /// Binder is a function that creates and configures the wireframe. It binds the data
    /// from the service to the view controller and user actions from the view controller
    /// to the service.
    static func makeWireframe(_ messageService: MessageService) -> Wireframe {
        let viewContoller = RoomViewController()

        // Date that is available at the binding time can just be assigned...
        viewContoller.navigationItem.title = messageService.room.name

        // ...while the data available asynchronously should be bound to the view controller
        // or its subviews.
        messageService.messages
            .consumeLoadingState(by: viewContoller) // Display a spinner while loading the data.
            .bind(to: viewContoller.messagesCollectionView, cellType: MessageCell.self) { cell, message in
                cell.bodyLabel.text = message.text
                cell.userNameLabel.text = message.fromUser.displayName
            }

        return Wireframe(
            viewController: viewContoller,
            presentEditMessage: .never() // TODO
        )
    }
}
