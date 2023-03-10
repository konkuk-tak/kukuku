//
//  SettingViewUITests.swift
//  kukukuUITests
//
//  Created by youtak on 2023/03/10.
//

import XCTest

final class SettingViewUITests: XCTestCase {

    private var app:XCUIApplication!
    private var settingButton: XCUIElement!
    private var tableView: XCUIElement!

    override func setUpWithError() throws {
        // In UI tests it is    usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()

        settingButton = app.buttons["HomeSettingButton"]
        settingButton.tap()

//        tableView = app.tables["KonkukInfoListTableView"]
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_language_korean() throws {
        // to language setting View
        app.tables.element(boundBy: 0).cells.element(boundBy: 0).tap()

        // press korean
        app.tables.element(boundBy: 0).cells.element(boundBy: 0).tap()

        if app.alerts.buttons["AlertConfirmAction"].exists {
            app.alerts.buttons["AlertConfirmAction"].tap()
        }
    }

    func test_language_englishUS() throws {
        // to language setting View
        app.tables.element(boundBy: 0).cells.element(boundBy: 0).tap()

        // press english
        app.tables.element(boundBy: 0).cells.element(boundBy: 1).tap()

        if app.alerts.buttons["AlertConfirmAction"].exists {
            app.alerts.buttons["AlertConfirmAction"].tap()
        }
    }

    func test_dark_mode_light() throws {
        // to dark mode setting View
        app.tables.element(boundBy: 0).cells.element(boundBy: 1).tap()

        // press light
        app.tables.element(boundBy: 0).cells.element(boundBy: 0).tap()

        if app.alerts.buttons["AlertConfirmAction"].exists {
            app.alerts.buttons["AlertConfirmAction"].tap()
        }
    }

    func test_dark_mode_dark() throws {
        // to dark mode setting View
        app.tables.element(boundBy: 0).cells.element(boundBy: 1).tap()

        // press dark
        app.tables.element(boundBy: 0).cells.element(boundBy: 1).tap()

        if app.alerts.buttons["AlertConfirmAction"].exists {
            app.alerts.buttons["AlertConfirmAction"].tap()
        }
    }

    func test_dark_mode_system() throws {
        // to dark mode setting View
        app.tables.element(boundBy: 0).cells.element(boundBy: 1).tap()

        // press system
        app.tables.element(boundBy: 0).cells.element(boundBy: 2).tap()

        if app.alerts.buttons["AlertConfirmAction"].exists {
            app.alerts.buttons["AlertConfirmAction"].tap()
        }
    }

    func test_delete_data() throws {
        // press delete user
        app.tables.element(boundBy: 0).cells.element(boundBy: 2).tap()

        if app.alerts.buttons["AlertConfirmAction"].exists {
            app.alerts.buttons["AlertCancelAction"].tap()
        }
    }

    func test_developer_code() throws {
        // press developer code
        app.tables.element(boundBy: 0).cells.element(boundBy: 3).tap()

        if app.alerts.buttons["AlertCancelAction"].exists {
            app.alerts.buttons["AlertCancelAction"].tap()
        }

        app.tables.element(boundBy: 0).cells.element(boundBy: 3).tap()

        if app.alerts.buttons["AlertConfirmAction"].exists {
            app.alerts.buttons["AlertConfirmAction"].tap()
            app.alerts.buttons["AlertOkayAction"].tap()
        }
    }
}
