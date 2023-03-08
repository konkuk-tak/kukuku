//
//  File.swift
//  kukukuUseCaseTests
//
//  Created by youtak on 2023/03/08.
//

import Foundation

@testable import kukuku

final class MockKonkukInfoRepository: KonkukInfoRepository {

    func konkukInfoList(languageKind: kukuku.LanguageKind) -> [kukuku.KonkukInfo]? {
        return nil
    }
}
