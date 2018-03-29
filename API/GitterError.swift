//
//  GitterError.swift
//  API
//
//  Created by Srdan Rasic on 17/02/2018.
//  Copyright © 2018 DeclarativeHub. All rights reserved.
//

public struct GitterError: Swift.Error, LocalizedError, Codable {

    public let message: String

    public var errorDescription: String? {
        return message
    }
}
