//
//  KeyChainManager.swift
//  kukuku
//
//  Created by youtak on 2023/03/03.
//

import Foundation

final class KeyChainManger {

    static let main = KeyChainManger()
    private init() {}

    private let account = "userAccount"

    private func createQuery(data: Data) -> CFDictionary {
        return [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecValueData: data
        ] as CFDictionary
    }

    private func readQuery() -> CFDictionary {
        return [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecMatchLimit: kSecMatchLimitOne,
            kSecReturnAttributes: true,
            kSecReturnData: true
        ] as CFDictionary
    }

    private func updateQuery() -> CFDictionary {
        return [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account
        ] as CFDictionary
    }

    private func updateAttributes(data: Data) -> CFDictionary {
        return [
            kSecAttrAccount: account,
            kSecValueData: data
        ] as CFDictionary
    }

    private func deleteQuery() -> CFDictionary {
        return updateQuery()
    }
}

extension KeyChainManger {
    func createUser(user: User) throws {
        guard let data = try? JSONEncoder().encode(user) else {
            throw KeychainError.jsonCoding
        }

        let query = createQuery(data: data)
        let status = SecItemAdd(query, nil)
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
    }

    func readUser() throws -> User {
        let query = readQuery()
        var typeRef: CFTypeRef?

        if SecItemCopyMatching(query, &typeRef) != errSecSuccess {
            throw KeychainError.noData
        }

        guard let typeRef = typeRef as? [CFString: Any],
              let data = typeRef[kSecValueData] as? Data,
              let user = try? JSONDecoder().decode(User.self, from: data)
        else {
            throw KeychainError.noData
        }

        return user
    }

    func updateUser(user: User) throws {
        guard let data = try? JSONEncoder().encode(user) else {
            throw KeychainError.jsonCoding
        }

        let query = updateQuery()
        let attributes = updateAttributes(data: data)
        let status = SecItemUpdate(query, attributes)
        guard status != errSecItemNotFound else { throw KeychainError.noData }
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
    }

    func deleteUser() throws {
        let query = deleteQuery()
        let status = SecItemDelete(query)
        guard status == errSecSuccess || status == errSecItemNotFound else { throw KeychainError.unhandledError(status: status) }
    }
}

enum KeychainError: Error {
    case jsonCoding
    case noData
    case unhandledError(status: OSStatus)
}
