//
//  HomeViewModel.swift
//  kukuku
//
//  Created by youtak on 2023/03/01.
//

import Combine
import Foundation

final class HomeViewModel {

    // MARK: - Property

    private var user: User?

    private var darkModeUse: DarkModeUseCase
    private var userUseCase: UserUseCase
    private var locationUseCase: LocationUseCase

    init(darkModeUse: DarkModeUseCase, userUseCase: UserUseCase, locationUseCase: LocationUseCase) {
        self.darkModeUse = darkModeUse
        self.userUseCase = userUseCase
        self.locationUseCase = locationUseCase
    }

    // MARK: - Input & Output

    struct Input {
        let viewDidLoad: AnyPublisher<Void, Never>
        let userScoreUpdate: AnyPublisher<Void, Never>
    }

    struct Output {
        let darkMode: AnyPublisher<DarkModeKind?, Never>
        let userScoreInfo: AnyPublisher<Int, Error>
        let userUpdateScoreInfo: AnyPublisher<Int, Error>
    }

    func transform(input: Input) -> Output {
        let darkMode = input.viewDidLoad
            .map { [weak self] _ in
                self?.darkModeUse.read()
            }
            .eraseToAnyPublisher()

        let userScoreInfo = input.viewDidLoad
            .tryMap { [weak self] _ in
                guard let self = self else { throw KUError.unWrap }
                return try self.userCount()
            }
            .eraseToAnyPublisher()

        let userUpdateScoreInfo = input.userScoreUpdate
            .tryMap { [weak self] _ in
                guard let self = self else { throw KUError.unWrap }
                return try self.updateUser()
            }
            .eraseToAnyPublisher()

        let output = Output(darkMode: darkMode, userScoreInfo: userScoreInfo, userUpdateScoreInfo: userUpdateScoreInfo)

        return output
    }

    private func userCount() throws -> Int {
        let user = try userUseCase.readUser()
        self.user = user
        return user.score
    }

    private func updateUser() throws -> Int {
        guard let user = self.user else { throw KUError.unWrap }
        let updatedUser = try userUseCase.finishDailyGame(user: user)
        self.user = updatedUser
        return updatedUser.score
    }
}
