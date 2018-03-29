//
//  UnauthenticatedSession.swift
//  Services
//
//  Created by Srdan Rasic on 18/02/2018.
//  Copyright © 2018 DeclarativeHub. All rights reserved.
//

import API
import Entities
import ReactiveKit

public protocol UnauthenticatedSessionDelegate: class {
    func didObtainAccessToken(_ accessToken: AccessToken)
}

public class UnauthenticatedSession: DisposeBagProvider {

    private let gitterAuthenticationAPIBaseURL = "https://gitter.im/login/oauth"

    // HTTP client is usually defined on the session.
    public let client: GitterClient

    // Services that should be alive during the session
    // should be declared on the session itself. No sigletons.
    public let loginService: LoginService

    public weak var delegate: UnauthenticatedSessionDelegate?
    public let bag = DisposeBag()

    public init() {
        client = GitterClient(baseURL: gitterAuthenticationAPIBaseURL)
        loginService = LoginService(client)

        // When the token is obtained, inform the SessionManager (our delegate) so that it can
        // create and set a new authenticated session with the obtained token.
        loginService.accessToken.bind(to: self, context: .immediateOnMain) { me, accessToken in
            me.delegate?.didObtainAccessToken(accessToken)
        }
    }
}
