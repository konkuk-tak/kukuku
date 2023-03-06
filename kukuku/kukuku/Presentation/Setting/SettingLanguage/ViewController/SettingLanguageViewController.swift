//
//  SettingLanguageViewController.swift
//  kukuku
//
//  Created by youtak on 2023/03/02.
//

import Combine
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

    private let settingLanguageViewModel: SettingLanguageViewModel

    private var languageSubject = PassthroughSubject<LanguageKind, Never>()
    private var cancellable = Set<AnyCancellable>()

    // MARK: - Life Cycle

    init(settingLanguageViewModel: SettingLanguageViewModel) {
        self.settingLanguageViewModel = settingLanguageViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableView()
        bind()
    }

    override func loadView() {
        view = SettingLanguageView()
    }

    // MARK: - Configure

    private func configureNavigationBar() {
        navigationItem.title = "Languages".localized
    }

    private func configureTableView() {
        settingLanguageView.tableViewDelegate(self)
        settingLanguageView.tableViewDataSource(self)
    }

    // MARK: Input & Output

    private func bind() {
        let inputLanguage = languageSubject.eraseToAnyPublisher()

        let input = SettingLanguageViewModel.Input(language: inputLanguage)
        let output = settingLanguageViewModel.transform(input: input)

        output.updateLanguage
            .sink { [weak self] languageKind in
                self?.handleLanguage(languageKind)
            }
            .store(in: &cancellable)
    }

    private func handleLanguage(_ languageKind: LanguageKind?) {
        guard languageKind != nil else {
            return
        }

        AppManager.restartApp()
    }
}

extension SettingLanguageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LanguageKind.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SettingCheckCell.identifier,
            for: indexPath
        ) as? SettingCheckCell else {
            return UITableViewCell()
        }

        guard let languageKind = LanguageKind(index: indexPath.row) else {
            return UITableViewCell()
        }

        if languageKind == settingLanguageViewModel.currentLanguage {
            cell.update(title: languageKind.title, isChecked: true)
        } else {
            cell.update(title: languageKind.title)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.cellHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        settingLanguageView.deSelectTableViewCell()

        guard let languageKind = LanguageKind(index: indexPath.row) else {
            return
        }

        languageSubject.send(languageKind)
    }
}
