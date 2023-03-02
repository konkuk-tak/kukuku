//
//  SettingSectionHeader.swift
//  kukuku
//
//  Created by youtak on 2023/03/02.
//

import UIKit

final class SettingSectionHeader: UITableViewHeaderFooterView {

    private let titleLabel = UILabel()

    private enum Constant {
        static let paddingHorizontal: CGFloat = 16
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureTitleLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureTitleLabel() {
        titleLabel.font = .body
        titleLabel.textColor = .systemGray2

        addSubview(titleLabel)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.paddingHorizontal),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.paddingHorizontal),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension SettingSectionHeader {
    func updateTitle(text: String) {
        titleLabel.text = text
    }
}
