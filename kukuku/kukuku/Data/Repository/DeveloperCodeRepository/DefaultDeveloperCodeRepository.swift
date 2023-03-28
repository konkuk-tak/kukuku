//
//  DeveloperCodeRepository.swift
//  kukuku
//
//  Created by youtak on 2023/03/05.
//

import Foundation

struct DefaultDeveloperCodeRepository: DeveloperCodeRepository {

    private let key: String = "Developer Code"

    func code() -> String? {
        return Bundle.main.object(forInfoDictionaryKey: key) as? String
    }
}
