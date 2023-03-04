//
//  UserDefaultManager.swift
//  kukuku
//
//  Created by youtak on 2023/03/04.
//

import Foundation

protocol UserDefaultManagerProtocol {
    func saveValue(_ value: Any?, forKey key: String)
    func getValue(forKey key: String) -> Any?
}

struct UserDefaultManager: UserDefaultManagerProtocol {
    private let defaults = UserDefaults.standard

    func saveValue(_ value: Any?, forKey key: String) {
        defaults.set(value, forKey: key)
    }

    func getValue(forKey key: String) -> Any? {
        return defaults.value(forKey: key)
    }
}
