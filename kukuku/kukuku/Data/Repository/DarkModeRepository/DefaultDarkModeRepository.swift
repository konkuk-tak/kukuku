//
//  DefaultDarkModeRepository.swift
//  kukuku
//
//  Created by youtak on 2023/03/04.
//

import Foundation

struct DefaultDarkModeRepository: DarkModeRepository {

    private var userDefaultManger: UserDefaultManagerProtocol
    private let darkModeKey = "DarkModeKey"

    init(userDefaultManger: UserDefaultManagerProtocol) {
        self.userDefaultManger = userDefaultManger
    }

    func save(_ darkModeKind: DarkModeKind) {
        userDefaultManger.saveValue(darkModeKind.theme, forKey: darkModeKey)
    }

    func read() -> DarkModeKind? {
        let theme = userDefaultManger.getValue(forKey: darkModeKey) as? String
        let darkModeKind = DarkModeKind(theme: theme)
        return darkModeKind
    }
}
