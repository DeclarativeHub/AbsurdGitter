//
//  User.swift
//  Entities
//
//  Created by Srdan Rasic on 17/02/2018.
//  Copyright © 2018 DeclarativeHub. All rights reserved.
//

public struct User: Codable {
    public let id: String              // Gitter User ID.
    public let username: String        // Gitter/GitHub username.
    public let displayName: String     // Gitter/GitHub user real name.
    public let url: String             // Path to the user on Gitter.
    public let avatarUrlSmall: String  // User avatar URI (small).
    public let avatarUrlMedium: String // User avatar URI (medium).
}
