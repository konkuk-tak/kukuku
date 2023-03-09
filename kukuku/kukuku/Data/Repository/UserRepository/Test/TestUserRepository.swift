//
//  TestUserRepository.swift
//  kukuku
//
//  Created by youtak on 2023/03/09.
//

import Foundation

final class TestUserRepository: UserRepository {

    func createUser(user: User) throws {}

    func readUser() throws -> User {
        return User(type: .normal, listCount: 30, log: createThirtyDaysLogs())
    }

    func updateUser(user: User) throws {}

    func deleteUser() throws {}

    private func createThirtyDaysLogs() -> [Date] {
        let standardValue = -32
        var result: [Date] = []
        for beforeDay in 0..<30 {
            if let target = Calendar.current.date(byAdding: .day, value: standardValue + beforeDay, to: Date()) {
                result.append(target)
            }
        }
        return result
    }
}
