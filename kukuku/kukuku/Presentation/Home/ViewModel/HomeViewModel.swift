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

    private var user: User!

    private var darkModeUse: DarkModeUseCase
    private var userUseCase: UserUseCase

    init(darkModeUse: DarkModeUseCase, userUseCase: UserUseCase) {
        self.darkModeUse = darkModeUse
        self.userUseCase = userUseCase
    }

    // MARK: - Input & Output

    struct Input {
        let viewDidLoad: AnyPublisher<Void, Never>
        let userScore: AnyPublisher<Void, Never>
        let userScoreUpdate: AnyPublisher<Void, Never>
        let checkCanPlay: AnyPublisher<Void, Never>
    }

    struct Output {
        let darkMode: AnyPublisher<DarkModeKind?, Never>
        let userScoreInfo: AnyPublisher<Int?, Error>
        let userUpdateScoreInfo: AnyPublisher<Int?, Error>
        let canPlay: AnyPublisher<Bool?, Never>
    }

    func transform(input: Input) -> Output {
        let darkMode = input.viewDidLoad
            .map { [weak self] _ in
                self?.darkModeUse.read()
            }
            .eraseToAnyPublisher()

        let userScoreInfo = input.viewDidLoad
            .merge(with: input.userScore)
            .tryMap { [weak self] _ in
                return try self?.userCount()
            }
            .eraseToAnyPublisher()

        let userUpdateScoreInfo = input.userScoreUpdate
            .tryMap { [weak self] _ in
                return try self?.updateUser()
            }
            .eraseToAnyPublisher()

        let canPlay = input.checkCanPlay
            .map { [weak self] _ in
                self?.checkCanPlay()
            }
            .eraseToAnyPublisher()

        let output = Output(
            darkMode: darkMode,
            userScoreInfo: userScoreInfo,
            userUpdateScoreInfo: userUpdateScoreInfo,
            canPlay: canPlay
        )

        return output
    }

    // MARK: - Method

    private func userCount() throws -> Int {
        let user = try userUseCase.readUser()
        self.user = user
        return user.score
    }

    private func updateUser() throws -> Int {
        let updatedUser = try userUseCase.finishDailyGame(user: user)
        self.user = updatedUser
        return updatedUser.score
    }

    private func checkCanPlay() -> Bool {
        return userUseCase.canPlay(user)
    }
}
