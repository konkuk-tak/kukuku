//
//  GuideViewController.swift
//  kukuku
//
//  Created by youtak on 2023/03/01.
//

import Combine
import UIKit

final class GuideViewController: UIViewController {

    // MARK: - Property

    private var guideView: GuideView {
        guard let view = view as? GuideView else {
            return GuideView()
        }
        return view
    }

    private var guideViewModel: GuideViewModel
    private var cancellable = Set<AnyCancellable>()

    // MARK: - Life Cycle

    init(viewModel: GuideViewModel) {
        self.guideViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = GuideView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureCollectionViewDelegate()
        subscribePublisher()
    }

    private func configureNavigationBar() {
        navigationItem.title = "Guide".localized
    }

    private func configureCollectionViewDelegate() {
        guideView.collectionViewDatasource(self)
        guideView.collectionViewDelegate(self)
    }

    private func subscribePublisher() {
        guideView.buttonPublisher()
            .sink { [weak self] _ in
                self?.buttonTouchUpInside()
            }
            .store(in: &cancellable)
    }

    private func buttonTouchUpInside() {
        let nextIndex = guideViewModel.nextIndex
        if nextIndex < guideViewModel.infoListCount() {
            moveToNextPage(index: nextIndex)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }

    private func moveToNextPage(index: Int) {
        guideView.moveToNextPage(index: index)
        guideView.updatePageControl(index)
        if index == guideViewModel.infoListCount() - 1 {
            guideView.updateButtonTitle()
        }
    }
}

extension GuideViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return guideViewModel.infoListCount()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: GuideCollectionCell.identifier,
            for: indexPath
        ) as? GuideCollectionCell else {
            return UICollectionViewCell()
        }
        guard let guideInfo = guideViewModel.guideInfo(index: indexPath.row) else { return UICollectionViewCell() }
        cell.updateCell(guideInfo)
        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let size = CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
        return size
    }
}
