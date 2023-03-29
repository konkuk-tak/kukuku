//
//  UserRepository.swift
//  kukuku
//
//  Created by youtak on 2023/03/01.
//

import Foundation

struct DefaultUserRepository: UserRepository {

    func createUser(user: User) throws {
        try KeyChainManager.main.createUser(user: user)
    }

    func readUser() throws -> User {
        try KeyChainManager.main.readUser()
    }

    func updateUser(user: User) throws {
        try KeyChainManager.main.updateUser(user: user)
    }

    func deleteUser() throws {
        try KeyChainManager.main.deleteUser()
    }
}
