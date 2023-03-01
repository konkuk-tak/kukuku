//
//  HomeDefaultButton.swift
//  kukuku
//
//  Created by youtak on 2023/03/01.
//

import UIKit

final class HomeDefaultButton: UIButton {

    init(title: String) {
        super.init(frame: .zero)
        configureButton(title: title)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureButton(title: String = "") {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .green
        config.baseForegroundColor = .black
        config.attributedTitle = buttonTitleAttribute(title: title)
        configuration = config
    }

    private func buttonTitleAttribute(title: String) -> AttributedString {
        var titleAttribute = AttributedString(title)
        titleAttribute.font = .body
        return titleAttribute
    }
}
