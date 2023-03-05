//
//  KUImageView.swift
//  kukuku
//
//  Created by youtak on 2023/03/05.
//

import UIKit

final class KUImageView: UIView {

    private let infoImageView = UIImageView()
    private let descriptionLabel = UILabel()

    var hasImage: Bool { return infoImageView.image != nil}

    private enum Constant {
        static let descriptionHeight: CGFloat = 24
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureSubView()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureView() {
        backgroundColor = .clear
    }

    private func configureSubView() {
        addSubview(infoImageView)
        configureInfoImageView()

        addSubview(descriptionLabel)
        configureDescriptionLabel()
    }

    private func configureInfoImageView() {
        infoImageView.clipsToBounds = true
    }

    private func configureDescriptionLabel() {
        descriptionLabel.font = .body
        descriptionLabel.textColor = .dynamicBlack
        descriptionLabel.backgroundColor = .systemGray5
    }

    private func configureConstraints() {
        infoImageView.translatesAutoresizingMaskIntoConstraints = true

        NSLayoutConstraint.activate([
            infoImageView.topAnchor.constraint(equalTo: topAnchor),
            infoImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            infoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            infoImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        descriptionLabel.translatesAutoresizingMaskIntoConstraints = true

        NSLayoutConstraint.activate([
            descriptionLabel.heightAnchor.constraint(equalToConstant: Constant.descriptionHeight),
            descriptionLabel.topAnchor.constraint(equalTo: infoImageView.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

extension KUImageView {
    func update(imageName: String, description: String) {
        if !imageName.isEmpty, let image = UIImage(named: "guide1") {
            infoImageView.image = image
            descriptionLabel.text = description
        }
    }
}
