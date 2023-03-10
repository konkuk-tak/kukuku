//
//  AccessibilityIdentifier.swift
//  kukuku
//
//  Created by youtak on 2023/03/10.
//

import Foundation

enum KUAccessibilityIdentifier {
    struct Home {
        static let konkukInfoListButton = "HomeKonkukInfoListButton"
        static let guideButton = "HomeGuideButton"
        static let settingButton = "HomeSettingButton"
        static let arButton = "HomeARButton"
    }

    struct KonukInfoList {
        static let tableView = "KonkukInfoListTableView"
        func cell(index: Int) -> String { return "infoCell_\(index)"}
    }

    struct KonkukInfoDetail {
        static let completeButton = "CompleteButton"
    }

    struct Guide {
        static let nextButton = "GuideNextButton"
    }

    struct Setting {
        static let tableView = "SettingTableView"
        func cell(index: Int) -> String { return "settingCell_\(index)"}
    }

    struct ARGame {
        static let exitButton = "ARGameExitButton"
    }

    struct Alert {
        static let confirmAction = "AlertConfirmAction"
        static let cancelAction = "AlertCancelAction"
        static let okayAction = "AlertOkayAction"
    }
}
