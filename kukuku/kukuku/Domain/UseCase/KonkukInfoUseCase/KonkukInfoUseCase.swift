//
//  KonkukInfoUseCase.swift
//  kukuku
//
//  Created by youtak on 2023/03/04.
//

import Foundation

protocol KonkukInfoUseCase {
    func infoList(count: Int) -> [KonkukInfo]
}
