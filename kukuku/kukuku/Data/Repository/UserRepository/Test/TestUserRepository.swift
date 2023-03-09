//
//  TestUserRepository.swift
//  kukuku
//
//  Created by youtak on 2023/03/09.
//

import Foundation

final class TestUserRepository: UserRepository {
    
    func createUser(user: User) throws {}
    
    func readUser() throws -> User {
        return User(type: .normal, listCount: 30, log: [])
    }
    
    func updateUser(user: User) throws {}
    
    func deleteUser() throws {}
}
