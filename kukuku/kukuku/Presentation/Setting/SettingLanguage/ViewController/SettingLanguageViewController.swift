//
//  SettingLanguageViewController.swift
//  kukuku
//
//  Created by youtak on 2023/03/02.
//

import UIKit

final class SettingLanguageViewController: UIViewController {

    // MARK: - Property

    private var settingLanguageView: SettingLanguageView {
        guard let view = view as? SettingLanguageView else {
            return SettingLanguageView()
        }
        return view
    }

    private enum Constant {
        static let cellHeight: CGFloat = 44
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        print("언어 설정")
    }

    override func loadView() {
        view = SettingLanguageView()
    }

    private func configureTableView() {
        settingLanguageView.tableViewDelegate(self)
        settingLanguageView.tableViewDataSource(self)
    }
}

extension SettingLanguageViewController: UITableViewDataSource, UITableViewDelegate {
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
        cell.update(title: "한국어".localized, isChecked: true)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.cellHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        settingLanguageView.deSelectTableViewCell()
        print(NSLocale.preferredLanguages)
    }
}
