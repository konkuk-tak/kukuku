//
//  SettingView.swift
//  kukuku
//
//  Created by youtak on 2023/03/02.
//

import UIKit

final class SettingView: KUContainTableView {

    // MARK: - Property

    private enum Constant {
        static let headerPaddingTop: CGFloat = 5
    }

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureSubview()
        configureTableView()
        configureConstraints()
        accessibilityIdentifier()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: configure

    private func configureView() {
        backgroundColor = .background
    }

    private func configureSubview() {
        addSubview(tableView)
    }

    private func configureTableView() {
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.sectionHeaderTopPadding = Constant.headerPaddingTop
        tableView.register(SettingCell.self, forCellReuseIdentifier: SettingCell.identifier)
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

    private func accessibilityIdentifier() {
        tableView.accessibilityIdentifier = KUAccessibilityIdentifier
            .Setting
            .tableView
    }
}
