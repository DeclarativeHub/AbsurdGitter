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

    /// Routes type defines all the navigation paths that can be taken from this view controller.
    enum Routes {
        /// Sending this to the `router` should present RoomViewController for the given room.
        case room(Room)
    }

    /// Binder is a function that creates and configures the wireframe. It binds the data
    /// from the service to the view controller and user actions from the view controller
    /// to the service. Returns a wireframe containing the view controller and the router (if any).
    static func makeWireframe(_ roomService: RoomService) -> Wireframe<RoomListViewController, Routes> {

        // We just create the view controller instance...
        let viewContoller = RoomListViewController()

        // ...and the router instance with the right type of routes.
        let router = Router<Routes>()

        // Then we proceed by setting and binding the data.

        // Data that is available at the binding time, including strings, can just be assigned...
        viewContoller.title = NSLocalizedString("Rooms", comment: "")

        // ...while the data that is exposed as a signal should be bound to the view controller or its subviews.
        roomService.rooms
            // Convert LoadingSignal into SafeSignal by consuming it loading state.
            // UIViewController conforms to LoadingStateListener protocol by displaying an activity
            // indicator view while the signal is in the loading state.
            .consumeLoadingState(by: viewContoller)
            // Using Bond, we can bind rooms signal to a collection view.
            .bind(to: viewContoller.roomsCollectionView, cellType: RoomCell.self) { cell, room in
                cell.nameLabel.text = room.name
            }

        // A signal that emits an index path when user selects a room cell.
        viewContoller.roomsCollectionView.reactive.selectedItemIndexPath
            // Map index path into the respective Room instance
            .with(latestFrom: roomService.rooms.value(), combine: itemAtIndexPath)
            // Binding to viewContoller ensures that the signal is alive only while viewContoller is alive.
            .bind(to: viewContoller) { viewContoller, room in
                // We tell to router to navigate to the RoomViewController.
                // Actual routing is handled by the navigation controller.
                router.navigate(to: .room(room))
            }

        // Binder always returns a wireframe.
        return Wireframe(for: viewContoller, router: router)
    }
}
