//
//  GuideViewUITests.swift
//  kukukuUITests
//
//  Created by youtak on 2023/03/10.
//

import XCTest

//@testable import kukuku

final class GuideViewUITests: XCTestCase {

    private var app:XCUIApplication!
    private var guideButton: XCUIElement!
    private var nextButton: XCUIElement!

    override func setUpWithError() throws {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()

        guideButton = app.buttons["HomeGuideButton"]
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_guide_read_go_to_home() throws {
        guideButton.tap()

        nextButton = app.buttons["GuideNextButton"]
        nextButton.tap()
        nextButton.tap()
        nextButton.tap()
        nextButton.tap()
    }
}
