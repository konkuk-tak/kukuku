//
//  GuideViewModel.swift
//  kukuku
//
//  Created by youtak on 2023/03/02.
//

import UIKit

final class GuideViewModel {

    private var guideUseCase: GuideUseCase
    private var guideInfoList: [GuideInfo] = []
    private (set)var currentIndex = 0

    init(guideUseCase: GuideUseCase) {
        self.guideUseCase = guideUseCase
        guideInfoList = guideUseCase.guideInfo()
    }

    var nextIndex: Int {
        currentIndex += 1
        return currentIndex
    }

    func infoListCount() -> Int {
        return guideInfoList.count
    }

    func guideInfo(index: Int) -> GuideInfo? {
        return index < guideInfoList.count ? guideInfoList[index] : nil
    }
}
