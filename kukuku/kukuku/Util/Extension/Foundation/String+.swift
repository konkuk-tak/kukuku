//
//  String+.swift
//  kukuku
//
//  Created by youtak on 2023/03/06.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    func localized(comment: String) -> String {
        return NSLocalizedString(self, comment: comment)
    }
}
