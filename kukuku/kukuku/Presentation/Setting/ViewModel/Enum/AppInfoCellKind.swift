//
//  AppInfoCell.swift
//  kukuku
//
//  Created by youtak on 2023/03/02.
//

enum AppInfoCellKind: CaseIterable {
    case openSource
    case appVersion
    
    var title: String {
        switch self {
        case .openSource: return "오픈소스 라이선스"
        case .appVersion: return "앱 버전"
        }
    }
    
    var index: Int {
        switch self {
        case .openSource: return 0
        case .appVersion: return 1
        }
    }
}
