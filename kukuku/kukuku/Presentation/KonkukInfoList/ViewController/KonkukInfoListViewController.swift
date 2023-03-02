//
//  KonkukInfoListViewController.swift
//  kukuku
//
//  Created by youtak on 2023/03/01.
//

import UIKit

final class KonkukInfoListViewController: UIViewController {

    // MARK: - Property

    private var konkukInfoListView: KonkukInfoListView {
        guard let view = view as? KonkukInfoListView else {
            return KonkukInfoListView()
        }
        return view
    }

    private enum Constant {
        static let cellHeight: CGFloat = 44
    }

    // MARK: - Life Cycle

    override func loadView() {
        view = KonkukInfoListView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableView()
    }

    // MARK: - Configure

    private func configureNavigationBar() {
        navigationItem.title = "알쓸건잡"
    }

    private func configureTableView() {
        konkukInfoListView.tableViewDelegate(self)
        konkukInfoListView.tableViewDatasource(self)
    }
}

extension KonkukInfoListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: KonkukInfoListCell.identifier,
            for: indexPath
        ) as? KonkukInfoListCell else { return UITableViewCell() }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.cellHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        konkukInfoListView.deSelectTableViewCell()
    }
}
