//
//  LanguageRepository.swift
//  kukuku
//
//  Created by youtak on 2023/03/06.
//

import Foundation

protocol LanguageRepository {
    func save(_ languageKind: LanguageKind)
    func read() -> LanguageKind?
}
