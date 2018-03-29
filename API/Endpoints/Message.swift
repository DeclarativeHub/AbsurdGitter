//
//  Message.swift
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

extension Message {

    public func update(text: String, roomId: String) -> GitterRequest<Message> {
        return GitterRequest(
            path: "rooms/\(roomId)/chatMessages/\(id)",
            method: .put,
            parameters: JSONParameters(["text": text]),
            authorization: .required
        )
    }
}
