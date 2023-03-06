//
//  KonkukInfoListViewController.swift
//  kukuku
//
//  Created by youtak on 2023/03/01.
//

import Combine
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

    private let konkukInfoListViewModel: KonkukInfoListViewModel
    private var cancellable = Set<AnyCancellable>()

    // MARK: - Life Cycle

    init(konkukInfoListViewModel: KonkukInfoListViewModel) {
        self.konkukInfoListViewModel = konkukInfoListViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = KonkukInfoListView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableView()
        bind()
    }

    // MARK: - Configure

    private func configureNavigationBar() {
        navigationItem.title = "알쓸건잡"
    }

    private func configureTableView() {
        konkukInfoListView.tableViewDelegate(self)
        konkukInfoListView.tableViewDataSource(self)
    }

    // MARK: - bind

    private func bind() {
        let viewDidLoad = Just(Void())
            .eraseToAnyPublisher()

        let input = KonkukInfoListViewModel.Input(viewDidLoad: viewDidLoad)
        let output = konkukInfoListViewModel.transform(input: input)

        output.infoList
            .sink {  _ in
            }
            .store(in: &cancellable)
    }

    // MARK: - Touch List

    private func moveToDetail(index: Int) {
        let konkukInfo = konkukInfoListViewModel.konkukInfo(index: index)
        let detailViewController = KonkukInfoDetailViewController(konkukInfo: konkukInfo)
        detailViewController.modalPresentationStyle = .fullScreen
        present(detailViewController, animated: true)
    }
}

extension KonkukInfoListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return konkukInfoListViewModel.maxCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: KonkukInfoListCell.identifier,
            for: indexPath
        ) as? KonkukInfoListCell else { return UITableViewCell() }

        let index = indexPath.row
        if index < konkukInfoListViewModel.konkukInfoList.count {
            let title = konkukInfoListViewModel.konkukInfo(index: index).title
            cell.updateCheck(number: index + 1, title: title)
        } else {
            cell.updateLock(number: index + 1)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.cellHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        if index < konkukInfoListViewModel.currentCount {
            moveToDetail(index: index)
        }

        konkukInfoListView.deSelectTableViewCell()
    }
}
