//
//  SettingViewController.swift
//  kukuku
//
//  Created by youtak on 2023/03/01.
//

import Combine
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

    private var settingViewModel: SettingViewModel

    private var developerCodeSubject = PassthroughSubject<String, Never>()
    private var userDeleteSubject = PassthroughSubject<Void, Never>()
    private var userUpdate = PassthroughSubject<Void, Never>()
    private var cancellable = Set<AnyCancellable>()

    // MARK: - Life Cycle

    init(settingViewModel: SettingViewModel) {
        self.settingViewModel = settingViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = SettingView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        configureTableView()
        bind()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - Configure

    private func configureTableView() {
        settingView.tableViewDataSource(self)
        settingView.tableViewDelegate(self)
    }

    // MARK: - Input & Output

    private func bind() {
        let deleteUser = userDeleteSubject.eraseToAnyPublisher()
        let developerCode = developerCodeSubject.eraseToAnyPublisher()

        let input = SettingViewModel.Input(deleteUser: deleteUser, developerCode: developerCode)
        let output = settingViewModel.transform(input: input)

        output.deleteUserResult
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished: return
                case .failure(let error): self?.handleUserDeleteError(error)
                }
            }, receiveValue: { [weak self] _ in
                self?.handleUserDeleteResult()
            })
            .store(in: &cancellable)

        output.developerModeUpdate
            .sink { [weak self] completion in
                switch completion {
                case .finished: return
                case .failure(let error): self?.handleDeveloperModeError(error)
                }
            } receiveValue: { [weak self] isUpdated in
                self?.handleDeveloperModeResult(isUpdated: isUpdated)
            }
            .store(in: &cancellable)
    }

    // MARK: 데이터 삭제

    private func handleUserDeleteResult() {
        showOkayAlert(title: "Alert Title Data Delete Complete", message: "Alert Description Data Delete Complete")
        userUpdate.send(Void())
    }

    private func handleUserDeleteError(_ error: Error) {
        showOkayAlert(title: "Alert Title User Data Delete Error", message: "Alert Description User Data Delete Error")
    }

    // MARK: 개발자 모드

    private func handleDeveloperModeResult(isUpdated: Bool?) {
        guard let isUpdated = isUpdated else {
            showOkayAlert(title: "Error", message: "Alert Description Unwrapping")
            return
        }
        if isUpdated {
            showOkayAlert(title: "Alert Title Developer Mode", message: "Alert Description Developer Mode")
            userUpdate.send(Void())
        } else {
            showOkayAlert(title: "Alert Title Developer Code Invalid", message: "Alert Description Developer Code Invalid")
        }
    }

    private func handleDeveloperModeError(_ error: Error) {
        showOkayAlert(title: "Alert Title Key Chain Error", message: "Alert Description Key Chain Error")
    }

    // MARK: - Cell Alert

    private func deleteData() {
        showConfirmAlert(title: "Alert Title Data Delete", message: "Alert Description Data Delete") { [weak self] in
            self?.userDeleteSubject.send(Void())
        }
    }

    private func showDeveloperCodeAlert() {
        if settingViewModel.user.type == .developer {
            showOkayAlert(title: "Developer Mode", message: "Alert Description Already Developer Mode")
            return
        }

        showTextFieldAlert(title: "Alert Title Developer Code", message: "Alert Description Developer Code") { [weak self] text in
            guard let text = text else {
                self?.showOkayAlert(title: "Error", message: "Alert Description Developer Code Invalid")
                return
            }
            self?.developerCodeSubject.send(text)
        }
    }

    private func appVersion() -> String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
}

// MARK: - Navigation

extension SettingViewController {
    private func moveToSettingLanguage() {
        let settingLanguageViewModel = DependencyFactory.settingLanguageViewModel()
        let settingLanguageViewController = SettingLanguageViewController(settingLanguageViewModel: settingLanguageViewModel)
        navigationController?.pushViewController(settingLanguageViewController, animated: true)
    }

    private func moveToSettingDarkMode() {
        let settingDarkModeViewModel = DependencyFactory.settingDarkModeViewModel()
        let settingDarkModeViewController = SettingDarkModeViewController(settingDarkModeViewModel: settingDarkModeViewModel)
        navigationController?.pushViewController(settingDarkModeViewController, animated: true)
    }
}

// MARK: - Publisher

extension SettingViewController {
    func initDataPublisher() -> AnyPublisher<Void, Never> {
        return userUpdate.eraseToAnyPublisher()
    }
}

// MARK: - TableView

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
                cell.update(title: cellKind.title, value: appVersion())
            } else {
                cell.update(title: cellKind.title)
            }
            cell.selectionStyle = .none
        }

        return cell
    }

    // MARK: - Header

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

    // MARK: - Cell

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
