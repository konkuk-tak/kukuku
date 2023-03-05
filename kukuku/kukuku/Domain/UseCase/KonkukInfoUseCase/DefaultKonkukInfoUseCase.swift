//
//  DefaultKonkukInfoUseCase.swift
//  kukuku
//
//  Created by youtak on 2023/03/04.
//

import Foundation

struct DefaultKonkukInfoUseCase: KonkukInfoUseCase {

    private var konkukInfoRepository: KonkukInfoRepository

    init(konkukInfoRepository: KonkukInfoRepository) {
        self.konkukInfoRepository = konkukInfoRepository
    }

    func infoList(count: Int) -> UserKonkukInfoList {
        let infoList = konkukInfoRepository.konkukInfoList() ?? []
        let userKonkukInfoList = UserKonkukInfoList(list: Array(infoList[0..<count]), maxCount: infoList.count)
        return userKonkukInfoList
    }

    func info(index: Int) -> KonkukInfo? {
        guard let infoList = konkukInfoRepository.konkukInfoList() else { return nil }
        if index >= infoList.count { return nil }
        return infoList[index]
    }
}
