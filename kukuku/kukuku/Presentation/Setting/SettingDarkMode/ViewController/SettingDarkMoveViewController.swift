//
//  SettingDarkMoveViewController.swift
//  kukuku
//
//  Created by youtak on 2023/03/02.
//

import Combine
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

    private var settingDarkModeViewModel: SettingDarkModeViewModel

    private var darkModeSubject = PassthroughSubject<DarkModeKind, Never>()
    private var cancellable = Set<AnyCancellable>()

    // MARK: - Life Cycle

    init(settingDarkModeViewModel: SettingDarkModeViewModel) {
        self.settingDarkModeViewModel = settingDarkModeViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = SettingDarkModeView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        bind()
    }

    // MARK: - Configure

    private func configureTableView() {
        settingDarkModeView.tableViewDelegate(self)
        settingDarkModeView.tableViewDataSource(self)
    }

    // MARK: - Bind

    private func bind() {
        let input = SettingDarkModeViewModel.Input(darkMode: darkModeSubject.eraseToAnyPublisher())
        let output = settingDarkModeViewModel.transform(input: input)
        output.updateDarkMode
            .sink { [weak self] darkModeKind in
                self?.handleDarkMode(darkModeKind: darkModeKind)
            }
            .store(in: &cancellable)
    }

    // MARK: - Method

    private func handleDarkMode(darkModeKind: DarkModeKind?) {
        guard let darkModeKind = darkModeKind else {
            showOkayAlert(title: "다크코드 설정 에러", message: "다크모드 설정 중 에러가 발생했어요. 에러 코드 [nil]")
            return
        }

        DarkModeManager.mode(darkModeKind: darkModeKind)

        DispatchQueue.main.async {
            self.settingDarkModeView.tableView.reloadData()
        }
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

        if darkModeKind == settingDarkModeViewModel.currentMode {
            cell.update(title: darkModeKind.title, isChecked: true)
        } else {
            cell.update(title: darkModeKind.title)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.cellHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let darkModeKind = DarkModeKind(index: indexPath.row) else {
            return
        }
        if darkModeKind != settingDarkModeViewModel.currentMode {
            darkModeSubject.send(darkModeKind)
        }

        settingDarkModeView.deSelectTableViewCell()
    }
}
