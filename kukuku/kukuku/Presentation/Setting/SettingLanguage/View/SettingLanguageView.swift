//
//  SettingLanguageView.swift
//  kukuku
//
//  Created by youtak on 2023/03/03.
//

import UIKit

final class SettingLanguageView: UIView {

    // MARK: - Property

    private let tableView = UITableView()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureSubView()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureView() {
        backgroundColor = .background
    }

    private func configureSubView() {
        addSubview(tableView)
        configureTableView()
    }

    private func configureTableView() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.register(SettingCheckCell.self, forCellReuseIdentifier: SettingCheckCell.identifier)
    }

    // MARK: - Constraints

    private func configureConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

extension SettingLanguageView {
    func tableViewDataSource(_ dataSource: UITableViewDataSource) {
        tableView.dataSource = dataSource
    }

    func tableViewDelegate(_ delegate: UITableViewDelegate) {
        tableView.delegate = delegate
    }

    func deSelectTableViewCell() {
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: true)
        }
    }
}
