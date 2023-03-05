//
//  DeveloperCodeRepository.swift
//  kukuku
//
//  Created by youtak on 2023/03/05.
//

import Foundation

struct DefaultDeveloperCodeRepository: DeveloperCodeRepository {

    private let fileName: String = "DeveloperCode"
    private let key: String = "code"

    func code() -> String? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "plist") else {
            return nil
        }

        guard let dictionary = NSDictionary(contentsOf: url) else {
            return nil
        }

        let code = dictionary[key] as? String

        return code
    }
}
