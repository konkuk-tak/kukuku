//
//  DefaultKonkukInfoUseCase.swift
//  kukuku
//
//  Created by youtak on 2023/03/04.
//

import Foundation

struct DefaultKonkukInfoUseCase: KonkukInfoUseCase {

    private var konkukInfoRepository: KonkukInfoRepository

    func infoList(count: Int) -> [KonkukInfo] {
        let infoList = konkukInfoRepository.konkukInfoList()
        let index = count - 1
        return Array(infoList[0...index])
    }
}
