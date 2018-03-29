//
//  Token.swift
//  Entities
//
//  Created by Srdan Rasic on 17/02/2018.
//  Copyright © 2018 DeclarativeHub. All rights reserved.
//

public struct AccessToken: Codable {

    public enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
    }

    public let accessToken: String   // The token that can be used to access the Gitter API.
    public let tokenType: String     // The type of token received: bearer.
}
