//
//  KonkukInfoUseCase.swift
//  kukuku
//
//  Created by youtak on 2023/03/04.
//

import Foundation

protocol KonkukInfoUseCase {
    func infoList(language: LanguageKind, count: Int) -> UserKonkukInfoList
    func info(language: LanguageKind, index: Int) -> KonkukInfo?
}
