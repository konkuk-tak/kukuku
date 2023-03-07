//
//  DefaultGuideRepository.swift
//  kukuku
//
//  Created by youtak on 2023/03/03.
//

import Foundation

struct DefaultGuideRepository: GuideRepository {

    func guideInfo(languageKind: LanguageKind) -> [GuideInfo] {
        switch languageKind {
        case .korean: return guideInfoKo()
        case .englishUS: return guideInfoEn()
        }
    }

    private func guideInfoKo() -> [GuideInfo] {
        return [
            GuideInfo(imageName: "guide1", description: "도서관 앞 상허박사 동상 혹은 청심대로 가요"),
            GuideInfo(imageName: "guide2", description: "해당 위치에서 하루에 한 번씩 햄버거를 캐치"),
            GuideInfo(imageName: "guide3", description: "반경 30m 안에서 캐치할 수 있어요"),
            GuideInfo(imageName: "guide4", description: "햄버거를 캐치해서 하루에 한 개씩 `알아두면 쓸데없는 건대 잡학사전`을 완성해요")
        ]
    }

    private func guideInfoEn() -> [GuideInfo] {
        return [
            GuideInfo(imageName: "guide1", description: "To begin `Konkuk University Fun Facts`, go to the statue in front of the Library or `Chung Sim Dae`, the bench next to the University Lake."),
            GuideInfo(imageName: "guide2", description: "Catch a hamburger each day at the location"),
            GuideInfo(imageName: "guide3", description: "It is catchable within 30-meter radius."),
            GuideInfo(imageName: "guide4", description: "Catch the Hamburger everyday to Complete `Konuk University Fun Facts`")
        ]
    }
}
