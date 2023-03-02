//
//  ReusableView.swift
//  kukuku
//
//  Created by youtak on 2023/03/02.
//

import Foundation

protocol ReusableView {
    static var identifier: String { get }
}

extension ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
