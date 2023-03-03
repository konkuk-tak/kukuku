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

    var index: Int {
        self.rawValue
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
