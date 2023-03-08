//
//  File.swift
//  kukukuUseCaseTests
//
//  Created by youtak on 2023/03/08.
//

import Foundation

@testable import kukuku

final class MockLanguageRepository: LanguageRepository {

    var storedLanguageKind: LanguageKind!

    func save(_ languageKind: kukuku.LanguageKind) {
        self.storedLanguageKind = languageKind
    }

    func read() -> kukuku.LanguageKind? {
        return storedLanguageKind
    }
}
