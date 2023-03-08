//
//  GuideUseCaseTests.swift
//  kukukuUseCaseTests
//
//  Created by youtak on 2023/03/08.
//

import XCTest

@testable import kukuku

final class GuideUseCaseTests: XCTestCase {

    private var guideRepository: GuideRepository!
    private var guideUseCase: GuideUseCase!

    override func setUpWithError() throws {
        self.guideRepository = DefaultGuideRepository()
        self.guideUseCase = DefaultGuideUseCase(guideRepository: guideRepository)
    }

    override func tearDownWithError() throws {
    }

    func test_guide_info_korean() throws {
        let guideInfo = guideUseCase.guideInfo(languageKind: .korean)
        XCTAssertEqual(guideInfo.count, 4)
    }

    func test_guide_info_korean_3rd() throws {
        let guideInfo = guideUseCase.guideInfo(languageKind: .korean)
        XCTAssertEqual(guideInfo[2].description, "반경 30m 안에서 캐치할 수 있어요")
    }

    func test_guide_info_english_us() throws {
        let guideInfo = guideUseCase.guideInfo(languageKind: .englishUS)
        XCTAssertEqual(guideInfo.count, 4)
    }

    func test_guide_info_english_us_4th() throws {
        let guideInfo = guideUseCase.guideInfo(languageKind: .englishUS)
        XCTAssertEqual(guideInfo[3].description, "Catch the Hamburger everyday to Complete `Konuk University Fun Facts`")
    }
}
