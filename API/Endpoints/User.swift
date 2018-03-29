//
//  User.swift
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

extension User {

    public static func me() -> GitterRequest<User> {
        return GitterRequest(
            path: "user/me",
            method: .get,
            authorization: .required
        )
    }

    public static func get(limit: Int? = nil, skip: Int? = nil) -> GitterRequest<[User]> {
        let parameters: [String: Any?] = ["limit": limit, "skip": skip]
        return GitterRequest(
            path: "user",
            method: .get,
            parameters: JSONParameters(parameters),
            authorization: .required
        )
    }

    public static func query(_ q: String, limit: Int? = nil, skip: Int? = nil) -> GitterRequest<[User]> {
        let parameters: [String: Any?] = ["q": q, "limit": limit, "skip": skip]
        return GitterRequest(
            path: "user",
            method: .get,
            parameters: JSONParameters(parameters),
            authorization: .required
        )
    }

    public func getRooms() -> GitterRequest<[Room]> {
        return GitterRequest(
            path: "user/\(id)/rooms",
            method: .get,
            authorization: .required
        )
    }

    public func getChannels() -> GitterRequest<[Room]> {
        return GitterRequest(
            path: "user/\(id)/channels",
            method: .get,
            authorization: .required
        )
    }
}
