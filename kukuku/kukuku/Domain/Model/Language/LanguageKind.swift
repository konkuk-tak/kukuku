//
//  LanguageKind.swift
//  kukuku
//
//  Created by youtak on 2023/03/06.
//

import Foundation

enum LanguageKind: Int, CaseIterable {
    case korean
    case englishUS
}

extension LanguageKind {
    init?(index: Int) {
        self.init(rawValue: index)
    }

    init?(value: String?) {
        switch value {
        case "korean": self.init(rawValue: 0)
        case "englishUS": self.init(rawValue: 1)
        default: self.init(rawValue: 0)
        }
    }

    var value: String {
        switch self {
        case .korean: return "korean"
        case .englishUS: return "englishUS"
        }
    }

    var title: String {
        switch self {
        case .korean: return "Korean"
        case .englishUS: return "English (US)"
        }
    }
}
