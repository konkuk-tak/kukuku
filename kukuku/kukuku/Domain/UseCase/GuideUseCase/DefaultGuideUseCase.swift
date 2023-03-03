//
//  DefaultGuideUseCase.swift
//  kukuku
//
//  Created by youtak on 2023/03/03.
//

import Foundation

struct DefaultGuideUseCase: GuideUseCase {

    private var guideRepository: GuideRepository

    init(guideRepository: GuideRepository) {
        self.guideRepository = guideRepository
    }

    func guideInfo() -> [GuideInfo] {
        return guideRepository.guideInfo()
    }
}
