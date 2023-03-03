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

    private enum Constant {
        static let cellHeight: CGFloat = 44
    }

    // MARK: - Life Cycle

    override func loadView() {
        view = SettingView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        print("설정")
        configureTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - Configure

    private func configureTableView() {
        settingView.tableViewDataSource(self)
        settingView.tableViewDelegate(self)
    }

    private func moveToSettingLanguage() {
        let settingLanguageViewController = SettingLanguageViewController()
        navigationController?.pushViewController(settingLanguageViewController, animated: true)
    }

    private func moveToSettingDarkMode() {
        let settingDarkModeViewController = SettingDarkMoveViewController()
        navigationController?.pushViewController(settingDarkModeViewController, animated: true)
    }

    private func deleteData() {
    }

    private func showDeveloperCodeAlert() {
    }
}

extension SettingViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingSection.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = SettingSection(index: section) else {
            return 0
        }
        switch section {
        case .setting: return SettingCellKind.count
        case .appInfo: return AppInfoCellKind.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SettingCell.identifier,
            for: indexPath
        ) as? SettingCell else {
             return UITableViewCell()
        }

        guard let section = SettingSection(index: indexPath.section) else {
            return UITableViewCell()
        }

        switch section {
        case .setting:
            guard let cellKind = SettingCellKind(index: indexPath.row) else {
                return UITableViewCell()
            }
            if cellKind == .language {
                cell.update(title: cellKind.title, value: "한국어")
            } else {
                cell.update(title: cellKind.title)
            }
        case .appInfo:
            guard let cellKind = AppInfoCellKind(index: indexPath.row) else {
                return UITableViewCell()
            }
            if cellKind == .appVersion {
                cell.update(title: cellKind.title, value: "1.0.0")
            } else {
                cell.update(title: cellKind.title)
            }
            cell.selectionStyle = .none
        }

        return cell
    }

    // Header

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let title = SettingSection(index: section)?.title else {
            return nil
        }
        let view = SettingSectionHeader()
        view.updateTitle(text: title)
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constant.cellHeight
    }

    // Cell

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.cellHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = SettingSection(index: indexPath.section), section != .appInfo else {
            return
        }
        guard let cellKind = SettingCellKind(index: indexPath.row) else {
            return
        }

        switch cellKind {
        case .language:
            moveToSettingLanguage()
        case .darkMode:
            moveToSettingDarkMode()
        case .deleteData:
            deleteData()
        case .developerMode:
            showDeveloperCodeAlert()
        }
        settingView.deSelectTableViewCell()
    }
}
