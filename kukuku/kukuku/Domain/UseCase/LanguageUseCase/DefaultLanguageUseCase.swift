//
//  DefaultLanguageUseCase.swift
//  kukuku
//
//  Created by youtak on 2023/03/06.
//

import Foundation

struct DefaultLanguageUseCase: LanguageUseCase {

    private var languageRepository: LanguageRepository

    init(languageRepository: LanguageRepository) {
        self.languageRepository = languageRepository
    }

    func save(_ languageKind: LanguageKind) {
        languageRepository.save(languageKind)
    }

    func read() -> LanguageKind {
        if let languageKind = languageRepository.read() {
            return languageKind
        }
        let deviceLanguage = deviceLanguage()
        save(deviceLanguage)
        return deviceLanguage
    }

    private func deviceLanguage() -> LanguageKind {
        if let deviceLanguage = NSLocale.current.languageCode, deviceLanguage == "ko" {
            return .korean
        }
        return .englishUS
    }
}
