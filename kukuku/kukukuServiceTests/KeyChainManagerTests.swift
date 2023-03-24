//
//  KeyChainManagerTests.swift
//  kukukuServiceTests
//
//  Created by youtak on 2023/03/24.
//

import XCTest

@testable import kukuku

final class KeyChainManagerTests: XCTestCase {

    private var testKeyChainManager: KeyChainManager!
    private var testUser = User(type: .normal, listCount: 1, log: [Date()])

    override func setUpWithError() throws {
        self.testKeyChainManager = KeyChainManager.main
        try testKeyChainManager.deleteUser()
    }

    override func tearDownWithError() throws {
    }

    func test_1_create_user() throws {
        try testKeyChainManager.createUser(user: testUser)
    }

    func test_2_read_user() throws {
        try testKeyChainManager.createUser(user: testUser)
        let readUser = try testKeyChainManager.readUser()
        XCTAssertEqual(readUser, testUser)
    }

    func test_3_update_user() throws {
        try testKeyChainManager.createUser(user: testUser)
        let updateUser = User(type: .normal, listCount: 4, log: [Date(), Date(), Date(), Date()])
        try testKeyChainManager.updateUser(user: updateUser)
        let readUser = try testKeyChainManager.readUser()
        XCTAssertEqual(readUser, updateUser)
    }

    func test_4_remove_user() throws {
        try testKeyChainManager.deleteUser()
    }
}
