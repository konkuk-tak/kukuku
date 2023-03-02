//
//  GuideViewModel.swift
//  kukuku
//
//  Created by youtak on 2023/03/02.
//

import UIKit

final class GuideViewModel {

    private var guideInfoList: [GuideInfo] = []
    private (set)var currentIndex = 0

    var nextIndex: Int {
        currentIndex += 1
        return currentIndex
    }

    func setGuideInfoList() {
        guideInfoList = getGuideInfoList()
    }

    func infoListCount() -> Int {
        return guideInfoList.count
    }

    func guideInfo(index: Int) -> GuideInfo? {
        return index < guideInfoList.count ? guideInfoList[index] : nil
    }

    private func getGuideInfoList() -> [GuideInfo] {
        let dummy = GuideInfo(imageName: "person", description: "안녕하세요. 안녕하세요.안녕하세요.안녕하세요.안녕하세요.안녕하세요.안녕하세요.")
        return Array(repeating: dummy, count: 4)
    }
}
