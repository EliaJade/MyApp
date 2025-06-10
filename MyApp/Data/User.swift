//
//  User.swift
//  MyApp
//
//  Created by Mañanas on 10/6/25.
//

import Foundation


struct User: Codable {
        var id: String
        var username: String
        var firstNames: String
        var surnames: String
        var gender: Gender
        var birthday: Date?
        var provider: LoginProvider
        var profileImageURL: String?
}

enum Gender: String, Codable {
    case female
    case male
    case other
    case unspecified
}

enum LoginProvider: String, Codable {
    case basic
    case google
    case apple
    case facebook
}
