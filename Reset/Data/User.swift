//
//  User.swift
//  Reset
//
//  Created by Prasanjit Panda on 14/11/24.
//

import Foundation

struct User: Codable {
    var id: UUID // Unique identifier
    var name: String
    var age: Int
    var memberSince: Date
    var soberSince: Date
    var resets: Int
    var streak: Int
    var bloodGroup: String
    var sex: String
    var profileImage: String
    var sponsorID: UUID? // Use an optional UUID to reference the sponsor
    var friends: [UUID] // Store UUIDs of friends to avoid cyclic dependencies
}

