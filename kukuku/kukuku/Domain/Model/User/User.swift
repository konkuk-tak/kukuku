//
//  User.swift
//  kukuku
//
//  Created by youtak on 2023/03/03.
//

import Foundation

struct User: Codable {
    let type: UserType
    let listCount: Int
    let log: [Date]
}

extension User {
    var score: Int {
        return log.count
    }
}

enum UserType: Codable {
    case normal
    case developer
}
