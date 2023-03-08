//
//  KUContainTableView.swift
//  kukuku
//
//  Created by youtak on 2023/03/03.
//

import UIKit

class KUContainTableView: UIView {
    private (set)var tableView = UITableView()

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
