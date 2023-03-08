//
//  MockDarkModeRepository.swift
//  kukukuUseCaseTests
//
//  Created by youtak on 2023/03/08.
//

import Foundation

@testable import kukuku

final class MockDarkModeRepository: DarkModeRepository {

    var currentDarkMode: DarkModeKind!

    func save(_ darkModeKind: kukuku.DarkModeKind) {
        self.currentDarkMode = darkModeKind
    }

    func read() -> kukuku.DarkModeKind? {
        return currentDarkMode
    }
}
