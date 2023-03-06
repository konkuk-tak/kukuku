//
//  LocationStatus.swift
//  kukuku
//
//  Created by youtak on 2023/03/03.
//

import Foundation

enum LocationStatus {
    case notDetermined
    case success
    case fail
}

extension LocationStatus {
    var message: String {
        switch self {
        case .notDetermined: return "Searching For Location"
        case .success: return "Let's look for the hamburger!"
        case .fail: return "It's not the right location"
        }
    }
}
