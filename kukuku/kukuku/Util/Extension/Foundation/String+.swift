//
//  String+.swift
//  kukuku
//
//  Created by youtak on 2023/03/06.
//

import Foundation

extension String {
    var localized: String {
        return AppManager.bundle.localizedString(forKey: self, value: nil, table: nil)
    }

    func localized(argument: CVarArg) -> String {
        return String(format: self.localized, argument)
    }
}
