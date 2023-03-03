//
//  User.swift
//  kukuku
//
//  Created by youtak on 2023/03/03.
//

import Foundation

struct User {
    let type: UserType
    let score: Int
    let log: [Date]
}

enum UserType {
    case normal
    case developer
}
