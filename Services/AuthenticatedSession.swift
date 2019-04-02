//
//  Session.swift
//  Services
//
//  Created by Srdan Rasic on 17/02/2018.
//  Copyright © 2018 DeclarativeHub. All rights reserved.
//

import API
import Entities
import ReactiveKit

public protocol AuthenticatedSessionDelegate: class {
    func didInvalidateAuthenticatedSession(_ session: AuthenticatedSession)
}

public class AuthenticatedSession {

    private let gitterAPIBaseURL = "https://api.gitter.im/v1"
    private let accessToken: AccessToken

    // HTTP client is usually defined on the session.
    public let client: GitterClient

    // Services that should be alive during the session
    // should be declared on the session itself. No sigletons.
    public let userService: UserService
    public let roomService: RoomService

    public weak var delegate: AuthenticatedSessionDelegate?

    public init(_ accessToken: AccessToken) {
        self.accessToken = accessToken
        client = GitterClient(baseURL: gitterAPIBaseURL)
        userService = UserService(client)
        roomService = RoomService(client, userService: userService)
        client.delegate = self
    }

    public func invalidate() {
        delegate?.didInvalidateAuthenticatedSession(self)
    }
}

extension AuthenticatedSession: GitterClientDelegate {

    // Session is a delegate of the our HTTP client. The client asks the session to authorize each request with the token.
    public func authorize<Resource>(_ request: GitterRequest<Resource>, client: GitterClient) -> Signal<GitterRequest<Resource>, ApplicationError> {
        return Signal(just: request.authorized(with: accessToken))
    }
}
