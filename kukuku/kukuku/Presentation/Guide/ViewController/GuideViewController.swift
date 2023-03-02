//
//  GuideViewController.swift
//  kukuku
//
//  Created by youtak on 2023/03/01.
//

import UIKit

final class GuideViewController: UIViewController {

    private var guideView: GuideView {
        guard let view = view as? GuideView else {
            return GuideView()
        }
        return view
    }

    override func loadView() {
        view = GuideView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionViewDelegate()
        print("가이드")
    }

    private func configureCollectionViewDelegate() {
        guideView.collectionViewDatasource(self)
        guideView.collectionViewDelegate(self)
    }
}

extension GuideViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: GuideCollectionCell.identifier,
            for: indexPath
        ) as? GuideCollectionCell else {
            return UICollectionViewCell()
        }
        let description = String(repeating: "ㅋ", count: 100)
        cell.updateCell(GuideInfo(imageName: "person", description: description))
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
