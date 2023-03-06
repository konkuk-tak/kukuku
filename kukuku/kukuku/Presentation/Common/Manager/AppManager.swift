//
//  AppManager.swift
//  kukuku
//
//  Created by youtak on 2023/03/06.
//

import UIKit

struct AppManager {

    static func restartApp() {
        let homeViewModel = DependencyFactory.homeViewModel()
        let homeViewController = HomeViewController(homeViewModel: homeViewModel)
        let navigationViewController = UINavigationController(rootViewController: homeViewController)

        let window = UIApplication.shared.keyWindow
        guard let rootViewController = window.rootViewController else { return }

        navigationViewController.view.frame = rootViewController.view.frame
        navigationViewController.view.layoutIfNeeded()

        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve) {
            window.rootViewController = navigationViewController
        }
    }
}
