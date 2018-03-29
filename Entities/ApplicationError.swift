//
//  ApplicationError.swift
//  API
//
//  Created by Srdan Rasic on 18/02/2018.
//  Copyright © 2018 DeclarativeHub. All rights reserved.
//

public struct ApplicationError: Error, LocalizedError {

    public struct SimpleError: Error, LocalizedError {
        public let message: String

        public var errorDescription: String? {
            return message
        }
    }

    public let underlyingError: Error

    public init(_ underlyingError: Error) {
        self.underlyingError = underlyingError
    }

    public init(_ message: String) {
        self.underlyingError = SimpleError(message: message)
    }

    public var errorDescription: String? {
        if let underlyingError = underlyingError as? LocalizedError {
            return underlyingError.errorDescription
        } else {
            return underlyingError.localizedDescription
        }
    }
}
