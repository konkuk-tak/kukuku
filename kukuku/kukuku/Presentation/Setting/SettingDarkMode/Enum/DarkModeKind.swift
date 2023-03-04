//
//  DarkModeKind.swift
//  kukuku
//
//  Created by youtak on 2023/03/03.
//

enum DarkModeKind: Int, CaseIterable {
    case light
    case dark
    case system
}

extension DarkModeKind {
    init?(index: Int) {
        self.init(rawValue: index)
    }

init?(theme: String?) {
        switch theme {
        case "light": self.init(rawValue: 0)
        case "dark": self.init(rawValue: 1)
        case "system": self.init(rawValue: 2)
        default: self.init(rawValue: 2)
        }
    }

    var index: Int {
        self.rawValue
    }

    var theme: String {
        switch self {
        case .light: return "light"
        case .dark: return "dark"
        case .system: return "system"
        }
    }

    var title: String {
        switch self {
        case .light: return "라이트 모드"
        case .dark: return "다크 모드"
        case .system: return "시스템 설정"
        }
    }

    static var count: Int {
        return Self.allCases.count
    }
}
