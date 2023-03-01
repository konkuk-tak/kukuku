//
//  ViewController.swift
//  kukuku
//
//  Created by youtak on 2023/03/01.
//

import Combine
import UIKit

import FlexLayout
import PinLayout

class HomeViewController: UIViewController {

    private var homeView: HomeView {
        guard let view = view as? HomeView else {
            return HomeView()
        }
        return view
    }

    private var cancellable = Set<AnyCancellable>()

    override func loadView() {
        view = HomeView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        subscribeButtonPublisher()
    }

    private func configureNavigationBar() {
        let label = UILabel()
        label.textColor = .dynamicBlack
        label.text = "쿠쿠쿠"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: label)
    }

    // MARK: - Navigation

    private func subscribeButtonPublisher() {
        homeView.konkukInfoListButtonPublisher()
            .sink { [weak self] _ in
                let konkukInfoListViewController = KonkukInfoListViewController()
                self?.navigationController?.pushViewController(konkukInfoListViewController, animated: true)
            }
            .store(in: &cancellable)

        homeView.guideButtonPublisher()
            .sink { [weak self] _ in
                let guideViewController = GuideViewController()
                self?.navigationController?.pushViewController(guideViewController, animated: true)
            }
            .store(in: &cancellable)

        homeView.settingButtonPublisher()
            .sink { [weak self] _ in
                let settingViewController = SettingViewController()
                self?.navigationController?.pushViewController(settingViewController, animated: true)
            }
            .store(in: &cancellable)

        homeView.arButtonPublisher()
            .sink { [weak self] _ in
                let arGameViewController = ARGameViewController()
                arGameViewController.modalPresentationStyle = .fullScreen
                self?.present(arGameViewController, animated: true)
            }
            .store(in: &cancellable)
    }
}
