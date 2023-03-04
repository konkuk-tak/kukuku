//
//  HomeViewModel.swift
//  kukuku
//
//  Created by youtak on 2023/03/01.
//

import Combine
import Foundation

final class HomeViewModel {

    private var darkModeUse: DarkModeUseCase

    init(darkModeUse: DarkModeUseCase) {
        self.darkModeUse = darkModeUse
    }

    // MARK: - Input & Output

    struct Input {
        let viewDidLoad: AnyPublisher<Void, Never>
    }

    struct Output {
        let darkMode: AnyPublisher<DarkModeKind?, Never>
//        let userInfo: AnyPublisher<User, Never>
    }

    func transform(input: Input) -> Output {
        let darkMode = input.viewDidLoad
            .map { [weak self] _ in
                self?.darkModeUse.read()
            }
            .eraseToAnyPublisher()

        return Output(darkMode: darkMode)
    }
}
