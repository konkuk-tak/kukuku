//
//  DarkModeManager.swift
//  kukuku
//
//  Created by youtak on 2023/03/04.
//

import UIKit

struct DarkModeManager {
    static var systemMode: UIUserInterfaceStyle {
        return UITraitCollection.current.userInterfaceStyle
    }

    static func mode(darkModeKind: DarkModeKind) {
        switch darkModeKind {
        case .light:
            setWindow(.light)
        case .dark:
            setWindow(.dark)
        case .system:
            setWindow(systemMode)
        }
    }

    static private func setWindow(_ userInterfaceStyle: UIUserInterfaceStyle) {
        if let window = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let windows = window.windows.first
            windows?.overrideUserInterfaceStyle = userInterfaceStyle
        }
    }
}
