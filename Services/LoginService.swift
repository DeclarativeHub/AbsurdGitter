//
//  LoginService.swift
//  Services
//
//  Created by Srdan Rasic on 18/02/2018.
//  Copyright © 2018 DeclarativeHub. All rights reserved.
//

import API
import Client
import Entities
import ReactiveKit

/// Authenticates the user by exchanging the OAuth code for access token.
public class LoginService {

    private static let authorizationBaseURL = "https://gitter.im/login/oauth/authorize"
    private static let clientID = "c1c237bf98bfac127978ff0af4b0515a9824bb62"
    private static let secret = "257812a491dc0cedb46f116b2751f2183a690c54"
    private static let redirectURI = "absurd-gitter://authenticationToken"

    private var authorizationURL: URL {
        return URL(string: "\(LoginService.authorizationBaseURL)?client_id=\(LoginService.clientID)&response_type=code&redirect_uri=\(LoginService.redirectURI)")!
    }

    private let tokenCode = PassthroughSubject<String, Never>()

    /// Will emit an access token when the user authorizes the app
    public let accessToken: SafeSignal<AccessToken>

    public init(_ client: GitterClient) {
        // When we get the code, request the token
        accessToken = tokenCode.flatMapLatest { code in
            OAuth
                .token(clientID: LoginService.clientID, secret: LoginService.secret, code: code, redirectURI: LoginService.redirectURI)
                .response(using: client)
                .suppressError(logging: true)
        }.share()
    }

    /// Observe url scheme deep link - contains OAuth code when user logs in.
    public func handleOpenUrl(_ url: URL) -> Bool {
        if isRedirect(url) {
            if let code = parseCodeFrom(url) {
                tokenCode.send(code)
            } else {
                log.error("No token code received.")
            }
            return true
        } else {
            return false
        }
    }

    public func startLogin() {
        UIApplication.shared.open(authorizationURL)
    }

    private func isRedirect(_ url: URL) -> Bool {
        return url.absoluteString.lowercased().hasPrefix(LoginService.redirectURI.lowercased())
    }

    private func parseCodeFrom(_ url: URL) -> String? {
        let components = URLComponents(url: url as URL, resolvingAgainstBaseURL: false)!

        if let keyValue = components.queryItems?.filter({ $0.name == "code" }).first, let code = keyValue.value  {
            return code
        } else {
            return nil
        }
    }
}

