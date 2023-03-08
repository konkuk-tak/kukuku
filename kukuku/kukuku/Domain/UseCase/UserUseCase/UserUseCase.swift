//
//  UserUseCase.swift
//  kukuku
//
//  Created by youtak on 2023/03/01.
//

import Foundation

protocol UserUseCase {
    func readUser() throws -> User
    func canPlay(_ user: User) -> Bool
    func finishDailyGame(user: User) throws -> User
    func deleteUser() throws
    func updateToDeveloperType(user: User, code: String) throws -> User?
}
