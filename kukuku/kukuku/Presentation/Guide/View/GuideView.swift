//
//  GuideView.swift
//  kukuku
//
//  Created by youtak on 2023/03/02.
//

import UIKit

final class GuideView: UIView {

    private let containerView = UIView()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureGuideView()
        configureSubViews()
        configureFlexLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.frame = CGRect(x: 0, y: 0, width: frame.width, height: containerView.frame.height)
        containerView.flex.layout()
    }

    private func configureGuideView() {
        backgroundColor = .background
    }

    private func configureSubViews() {
        addSubview(containerView)
        configureCollectionView()
    }

    private func createLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }

    private func configureCollectionView() {
        collectionView.isScrollEnabled = true // TODO: false 로 변경
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = .zero
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = true
    }

    private func configureFlexLayout() {
        containerView.flex.direction(.column).define { flex in
        }
    }
}

extension GuideView {
    func collectionViewDelegate(_ viewController: UICollectionViewDelegate) {
        collectionView.delegate = viewController
    }

    func collectionViewDatasource(_ viewController: UICollectionViewDataSource) {
        collectionView.dataSource = viewController
    }
}
