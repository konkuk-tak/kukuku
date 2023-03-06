//
//  LanguageRepository.swift
//  kukuku
//
//  Created by youtak on 2023/03/06.
//

import Foundation

struct DefaultLanguageRepository: LanguageRepository {

    private var userDefaultManager: UserDefaultManagerProtocol
    private let languageKey = "LanguageKey"

    init(userDefaultManager: UserDefaultManagerProtocol) {
        self.userDefaultManager = userDefaultManager
    }

    func save(_ languageKind: LanguageKind) {
        userDefaultManager.saveValue(languageKind.value, forKey: languageKey)
    }

    func read() -> LanguageKind? {
        let value = userDefaultManager.getValue(forKey: languageKey) as? String
        let languageKind = LanguageKind(value: value)
        return languageKind
    }
}
