//
//  print.swift
//  kukuku
//
//  Created by youtak on 2023/03/03.
//

import Foundation

public func print(_ object: Any) {
    #if DEBUG
    Swift.print(object)
    #endif
}
