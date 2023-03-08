//
//  MockUserRepository.swift
//  kukukuUseCaseTests
//
//  Created by youtak on 2023/03/08.
//

import Foundation

@testable import kukuku

final class MockUserRepository: UserRepository {

    var storedUser: kukuku.User?

    func createUser(user: kukuku.User) throws {
        storedUser = user
    }

    func readUser() throws -> kukuku.User {
        guard let storedUser = storedUser else {
            throw KeychainError.noData
        }
        return storedUser
    }

    func updateUser(user: kukuku.User) throws {
        storedUser = user
    }

    func deleteUser() throws {
        storedUser = nil
    }
}
