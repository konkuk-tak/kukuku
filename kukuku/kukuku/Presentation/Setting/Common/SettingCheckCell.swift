//
//  SettingCheckCell.swift
//  kukuku
//
//  Created by youtak on 2023/03/03.
//

import UIKit

final class SettingCheckCell: UITableViewCell {

    // MARK: - Property

    private let titleLabel = UILabel()
    private let checkImageView = UIImageView()

    private enum Constant {
        static let paddingHorizontal: CGFloat = 16
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
        addSubview(titleLabel)
        configureTitleLabel()

        addSubview(checkImageView)
        configureCheckImageView()
    }

    private func configureTitleLabel() {
        titleLabel.font = .body
        titleLabel.textColor = .dynamicBlack
    }

    private func configureCheckImageView() {
        checkImageView.clipsToBounds = true
        checkImageView.contentMode = .scaleAspectFit
    }

    private func configureConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalTo: heightAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.paddingHorizontal),
            titleLabel.trailingAnchor.constraint(equalTo: checkImageView.leadingAnchor)
        ])

        checkImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            checkImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 1),
            checkImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.paddingHorizontal),
            checkImageView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
    }

    private func updateCheckImage(isChecked: Bool) {
        if isChecked {
            checkImageView.image = .checkIcon.withTintColor(.green, renderingMode: .alwaysOriginal)
        } else {
            checkImageView.image = nil
        }
    }
}

extension SettingCheckCell {
    func update(title: String, isChecked: Bool = false) {
        titleLabel.text = title.localized
        updateCheckImage(isChecked: isChecked)
    }
}
