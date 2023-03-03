//
//  SettingDarkMoveViewController.swift
//  kukuku
//
//  Created by youtak on 2023/03/02.
//

import UIKit

final class SettingDarkModeViewController: UIViewController {

    // MARK: - Property
    private var settingDarkModeView: SettingDarkModeView {
        guard let view = view as? SettingDarkModeView else {
            return SettingDarkModeView()
        }
        return view
    }

    private enum Constant {
        static let cellHeight: CGFloat = 44
    }

    // MARK: - Life Cycle

    override func loadView() {
        view = SettingDarkModeView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }

    // MARK: - Configure

    private func configureTableView() {
        settingDarkModeView.tableViewDelegate(self)
        settingDarkModeView.tableViewDataSource(self)
    }
}

extension SettingDarkModeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SettingCheckCell.identifier,
            for: indexPath
        ) as? SettingCheckCell else {
            return UITableViewCell()
        }

        guard let darkModeKind = DarkModeKind(index: indexPath.row) else {
            return UITableViewCell()
        }

        cell.update(title: darkModeKind.title, isChecked: true)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.cellHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        settingDarkModeView.deSelectTableViewCell()
    }
}
