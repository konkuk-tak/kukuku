//
//  SettingLanguageViewModel.swift
//  kukuku
//
//  Created by youtak on 2023/03/06.
//

import Combine
import Foundation

final class SettingLanguageViewModel {

    private let languageUseCase: LanguageUseCase
    private(set) var currentLanguage: LanguageKind

    init(languageUseCase: LanguageUseCase, currentLanguage: LanguageKind) {
        self.languageUseCase = languageUseCase
        self.currentLanguage = currentLanguage
    }

    struct Input {
        let language: AnyPublisher<LanguageKind, Never>
    }

    struct Output {
        let updateLanguage: AnyPublisher<LanguageKind?, Never>
    }

    func transform(input: Input) -> Output {

        let updateLanguage = input.language
            .map { [weak self] languageKind in
                self?.handleLanguage(languageKind)
            }
            .eraseToAnyPublisher()

        return Output(updateLanguage: updateLanguage)
    }

    private func handleLanguage(_ languageKind: LanguageKind) -> LanguageKind {
        languageUseCase.save(languageKind)
        currentLanguage = languageKind
        return currentLanguage
    }
}
