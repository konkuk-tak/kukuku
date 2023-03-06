//
//  PermissionManager.swift
//  kukuku
//
//  Created by youtak on 2023/03/05.
//

import UIKit

struct PermissionManager {

    static func moveToiPhoneSetting() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }

        if UIApplication.shared.canOpenURL(url) {
            DispatchQueue.main.async {
                UIApplication.shared.open(url)
            }
        }
    }
}
