//
//  SettingSection.swift
//  kukuku
//
//  Created by youtak on 2023/03/02.
//

enum SettingSection: CaseIterable {
    case setting
    case appInfo

    var index: Int {
        switch self {
        case .setting: return 0
        case .appInfo: return 1
        }
    }
}
