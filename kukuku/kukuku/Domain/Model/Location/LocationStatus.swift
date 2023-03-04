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
        case .notDetermined: return "위치 탐색 중"
        case .success: return "적당한 위치에요. 햄버거를 찾아봐요!"
        case .fail: return "정해진 위치가 아니에요"
        }
    }
}
