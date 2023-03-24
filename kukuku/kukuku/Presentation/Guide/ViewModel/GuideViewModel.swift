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
    private let currentLanguage: LanguageKind

    init(guideUseCase: GuideUseCase, currentLanguage: LanguageKind) {
        self.guideUseCase = guideUseCase
        self.currentLanguage = currentLanguage
        guideInfoList = guideUseCase.guideInfo(languageKind: currentLanguage)
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
