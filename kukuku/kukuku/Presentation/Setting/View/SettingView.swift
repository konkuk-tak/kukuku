//
//  SettingView.swift
//  kukuku
//
//  Created by youtak on 2023/03/02.
//

import UIKit

final class SettingView: UIView {

    // MARK: - Property

    private let tableView = UITableView()

    private enum Constant {
        static let headerPaddingTop: CGFloat = 5
    }

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubview()
        configureTableView()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: configure

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
}

extension SettingView {
    func tableViewDatasource(_ dataSource: UITableViewDataSource) {
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
