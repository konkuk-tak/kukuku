//
//  kukukuUITests.swift
//  kukukuUITests
//
//  Created by youtak on 2023/03/09.
//

import XCTest

final class kukukuUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()    
    }

    func testLaunchPerformance() throws {
        if #available(iOS 15.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
