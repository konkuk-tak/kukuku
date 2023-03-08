//
//  GuideCollectionCell.swift
//  kukuku
//
//  Created by youtak on 2023/03/02.
//

import UIKit

import FlexLayout
import PinLayout

final class GuideCollectionCell: UICollectionViewCell {

    private let containerView = UIView()
    private let imageView = UIImageView()
    private let descriptionLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        configureSubview()
        configureFlexLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.pin.all()
        containerView.flex.layout()
    }

    private func configureCell() {
        backgroundColor = .clear
    }

    private func configureSubview() {
        addSubview(containerView)
        configureImageView()
        configureDescriptionLabel()
    }

    private func configureImageView() {
        imageView.clipsToBounds = true
    }

    private func configureDescriptionLabel() {
        descriptionLabel.textColor = .dynamicBlack
        descriptionLabel.font = .body
        descriptionLabel.numberOfLines = 0
    }

    private func configureFlexLayout() {
        containerView.flex.direction(.column).justifyContent(.start).paddingHorizontal(32).define { flex in
            flex.addItem(imageView).aspectRatio(1)
            flex.addItem(descriptionLabel).marginTop(20)
        }
    }
}

extension GuideCollectionCell {
    func updateCell(_ guideInfo: GuideInfo) {
        imageView.image = UIImage(named: guideInfo.imageName)
        descriptionLabel.text = guideInfo.description
        descriptionLabel.flex.markDirty()
        containerView.flex.layout()
    }
}
