//
//  Oauth.swift
//  API
//
//  Created by Srdan Rasic on 17/02/2018.
//  Copyright © 2018 DeclarativeHub. All rights reserved.
//

import Client
import Entities

// We can model our API by defining requests on our entities as extensions.
// GitterRequest does not do any work, it's just a descriptor that defines
// how to make the URLRequest (done by the Client).

// Static functions operate on all entities (resource index).
// Instance function operate on the entity instance (single resource).

public enum OAuth {

    public static func token(clientID: String, secret: String, code: String, redirectURI: String) -> GitterRequest<AccessToken> {
        let parameters: [String: String] = [
            "client_id": clientID,
            "client_secret": secret,
            "code": code,
            "redirect_uri": redirectURI,
            "grant_type": "authorization_code"
        ]
        return GitterRequest(
            path: "token",
            method: .post,
            parameters: JSONParameters(parameters),
            authorization: .none
        )
    }
}
