//
//  Message.swift
//  Entities
//
//  Created by Srdan Rasic on 17/02/2018.
//  Copyright © 2018 DeclarativeHub. All rights reserved.
//

public struct Message: Codable {
    public let id: String           // ID of the message.
    public let text: String         // Original message in plain-text/markdown.
    public let html: String         // HTML formatted message.
//    public let sent: Date           // ISO formatted date of the message.
//    public let editedAt: Date?      // ISO formatted date of the message if edited.
    public let fromUser: User       // (User)[user-resource] that sent the message.
    public let unread: Bool         // Boolean that indicates if the current user has read the message.
    public let readBy: Int          // Number of users that have read the message.
}
