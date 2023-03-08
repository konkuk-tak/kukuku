//
//  DarkModeUseCaseTests.swift
//  kukukuUseCaseTests
//
//  Created by youtak on 2023/03/08.
//

import XCTest

@testable import kukuku

final class DarkModeUseCaseTests: XCTestCase {

    private var mockDarkModeRepository: MockDarkModeRepository!
    private var darkModeUseCase: DarkModeUseCase!

    override func setUpWithError() throws {
        self.mockDarkModeRepository = MockDarkModeRepository()
        self.darkModeUseCase = DefaultDarkModeUseCase(darkModeRepository: mockDarkModeRepository)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_save() throws {
        darkModeUseCase.save(.dark)
        XCTAssertEqual(mockDarkModeRepository.currentDarkMode, .dark)
    }

    func test_save_read() throws {
        darkModeUseCase.save(.dark)
        let savedDarkMode = darkModeUseCase.read()
        XCTAssertEqual(savedDarkMode, .dark)
    }

    func test_read_initial_mode() throws {
        XCTAssertEqual(darkModeUseCase.read(), .system)
    }
}
