//
//  KonkukInfoListCell.swift
//  kukuku
//
//  Created by youtak on 2023/03/02.
//

import UIKit

final class KonkukInfoListCell: UITableViewCell {
    // MARK: - Property

    let iconView = UIImageView()
    let titleLabel = UILabel()

    private enum Constant {
        static let paddingHorizontal: CGFloat = 16
        static let space: CGFloat = 8
    }

    // MARK: - Life Cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
        configureSubview()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configure

    private func configureCell() {
        backgroundColor = .clear
    }

    private func configureSubview() {
        addSubview(iconView)
        configureIconView()

        addSubview(titleLabel)
        configureTitleLabel()
    }

    private func configureTitleLabel() {
        titleLabel.font = .body
        titleLabel.textColor = .dynamicBlack
        titleLabel.text = "잠금"
    }

    private func configureIconView() {
        iconView.clipsToBounds = true
        iconView.image = .lockIcon.withTintColor(.dynamicBlack, renderingMode: .alwaysOriginal)
        iconView.contentMode = .scaleAspectFit
    }

    private func configureConstraints() {
        iconView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 1),
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.paddingHorizontal)
        ])

        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalTo: heightAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: Constant.space),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constant.paddingHorizontal)
        ])
    }
}

extension KonkukInfoListCell {
    private func update(image: UIImage, title: String) {
        iconView.image = image
        titleLabel.text = title
    }

    func updateCheck(title: String) {
        update(image: .checkIcon.withTintColor(.green, renderingMode: .alwaysOriginal), title: title)
    }

    func updateLock(number: Int) {
        update(image: .lockIcon.withTintColor(.dynamicBlack, renderingMode: .alwaysOriginal), title: "\(number). 잠금")
    }
}
