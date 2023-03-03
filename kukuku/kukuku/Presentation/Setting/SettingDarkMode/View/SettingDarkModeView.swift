//
//  SettingDarkModeView.swift
//  kukuku
//
//  Created by youtak on 2023/03/03.
//

import UIKit

final class SettingDarkModeView: KUContainTableView {

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
