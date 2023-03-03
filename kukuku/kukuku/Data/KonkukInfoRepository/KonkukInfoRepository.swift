//
//  KonkukInfoRepository.swift
//  kukuku
//
//  Created by youtak on 2023/03/03.
//

import Foundation

struct DefaultKonkukInfoRepository {

    func konkukInfoList() -> [KonkukInfo] {

        guard let path = Bundle.main.path(forResource: "KonkukInfoList", ofType: "json") else {
            fatalError("알쓸건잡 데이터 없음1")
        }

        guard let jsonString = try? String(contentsOfFile: path) else {
            fatalError("알쓸건잡 데이터 없음2")
        }

        guard let data = jsonString.data(using: .utf8) else {
            fatalError("알쓸건잡 데이터 없음3")
        }

        guard let decodeKonkukInfoList = try? JSONDecoder().decode(KonkukInfoList.self, from: data) else {
            fatalError("알쓸건잡 디코딩")
        }

        return decodeKonkukInfoList.list
    }
}
