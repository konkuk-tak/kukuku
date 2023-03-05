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
    private var userDeleteSubject = PassthroughSubject<Void, Never>()
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

        let input = SettingViewModel.Input(deleteUser: deleteUser)
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
    }

    private func handleUserDeleteResult() {
        showOkayAlert(title: "삭제 완료", message: "데이터를 삭제했어요")
    }

    private func handleUserDeleteError(_ error: Error) {
        showOkayAlert(title: "유저 삭제 에러", message: "유저 삭제 중 에러가 발생했어요. 개발자에게 문의해주세요. \(error)")
    }

    // MARK: - Cell Alert

    private func deleteData() {
        showConfirmAlert(title: "데이터 삭제", message: "삭제하면 복구할 수 없어요. 정말로 삭제하시겠어요?") { [weak self] in
            self?.userDeleteSubject.send(Void())
        }
    }

    private func showDeveloperCodeAlert() {
        showTextFieldAlert(title: "개발자 코드", message: "개발자 코드를 입력해주세요.") { text in
            guard let text = text else { return }
            print(text)
        }
    }

    private func appVersion() -> String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
}

// MARK: - Navigation

extension SettingViewController {
    private func moveToSettingLanguage() {
        let settingLanguageViewController = SettingLanguageViewController()
        navigationController?.pushViewController(settingLanguageViewController, animated: true)
    }

    private func moveToSettingDarkMode() {
        let settingDarkModeViewModel = DependencyFactory.settingDarkModeViewModel()
        let settingDarkModeViewController = SettingDarkModeViewController(settingDarkModeViewModel: settingDarkModeViewModel)
        navigationController?.pushViewController(settingDarkModeViewController, animated: true)
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
