//
//  LanguageUseCaseTests.swift
//  kukukuUseCaseTests
//
//  Created by youtak on 2023/03/08.
//

import XCTest

@testable import kukuku

final class LanguageUseCaseTests: XCTestCase {

    private var mockLanguageRepository: MockLanguageRepository!
    private var languageUseCase: LanguageUseCase!

    override func setUpWithError() throws {
        self.mockLanguageRepository = MockLanguageRepository()
        self.languageUseCase = DefaultLanguageUseCase(languageRepository: mockLanguageRepository)
        print("fdsd")
    }

    override func tearDownWithError() throws {
    }

    func test_language_save_korean() throws {
        languageUseCase.save(.korean)

        XCTAssertEqual(mockLanguageRepository.storedLanguageKind, .korean)
    }

    func test_language_save_korean_read() throws {
        languageUseCase.save(.korean)
        XCTAssertEqual(languageUseCase.read(), .korean)
    }

    func test_language_save_englishUS() throws {
        languageUseCase.save(.englishUS)
        XCTAssertEqual(mockLanguageRepository.storedLanguageKind, .englishUS)
    }

    func test_language_save_englishUS_read() throws {
        languageUseCase.save(.englishUS)
        XCTAssertEqual(languageUseCase.read(), .englishUS)
    }
}
