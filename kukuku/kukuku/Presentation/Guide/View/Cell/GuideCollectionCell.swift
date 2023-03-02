//
//  GuideCollectionCell.swift
//  kukuku
//
//  Created by youtak on 2023/03/02.
//

import UIKit

import FlexLayout

final class GuideCollectionCell: UICollectionViewCell {

    private let imageView = UIImageView()
    private let descriptionLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        configureImageView()
        configureDescriptionLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureCell() {
        backgroundColor = .systemBlue
    }

    private func configureImageView() {
        imageView.clipsToBounds = true
    }

    private func configureDescriptionLabel() {
        descriptionLabel.textColor = .dynamicBlack
        descriptionLabel.font = .body
    }
}

extension GuideCollectionCell {
    func updateCell(_ guideInfo: GuideInfo) {
        DispatchQueue.main.async {
            self.imageView.image = UIImage(systemName: guideInfo.imageName) // TODO: UIImage(named:)로 변경
            self.descriptionLabel.text = guideInfo.description
        }
    }
}
