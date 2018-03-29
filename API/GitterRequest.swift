//
//  Request.swift
//  API
//
//  Created by Srdan Rasic on 17/02/2018.
//  Copyright © 2018 DeclarativeHub. All rights reserved.
//

import Foundation
import Entities
import Client
import ReactiveKit

/// Describes an HTTP request / GitterAPI endpoint.
public struct GitterRequest<Resource: Decodable> {

    public enum Authorization {
        case none
        case required
    }

    public var path: String
    public var method: HTTPMethod
    public var parameters: RequestParameters?
    public var headers: [String: String]?
    public var authorization: Authorization

    public init(path: String,
                method: HTTPMethod,
                parameters: RequestParameters? = nil,
                headers: [String: String]? = nil,
                authorization: Authorization) {

        self.path = path
        self.method = method
        self.parameters = parameters
        self.headers = headers
        self.authorization = authorization
    }
}

extension GitterRequest {

    /// Convert GitterRequest into Client.Request. GitterRequest resources are JSON decodable.
    var asClientRequest: Request<Resource, GitterError> {
        return Request(
            path: path,
            method: method,
            parameters: parameters,
            headers: headers,
            resource: {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                return try decoder.decode(Resource.self, from: $0)
            },
            error: {
                let decoder = JSONDecoder()
                return try decoder.decode(GitterError.self, from: $0)
            }
        )
    }
}

extension GitterRequest {

    mutating func set(_ value: String?, forHttpHeader key: String) {
        var headers = self.headers ?? [:]
        headers[key] = value
        self.headers = headers
    }
}

extension GitterRequest {

    /// A convenience method that creates a signal that will execute the request
    /// using the given client.
    public func response(using client: GitterClient) -> Signal<Resource, ApplicationError> {
        return client.perform(self)
    }
}

