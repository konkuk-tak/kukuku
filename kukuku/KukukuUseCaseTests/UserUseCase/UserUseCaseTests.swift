//
//  UserUseCaseTests.swift
//  kukukuUseCaseTests
//
//  Created by youtak on 2023/03/08.
//

import XCTest

@testable import kukuku

final class UserUseCaseTests: XCTestCase {

    private var mockUserRepository: MockUserRepository!
    private var mockDeveloperCodeRepository: MockDeveloperCodeRepository!
    private var userUseCase: UserUseCase!

    override func setUpWithError() throws {
        self.mockUserRepository = MockUserRepository()
        self.mockDeveloperCodeRepository = MockDeveloperCodeRepository()
        self.userUseCase = DefaultUserUseCase(
            userRepository: mockUserRepository,
            developerCodeRepository: mockDeveloperCodeRepository
        )
    }

    override func tearDownWithError() throws {
    }

    func test_read_user() throws {
        let user = try userUseCase.readUser()
        XCTAssertEqual(user, User(type: .normal, listCount: 0, log: []))
    }

    func test_canPlay_true() throws {
        let normalUser = User(type: .normal, listCount: 0, log: [])
        let result = userUseCase.canPlay(normalUser)
        XCTAssertEqual(result, true)
    }

    func test_canPlay_true_개발자모드() throws {
        let today = Date()
        let user = User(type: .developer, listCount: 1, log: [today])
        let result = userUseCase.canPlay(user)
        XCTAssertEqual(result, true)
    }

    func test_canPlay_true_어제플레이() throws {
        let yesterday = try XCTUnwrap(Calendar.current.date(byAdding: .day, value: -1, to: Date()))
        let user = User(type: .normal, listCount: 1, log: [yesterday])
        let result = userUseCase.canPlay(user)
        XCTAssertEqual(result, true)
    }

    func test_canPlay_false_오늘플레이_완료() throws {
        let today = Date()
        let user = User(type: .normal, listCount: 1, log: [today])
        let result = userUseCase.canPlay(user)
        XCTAssertEqual(result, false)
    }

    func test_updateUser_게임플레이_완료() throws {
        let user = User(type: .normal, listCount: 0, log: [])
        let updatedUser = try userUseCase.finishDailyGame(user: user)
        XCTAssertEqual(updatedUser, mockUserRepository.storedUser)
    }

    func test_deleteUser_유저삭제() throws {
        try userUseCase.deleteUser()
        XCTAssertNil(mockUserRepository.storedUser)
    }

    func test_updateToDeveloper_성공() throws {
        let user = User(type: .normal, listCount: 0, log: [])
        let updatedUser = try userUseCase.updateToDeveloperType(user: user, code: "DeveloperCode")
        XCTAssertEqual(mockUserRepository.storedUser?.type, .developer)
    }

    func test_updateToDeveloper_실패() throws {
        let user = User(type: .normal, listCount: 0, log: [])
        let updatedUser = try userUseCase.updateToDeveloperType(user: user, code: "")
        XCTAssertEqual(updatedUser, nil)
    }
}
