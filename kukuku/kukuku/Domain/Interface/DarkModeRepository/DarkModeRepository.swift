//
//  DarkModeRepository.swift
//  kukuku
//
//  Created by youtak on 2023/03/04.
//

import Foundation

protocol DarkModeRepository {
    func save(_ darkModeKind: DarkModeKind)
    func read() -> DarkModeKind?
}
