//
//  UIApplication.swift
//  kukuku
//
//  Created by youtak on 2023/03/04.
//

import UIKit

extension UIApplication {
    var keyWindow: UIWindow {
        let scene = UIApplication.shared.connectedScenes.first
        let windowScene = scene as? UIWindowScene
        let window = windowScene?.windows.first
        // swiftlint:disable force_unwrapping
        return window!
    }
}
