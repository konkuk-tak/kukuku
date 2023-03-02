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
        configureDelegate()
        print("가이드")
    }

    private func configureDelegate() {
        guideView.collectionViewDatasource(self)
    }
}

extension GuideViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
