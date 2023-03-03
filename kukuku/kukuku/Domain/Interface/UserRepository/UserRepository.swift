//
//  UserRepository.swift
//  kukuku
//
//  Created by youtak on 2023/03/03.
//

import Foundation

protocol UserRepository {
    func createUser(user: User) throws
    func readUser() throws -> User
    func updateUser(user: User) throws
    func deleteUser() throws
}
