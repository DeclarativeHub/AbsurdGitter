//
//  Room.swift
//  API
//
//  Created by Srdan Rasic on 17/02/2018.
//  Copyright © 2018 DeclarativeHub. All rights reserved.
//

import Entities
import Client

// We can model our API by defining requests on our entities as extensions.
// GitterRequest does not do any work, it's just a descriptor that defines
// how to make the URLRequest (done by the Client).

// Static functions operate on all entities (resource index).
// Instance function operate on the entity instance (single resource).

extension Room {

    public static func get() -> GitterRequest<[Room]> {
        return GitterRequest(
            path: "rooms",
            method: .get,
            authorization: .required
        )
    }

    public static func query(_ q: String) -> GitterRequest<[Room]> {
        return GitterRequest(
            path: "rooms",
            method: .get,
            parameters: JSONParameters(["q": q]),
            authorization: .required
        )
    }

    public static func join(_ uri: String) -> GitterRequest<Room> {
        return GitterRequest(
            path: "rooms",
            method: .post,
            parameters: JSONParameters(["uri": uri]),
            authorization: .required
        )
    }

    public func getChannels() -> GitterRequest<[Room]> {
        return GitterRequest(
            path: "rooms/\(id)/channels",
            method: .get,
            authorization: .required
        )
    }

    public func sendMessage(_ text: String) -> GitterRequest<Message> {
        return GitterRequest(
            path: "rooms/\(id)/chatMessages",
            method: .post,
            parameters: JSONParameters(["text": text]),
            authorization: .required
        )
    }

    public func getMessages(limit: Int? = nil, skip: Int? = nil) -> GitterRequest<[Message]> {
        let parameters: [String: String?] = ["limit": limit.flatMap { "\($0)"}, "skip": skip.flatMap { "\($0)" }]
        return GitterRequest(
            path: "rooms/\(id)/chatMessages",
            method: .get,
            parameters: QueryParameters(parameters.nonNils),
            authorization: .required
        )
    }

    public func getUsers() -> GitterRequest<[User]> {
        return GitterRequest(
            path: "rooms/\(id)/users",
            method: .get,
            authorization: .required
        )
    }

    public func update(topic: String? = nil, noindex: Bool? = nil, tags: String? = nil) -> GitterRequest<Room> {
        let parameters: [String: Any?] = ["topic": topic, "noindex": noindex, "tags": tags]
        return GitterRequest(
            path: "rooms",
            method: .put,
            parameters: JSONParameters(parameters.nonNils),
            authorization: .required
        )
    }

    public func leave() -> GitterRequest<Room> { // void?
        return GitterRequest(
            path: "rooms",
            method: .delete,
            authorization: .required
        )
    }
}
