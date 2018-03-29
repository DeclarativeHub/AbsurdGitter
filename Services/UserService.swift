//
//  UserService.swift
//  Services
//
//  Created by Srdan Rasic on 17/02/2018.
//  Copyright © 2018 DeclarativeHub. All rights reserved.
//

import API
import Client
import Entities
import ReactiveKit

/// Loads currently logged in user
public class UserService {

    public let currentUser: LoadingSignal<User, ApplicationError>

    public init(_ client: GitterClient) {
        currentUser = User
            .me()
            .response(using: client)
            .toLoadingSignal()
            .shareReplayValues(limit: 1)
    }
}
