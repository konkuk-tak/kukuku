//
//  KonkukInfoRepository.swift
//  kukuku
//
//  Created by youtak on 2023/03/03.
//

import Foundation

struct DefaultKonkukInfoRepository {

    func konkukInfoList() -> [KonkukInfo]? {

        guard let path = Bundle.main.path(forResource: "KonkukInfoList", ofType: "json") else {
            print("알쓸건잡 데이터 없음1")
            return nil
        }

        guard let jsonString = try? String(contentsOfFile: path) else {
            print("알쓸건잡 데이터 없음2")
            return nil
        }

        guard let data = jsonString.data(using: .utf8) else {
            print("알쓸건잡 데이터 없음3")
            return nil
        }

        guard let decodeKonkukInfoList = try? JSONDecoder().decode(KonkukInfoList.self, from: data) else {
            print("디코딩 실패")
            return nil
        }

        return decodeKonkukInfoList.list
    }
}
