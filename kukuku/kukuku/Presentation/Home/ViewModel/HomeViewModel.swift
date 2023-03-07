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

    private (set)var user: User!

    private var darkModeUse: DarkModeUseCase
    private var userUseCase: UserUseCase
    private var konkukInfoUseCase: KonkukInfoUseCase

    init(darkModeUse: DarkModeUseCase, userUseCase: UserUseCase, konkukInfoUseCase: KonkukInfoUseCase) {
        self.darkModeUse = darkModeUse
        self.userUseCase = userUseCase
        self.konkukInfoUseCase = konkukInfoUseCase
    }

    // MARK: - Input & Output

    struct Input {
        let viewDidLoad: AnyPublisher<Void, Never>
        let userUpdate: AnyPublisher<Void, Never>
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
            .merge(with: input.userUpdate)
            .tryMap { [weak self] _ in
                return try self?.userCountScore()
            }
            .eraseToAnyPublisher()

        let userUpdateScoreInfo = input.userScoreUpdate
            .tryMap { [weak self] _ in
                return try self?.updateUserScore()
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

    private func userCountScore() throws -> Int {
        let user = try userUseCase.readUser()
        self.user = user
        return user.score
    }

    private func updateUserScore() throws -> Int {
        let updatedUser = try userUseCase.finishDailyGame(user: user)
        self.user = updatedUser
        return updatedUser.score
    }

    private func checkCanPlay() -> Bool {
        return userUseCase.canPlay(user)
    }
}

extension HomeViewModel {
    func isDeveloperMode() -> Bool {
        return user.type == .developer
    }

    func nextKonkukInfo() -> KonkukInfo? {
        let index = user.listCount - 1
        let konkukInfo = konkukInfoUseCase.info(language: AppManager.currentLanguage, index: index)
        return konkukInfo
    }
}
