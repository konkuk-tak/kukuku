//
//  SettingSection.swift
//  kukuku
//
//  Created by youtak on 2023/03/02.
//

enum SettingSection: Int, CaseIterable {
    case setting
    case appInfo
}

extension SettingSection {
    init?(index: Int) {
        self.init(rawValue: index)
    }

    var index: Int {
        self.rawValue
    }

    var title: String {
        switch self {
        case .setting: return "설정"
        case .appInfo: return "앱 정보"
        }
    }

    static var count: Int {
        return Self.allCases.count
    }
}
