//
//  AppManager.swift
//  kukuku
//
//  Created by youtak on 2023/03/06.
//

import UIKit

struct AppManager {

    static var bundle: Bundle!
    static var currentLanguage: LanguageKind!

    static func restartApp() {
        languageSetting()

        let homeViewModel = DependencyFactory.homeViewModel()
        let homeViewController = HomeViewController(homeViewModel: homeViewModel)
        let navigationViewController = UINavigationController(rootViewController: homeViewController)

        let window = UIApplication.shared.keyWindow
        guard let rootViewController = window.rootViewController else { return }

        navigationViewController.view.frame = rootViewController.view.frame
        navigationViewController.view.layoutIfNeeded()

        UIView.transition(with: window, duration: 0.2) {
            window.rootViewController = navigationViewController
        }
    }

    static func languageSetting() {
        let languageUseCase = DependencyFactory.languageUseCase()
        let languageKind = languageUseCase.read()
        currentLanguage = languageKind
        let path = Bundle.main.path(forResource: languageKind.code, ofType: "lproj") ?? ""
        bundle = Bundle(path: path)
    }
}
