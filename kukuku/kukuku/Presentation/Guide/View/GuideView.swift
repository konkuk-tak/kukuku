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
    private let pageControl = UIPageControl()
    private let button = UIButton()

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
        containerView.pin.all(pin.safeArea)
        containerView.flex.layout()
    }

    private func configureGuideView() {
        backgroundColor = .background
    }

    private func configureSubViews() {
        addSubview(containerView)
        configureCollectionView()
        configurePageControl()
        configureButton()
    }

    private func createLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        return layout
    }

    private func configureCollectionView() {
        collectionView.isScrollEnabled = true // TODO: false 로 변경
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = .zero
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = true
        collectionView.register(GuideCollectionCell.self, forCellWithReuseIdentifier: GuideCollectionCell.identifier)
    }

    private func configurePageControl() {
        pageControl.backgroundColor = .orange
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0
        pageControl.isUserInteractionEnabled = false
    }

    private func configureButton() {
        button.setTitle("다음", for: .normal)
        button.backgroundColor = .green
    }

    private func configureFlexLayout() {
        containerView.flex.direction(.column).define { flex in
            flex.addItem(collectionView).grow(5).marginTop(40)

            flex.addItem().grow(1)

            flex.addItem(pageControl)

            flex.addItem().justifyContent(.center).paddingHorizontal(16).define { flex in
                flex.addItem(button).paddingHorizontal(16)
            }
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
