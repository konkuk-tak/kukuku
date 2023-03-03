//
//  DefaultUserUseCase.swift
//  kukuku
//
//  Created by youtak on 2023/03/03.
//

import Foundation

struct DefaultUserUseCase: UserUseCase {

    private var userRepository: UserRepository

    func readUser() throws -> User {
        do {
            let user = try userRepository.readUser()
            return user
        } catch {
            let newUser = createNewUser()
            try userRepository.createUser(user: newUser)
            return newUser
        }
    }

    func updateUser(user: User) throws {
        try userRepository.updateUser(user: user)
    }

    func deleteUser() throws {
        try userRepository.deleteUser()
    }

    private func createNewUser() -> User {
        return User(type: .normal, score: 0, log: [])
    }
}
