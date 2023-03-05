//
//  KonkukInfo.swift
//  kukuku
//
//  Created by youtak on 2023/03/03.
//

import Foundation

struct KonkukInfo: Decodable {
    let id: String
    let imageURL: String
    let imageReference: String
    let title: String
    let description: String

    enum CodingKeys: String, CodingKey {
        case id
        case imageURL
        case imageReference = "imageRef"
        case title
        case description
    }
}
