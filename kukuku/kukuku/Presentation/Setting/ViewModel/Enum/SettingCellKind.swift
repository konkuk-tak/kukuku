//
//  SettingCell.swift
//  kukuku
//
//  Created by youtak on 2023/03/02.
//

enum SettingCellKind: CaseIterable {
    case language
    case darkMode
    case deleteData
    case developerMode


    var title: String {
        switch self {
        case .language: return "언어 / language"
        case .darkMode: return "다크모드"
        case .deleteData: return "데이터 삭제"
        case .developerMode: return "개발자 모드"
        }
    }
    
    var index: Int {
        switch self {
        case .language: return 0
        case .darkMode: return 1
        case .deleteData: return 2
        case .developerMode: return 3
        }
    }
}
