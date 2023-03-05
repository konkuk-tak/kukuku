//
//  UserUseCase.swift
//  kukuku
//
//  Created by youtak on 2023/03/01.
//

import Foundation

protocol UserUseCase {
    func readUser() throws -> User
    func finishDailyGame(user: User) throws -> User
    func deleteUser() throws
}
