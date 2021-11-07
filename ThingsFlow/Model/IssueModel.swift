//
//  IssueModel.swift
//  ThingsFlow
//
//  Created by TaeWon Seo on 2021/11/07.
//

import Foundation

struct Issue: Decodable {
    let number: Int
    let title: String
    let body: String?
    let user: User
}

struct User: Decodable {
    let name: String
    let profileImageURL: String
    
    enum CodingKeys: String, CodingKey {
        case name = "login"
        case profileImageURL = "avatar_url"
    }
}
