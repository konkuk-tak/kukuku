//
//  DefaultDarkModeUseCase.swift
//  kukuku
//
//  Created by youtak on 2023/03/04.
//

import Foundation

struct DefaultDarkModeUseCase: DarkModeUseCase {

    private var darkModeRepository: DarkModeRepository

    init(darkModeRepository: DarkModeRepository) {
        self.darkModeRepository = darkModeRepository
    }

    func save(_ darkModeKind: DarkModeKind) {
        darkModeRepository.save(darkModeKind)
    }

    func read() -> DarkModeKind {
        if let darkMode = darkModeRepository.read() {
            return darkMode
        }
        save(.system)
        return .system
    }
}
