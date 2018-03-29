//
//  RoomListViewController.swift
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

extension RoomListViewController {

    /// Wireframe is a struct that contains the view controller instance and
    /// all segues (transitions) that can be initiated by the view controller.
    struct Wireframe {

        /// The view controller created by the binder function.
        let viewController: RoomListViewController

        /// A segue represented by the signal. It should be handled by the object
        /// that created a wireframe. On each new event it should present RoomViewController.
        let presentRoom: SafeSignal<Room>

        // Wireframes will often have more than one segue signal.
    }

    /// Binder is a function that creates and configures the wireframe. It binds the data
    /// from the service to the view controller and user actions from the view controller
    /// to the service.
    static func makeWireframe(_ roomService: RoomService) -> Wireframe {
        let viewContoller = RoomListViewController()

        // All data, including strings, should be set from the binder (this method).
        viewContoller.title = "Rooms"

        roomService.rooms
            // Convert LoadingSignal into SafeSignal by consuming it loading state.
            // UIViewController conforms to LoadingStateListener protocol by displaying an activity
            // indicator view while the signal is in the loading state.
            .consumeLoadingState(by: viewContoller)
            // Using Bond, we can bind rooms signal to a collection view.
            .bind(to: viewContoller.roomsCollectionView, cellType: RoomCell.self) { cell, room in
                cell.nameLabel.text = room.name
            }

        // A signal that emits a Room instance when user selects a room cell.
        // It is handled by the the RoomNavigationController that presents a RoomViewController.
        let presentRoom = viewContoller.roomsCollectionView.reactive.selectedItemIndexPath
            .with(latestFrom: roomService.rooms.value(), combine: itemAtIndexPath)

        // Binder always returns a wireframe.
        return Wireframe(
            viewController: viewContoller,
            presentRoom: presentRoom
        )
    }
}
