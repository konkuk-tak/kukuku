//
//  DefaultGuideRepository.swift
//  kukuku
//
//  Created by youtak on 2023/03/03.
//

import Foundation

struct DefaultGuideRepository: GuideRepository {

    func guideInfo() -> [GuideInfo] {
        return createGuideInfo()
    }

    private func createGuideInfo() -> [GuideInfo] {
        return [
            GuideInfo(imageName: "guide1", description: "도서관 앞 상허박사 동상 혹은 청심대로 가요"),
            GuideInfo(imageName: "guide2", description: "해당 위치에서 하루에 한 번씩 햄버거를 캐치"),
            GuideInfo(imageName: "guide3", description: "반경 30m 안에서 캐치할 수 있어요"),
            GuideInfo(imageName: "guide4", description: "햄버거를 캐치해서 하루에 한 개씩 알아두면 쓸데없는 건대 잡학사전을 완성해요")
        ]
    }
}
