//
//  RoomService.swift
//  Services
//
//  Created by Srdan Rasic on 17/02/2018.
//  Copyright © 2018 DeclarativeHub. All rights reserved.
//

import API
import Client
import Entities
import ReactiveKit

/// Loads all rooms for the current user.
public class RoomService {

    public let client: GitterClient

    public let rooms: LoadingProperty<[Room], ApplicationError>

    public init(_ client: GitterClient, userService: UserService) {
        self.client = client

        rooms = LoadingProperty {
            userService.currentUser.flatMapValue(.latest) { user in
                user.getRooms().response(using: client)
            }
        }
    }

    public func leaveRoom(_ room: Room) -> LoadingSignal<Room, ApplicationError> {
        return room
            .leave()
            .response(using: client)
            .reloading(rooms)
            .toLoadingSignal()
    }
}
