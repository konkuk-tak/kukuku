//
//  DefaultUserUseCase.swift
//  kukuku
//
//  Created by youtak on 2023/03/03.
//

import Foundation

struct DefaultUserUseCase: UserUseCase {

    private var userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

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

    func canPlay(_ user: User) -> Bool {
        guard let lastDate = user.log.last else {
            return true
        }
        return !Calendar.current.isDateInToday(lastDate)
    }

    func finishDailyGame(user: User) throws -> User {
        let updatedUser = dailyUpdate(user: user)
        try updateUser(updatedUser)
        return updatedUser
    }

    func deleteUser() throws {
        try userRepository.deleteUser()
    }

    private func createNewUser() -> User {
        return User(type: .normal, score: 0, log: [])
    }

    private func updateUser(_ user: User) throws {
        try userRepository.updateUser(user: user)
    }

    private func dailyUpdate(user: User) -> User {
        let newDateLog = user.log + [Date()]
        let score = user.score + 1
        return User(type: user.type, score: score, log: newDateLog)
    }
}
