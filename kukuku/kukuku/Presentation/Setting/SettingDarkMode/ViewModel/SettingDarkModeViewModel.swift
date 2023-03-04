//
//  SettingDarkModeViewModel.swift
//  kukuku
//
//  Created by youtak on 2023/03/04.
//

import Combine
import Foundation

final class SettingDarkModeViewModel {

    private var darkModeUseCase: DarkModeUseCase
    private (set)var currentMode: DarkModeKind

    init(darkModeUseCase: DarkModeUseCase) {
        self.darkModeUseCase = darkModeUseCase
        self.currentMode = darkModeUseCase.read()
    }

    // MARK: - Input & Output

    struct Input {
        let darkMode: AnyPublisher<DarkModeKind, Never>
    }

    struct Output {
        let updateDarkMode: AnyPublisher<DarkModeKind?, Never>
    }

    func transform(input: Input) -> Output {
        let updateDarkMode = input.darkMode
            .map { [weak self] darkModeKind in
                self?.handleDarkModeKind(darkModeKind: darkModeKind)
            }
            .eraseToAnyPublisher()

        return Output(updateDarkMode: updateDarkMode)
    }

    // MARK: - Method

    private func handleDarkModeKind(darkModeKind: DarkModeKind) -> DarkModeKind {
        darkModeUseCase.save(darkModeKind)
        currentMode = darkModeKind
        return currentMode
    }
}
