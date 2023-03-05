//
//  DefaultUserUseCase.swift
//  kukuku
//
//  Created by youtak on 2023/03/03.
//

import Foundation

struct DefaultUserUseCase: UserUseCase {

    private var userRepository: UserRepository
    private var developerCodeRepository: DeveloperCodeRepository

    init(userRepository: UserRepository, developerCodeRepository: DeveloperCodeRepository) {
        self.userRepository = userRepository
        self.developerCodeRepository = developerCodeRepository
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
        if user.type == .developer { return true}
        guard let lastDate = user.log.last else { return true }
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

    func updateToDeveloperType(user: User, code: String) throws -> User? {
        if isDeveloperCode(code) {
            let developerUser = User(type: .developer, score: user.score, log: user.log)
            try userRepository.updateUser(user: developerUser)
            return developerUser
        }
        return nil
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

    private func isDeveloperCode(_ code: String) -> Bool {
        guard let developerCode = developerCodeRepository.code() else { return false }
        return developerCode == code
    }
}
