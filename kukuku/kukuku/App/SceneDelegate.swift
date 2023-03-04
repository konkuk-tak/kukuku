//
//  SceneDelegate.swift
//  kukuku
//
//  Created by youtak on 2023/03/01.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = configureNavigationController()
        window?.makeKeyAndVisible()
    }

    func configureNavigationController() -> UINavigationController {
        let userDefaultManager = UserDefaultManager()
        let darkModeRepository = DefaultDarkModeRepository(userDefaultManger: userDefaultManager)
        let darkModeUseCase = DefaultDarkModeUseCase(darkModeRepository: darkModeRepository)
        let homeViewModel = HomeViewModel(darkModeUse: darkModeUseCase)
        let homeViewController = HomeViewController(homeViewModel: homeViewModel)
        return UINavigationController(rootViewController: homeViewController)
    }
}
