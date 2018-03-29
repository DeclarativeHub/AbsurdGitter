//
//  Room.swift
//  Entities
//
//  Created by Srdan Rasic on 17/02/2018.
//  Copyright © 2018 DeclarativeHub. All rights reserved.
//

public struct Room: Codable {
    public let id: String
    public let name: String            // Room name.
    public let uri: String?            // Room URI on Gitter.
    public let topic: String           // Room topic. (default: GitHub repo description)
    public let oneToOne: Bool          // Indicates if the room is a one-to-one chat.
    public let userCount: Int          // Count of users in the room.
    public let unreadItems: Int        // Number of unread messages for the current user.
    public let mentions: Int           // Number of unread mentions for the current user.
//    public let lastAccessTime: Date?   // Last time the current user accessed the room in ISO format.
//    public let favourite: Bool         // Indicates if the room is on of your favourites.
    public let lurk: Bool              // Indicates if the current user has disabled notifications.
    public let url: String             // Path to the room on gitter.
    public let githubType: String      // Type of the room.
    public let tags: [String]          // Tags that define the room.
}
