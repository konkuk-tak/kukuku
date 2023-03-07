//
//  CGRect+.swift
//  kukuku
//
//  Created by youtak on 2023/03/07.
//

import UIKit

extension CGRect {
    static var appCenterFrame: CGRect {
        let keyWindowFrame = UIApplication.shared.keyWindow.frame
        return CGRect(x: keyWindowFrame.midX, y: keyWindowFrame.midY, width: 0, height: 0)
    }
}
