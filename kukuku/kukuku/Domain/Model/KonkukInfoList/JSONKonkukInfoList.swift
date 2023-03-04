//
//  KonkukInfoList.swift
//  kukuku
//
//  Created by youtak on 2023/03/03.
//

import Foundation

struct JSONKonkukInfoList: Decodable {
    let name: String
    let version: String
    let list: [KonkukInfo]
}
