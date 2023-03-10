//
//  ARGameViewUITests.swift
//  kukukuUITests
//
//  Created by youtak on 2023/03/10.
//

import XCTest

final class ARGameUITests: XCTestCase {

    private var app:XCUIApplication!
    private var arButton: XCUIElement!

    override func setUpWithError() throws {
        // In UI tests it is    usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()

        arButton = app.buttons["HomeARButton"]
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_move_and_exit_arView() throws {
        arButton.tap()
        let exitButton = app.buttons["ARGameExitButton"]
        exitButton.tap()
    }
}
