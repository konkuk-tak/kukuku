//
//  GuideView.swift
//  kukuku
//
//  Created by youtak on 2023/03/02.
//

import Combine
import UIKit

final class GuideView: UIView {

    private let containerView = UIView()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    private let pageControl = UIPageControl()
    private let button = KUDefaultButton(title: "Next".localized, style: .heavy)

    private enum Constant {
        static let paddingHorizontal: CGFloat = 16
        static let imageMarginTop: CGFloat = 40
        static let buttonMarginBottom: CGFloat = 12
    }

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
    }

    private func createLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        return layout
    }

    private func configureCollectionView() {
        collectionView.isScrollEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = .zero
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = true
        collectionView.register(GuideCollectionCell.self, forCellWithReuseIdentifier: GuideCollectionCell.identifier)
    }

    private func configurePageControl() {
        pageControl.pageIndicatorTintColor = .systemGray5
        pageControl.currentPageIndicatorTintColor = .green
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0
        pageControl.isUserInteractionEnabled = false
    }

    private func configureFlexLayout() {
        containerView.flex.direction(.column).define { flex in
            flex.addItem().grow(0.3)
            flex.addItem(collectionView).grow(7)

            flex.addItem().grow(1)

            flex.addItem(pageControl)

            flex.addItem().justifyContent(.center).paddingHorizontal(Constant.paddingHorizontal).define { flex in
                flex.addItem(button)
            }
            .marginBottom(Constant.buttonMarginBottom)
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

extension GuideView {
    func getCollectionView() -> UICollectionView {
        return collectionView
    }

    func buttonPublisher() -> AnyPublisher<Void, Never> {
        return button.tapPublisher
    }

    func updatePageControl(_ page: Int) {
        pageControl.currentPage = page
    }

    func updateButtonTitle() {
        button.updateButtonTitle(text: "완료")
    }

    func moveToNextPage(index: Int) {
        collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: true)
    }
}
