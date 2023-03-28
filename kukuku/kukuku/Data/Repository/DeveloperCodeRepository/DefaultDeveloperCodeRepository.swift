//
//  DeveloperCodeRepository.swift
//  kukuku
//
//  Created by youtak on 2023/03/05.
//

import Foundation

struct DefaultDeveloperCodeRepository: DeveloperCodeRepository {

    private let key: String = "key"

    func code() -> String? {
        guard let url = plistURL() else {
            return nil
        }

        guard let dictionary = NSDictionary(contentsOf: url) else {
            return nil
        }

        return dictionary["key"] as? String
    }

    private func plistURL() -> URL? {
        return Bundle.main.url(forResource: "Developer-Code", withExtension: "plist")
    }
}
