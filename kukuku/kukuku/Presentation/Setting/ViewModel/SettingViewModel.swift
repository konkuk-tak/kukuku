//
//  SettingViewModel.swift
//  kukuku
//
//  Created by youtak on 2023/03/04.
//

import Combine
import Foundation

final class SettingViewModel {

    private (set)var user: User
    private (set)var currentLanguage: LanguageKind

    private var userUseCase: UserUseCase

    init(user: User, currentLanguage: LanguageKind, userUseCase: UserUseCase) {
        self.user = user
        self.currentLanguage = currentLanguage
        self.userUseCase = userUseCase
    }

    struct Input {
        let deleteUser: AnyPublisher<Void, Never>
        let developerCode: AnyPublisher<String, Never>
    }

    struct Output {
        let deleteUserResult: AnyPublisher<Void?, Error>
        let developerModeUpdate: AnyPublisher<Bool?, Error>
    }

    func transform(input: Input) -> Output {

        let deleteUserResult = input.deleteUser
            .tryMap { [weak self] _ in
                try self?.deleteUser()
            }
            .eraseToAnyPublisher()

        let developerModeUpdate = input.developerCode
            .tryMap { [weak self] code in
                try self?.updateToDeveloperMode(code: code)
            }
            .eraseToAnyPublisher()

        let output = Output(deleteUserResult: deleteUserResult, developerModeUpdate: developerModeUpdate)
        return output
    }

    private func deleteUser() throws {
        try userUseCase.deleteUser()
    }

    private func updateToDeveloperMode(code: String) throws -> Bool {
        let updatedUser = try userUseCase.updateToDeveloperType(user: user, code: code)
        if let updatedUser = updatedUser {
            self.user = updatedUser
            return true
        }
        return false
    }
}
