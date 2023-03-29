//
//  KonkukInfoUITests.swift
//  kukukuUITests
//
//  Created by youtak on 2023/03/10.
//

import XCTest

final class KonkukInfoUITests: XCTestCase {

    private var app:XCUIApplication!
    private var konukInfoListButton: XCUIElement!

    override func setUpWithError() throws {
        // In UI tests it is    usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()

        konukInfoListButton = app.buttons["HomeKonkukInfoListButton"]
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_move_konkukInfo_List() throws {
        konukInfoListButton.tap()
    }

    func test_move_konkukInfo_List_and_Detail() throws {
        konukInfoListButton.tap()
        app.tables.element(boundBy: 0).cells.element(boundBy: 0).tap()
        app.buttons["CompleteButton"].tap()
    }

    func test_move_konkukInfo_List_and_Detail_30() throws {
        let index = 30 - 1
        konukInfoListButton.tap()
        app.tables.element(boundBy: 0).cells.element(boundBy: index).tap()
        app.buttons["CompleteButton"].tap()
    }
}
