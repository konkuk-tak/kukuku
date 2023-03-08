//
//  SettingCell.swift
//  kukuku
//
//  Created by youtak on 2023/03/02.
//

enum SettingCellKind: Int, CaseIterable {
    case language
    case darkMode
    case deleteData
    case developerMode
}

extension SettingCellKind {
    init?(index: Int) {
        self.init(rawValue: index)
    }

    var title: String {
        switch self {
        case .language: return "Language Setting"
        case .darkMode: return "Setting Dark Mode"
        case .deleteData: return "Delete Data"
        case .developerMode: return "Developer Mode"
        }
    }

    var index: Int {
        return self.rawValue
    }

    static var count: Int {
        return Self.allCases.count
    }
}
