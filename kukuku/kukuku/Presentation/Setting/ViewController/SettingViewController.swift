//
//  SettingViewController.swift
//  kukuku
//
//  Created by youtak on 2023/03/01.
//

import UIKit

final class SettingViewController: UIViewController {

    // MARK: - Property

    private var settingView: SettingView {
        guard let view = view as? SettingView else {
            return SettingView()
        }
        return view
    }

    // MARK: - Life Cycle

    override func loadView() {
        view = SettingView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        print("설정")
    }
}
