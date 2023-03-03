//
//  GameLocation.swift
//  kukuku
//
//  Created by youtak on 2023/03/03.
//

import Foundation

struct GameCoordinate {
    let latitude: Double
    let longitude: Double
}

extension GameCoordinate {
    static func create() -> [GameCoordinate] {
        return [
            GameCoordinate(latitude: 37.542416, longitude: 127.076805), // 청심대
            GameCoordinate(latitude: 37.54137, longitude: 127.07347) // 상허 박사 동상
        ]
    }
}
