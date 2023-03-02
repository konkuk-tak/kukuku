//
//  AppInfoCell.swift
//  kukuku
//
//  Created by youtak on 2023/03/02.
//

enum AppInfoCellKind: Int, CaseIterable {
    case appVersion
}

extension AppInfoCellKind {
    init?(index: Int) {
        self.init(rawValue: index)
    }

    var title: String {
        switch self {
        case .appVersion: return "앱 버전"
        }
    }

    var index: Int {
        return self.rawValue
    }

    static var count: Int {
        return Self.allCases.count
    }
}
