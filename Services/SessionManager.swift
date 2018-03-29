//
//  SessionManager.swift
//  Services
//
//  Created by Srdan Rasic on 18/02/2018.
//  Copyright © 2018 DeclarativeHub. All rights reserved.
//

import API
import Entities
import ReactiveKit

/// Manages current session.
/// When user logs in, new AuthenticatedSession is created and set as a current session.
/// When user logs out, new UnauthenticatedSession is created and set as a current session.
public class SessionManager: DisposeBagProvider {

    public enum Session {
        case authenticated(AuthenticatedSession)
        case unauthenticated(UnauthenticatedSession)
    }

    public let currentSession: Property<Session>
    public let bag = DisposeBag()

    public init() {
        // If we already have an access token, start with AuthenticatedSession,
        // otherwise start with UnauthenticatedSession.
        if let accessToken = SessionManager.savedAccessToken {
            let session = AuthenticatedSession(accessToken)
            currentSession = Property(.authenticated(session))
            session.delegate = self
        } else {
            let session = UnauthenticatedSession()
            currentSession = Property(.unauthenticated(session))
            session.delegate = self
        }
    }

    /// Called by the AppDelegete when the app receives `application(:open:)`.
    public func handleOpenUrl(_ url: URL) -> Bool {
        switch currentSession.value {
        case .unauthenticated(let session):
            return session.loginService.handleOpenUrl(url)
        default:
            return false
        }
    }

    // MARK: Access Token Management
    // Note: Never save your access token to UserDefaults, use Keychain instead! This is just a demo app.

    private func saveAccessToken(_ accessToken: AccessToken) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(accessToken) {
            UserDefaults.standard.set(data, forKey: "access-token")
            UserDefaults.standard.synchronize()
        }
    }

    private func removeAccessToken() {
        UserDefaults.standard.set(nil, forKey: "access-token")
        UserDefaults.standard.synchronize()
    }

    private static var savedAccessToken: AccessToken? {
        guard let data = UserDefaults.standard.object(forKey: "access-token") as? Data else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode(AccessToken.self, from: data)
    }
}

extension SessionManager: UnauthenticatedSessionDelegate {

    public func didObtainAccessToken(_ accessToken: AccessToken) {
        /// Save access token and create new authenticated session
        saveAccessToken(accessToken)
        let session = AuthenticatedSession(accessToken)
        session.delegate = self
        currentSession.value = .authenticated(session)
    }
}

extension SessionManager: AuthenticatedSessionDelegate {

    public func didInvalidateAuthenticatedSession(_ session: AuthenticatedSession) {
        /// Remove access token and create new unauthenticated session
        removeAccessToken()
        let session = UnauthenticatedSession()
        session.delegate = self
        currentSession.value = .unauthenticated(session)
    }
}
