//
//  MessageService.swift
//  Services
//
//  Created by Srdan Rasic on 18/02/2018.
//  Copyright © 2018 DeclarativeHub. All rights reserved.
//

import API
import Client
import Entities
import ReactiveKit

/// Loads messages for the given room.
public class MessageService {

    public let client: GitterClient
    public let room: Room

    public let messages: LoadingProperty<[Message], ApplicationError>

    public init(_ client: GitterClient, room: Room) {
        self.client = client
        self.room = room

        messages = LoadingProperty {
            room.getMessages(limit: 50).response(using: client).toLoadingSignal()
        }
    }

    /// Send a message with the body
    public func sendMessage(_ body: String) -> LoadingSignal<Message, ApplicationError> {
        return room
            .sendMessage(body)
            .response(using: client)
            .reloading(messages)
            .toLoadingSignal()
    }
}
