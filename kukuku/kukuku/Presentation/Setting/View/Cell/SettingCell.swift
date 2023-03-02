//
//  SettingCell.swift
//  kukuku
//
//  Created by youtak on 2023/03/02.
//

import UIKit

final class SettingCell: UITableViewCell {

    // MARK: - Property

    let titleLabel = UILabel()
    let valueLabel = UILabel()

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

        addSubview(valueLabel)
        configureValueLabel()
    }

    private func configureTitleLabel() {
        titleLabel.font = .body
        titleLabel.textColor = .dynamicBlack
    }

    private func configureValueLabel() {
        valueLabel.font = .body
        valueLabel.textColor = .dynamicBlack
    }

    private func configureConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalTo: heightAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.paddingHorizontal),
            titleLabel.trailingAnchor.constraint(equalTo: valueLabel.leadingAnchor)
        ])

        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        NSLayoutConstraint.activate([
            valueLabel.heightAnchor.constraint(equalTo: heightAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.paddingHorizontal),
            valueLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
    }
}

extension SettingCell {
    func update(title: String, value: String = "") {
        titleLabel.text = title
        valueLabel.text = value
    }
}
