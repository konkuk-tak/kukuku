//
//  SettingViewModel.swift
//  kukuku
//
//  Created by youtak on 2023/03/04.
//

import Combine
import Foundation

final class SettingViewModel {

    private var userUseCase: UserUseCase

    init(userUseCase: UserUseCase) {
        self.userUseCase = userUseCase
    }

    struct Input {
        let deleteUser: AnyPublisher<Void, Never>
    }

    struct Output {
        let deleteUserResult: AnyPublisher<Void?, Error>
    }

    func transform(input: Input) -> Output {

        let deleteUserResult = input.deleteUser
            .tryMap { [weak self] _ in
                try self?.deleteUser()
            }
            .eraseToAnyPublisher()

        let output = Output(deleteUserResult: deleteUserResult)
        return output
    }

    private func deleteUser() throws {
        try userUseCase.deleteUser()
    }
}
