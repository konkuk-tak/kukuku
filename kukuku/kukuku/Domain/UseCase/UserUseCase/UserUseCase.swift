//
//  UserUseCase.swift
//  kukuku
//
//  Created by youtak on 2023/03/01.
//

import Foundation

protocol UserUseCase {
    func readUser() throws -> User
    func updateUser(user: User) throws
    func deleteUser() throws
}
