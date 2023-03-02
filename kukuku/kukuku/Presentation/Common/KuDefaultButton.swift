//
//  HomeDefaultButton.swift
//  kukuku
//
//  Created by youtak on 2023/03/01.
//

import UIKit

enum DefaultButtonStyle {
    case normal
    case heavy

    var paddingHorizontal: Int {
        switch self {
        case .normal: return 10
        case .heavy: return 14
        }
    }
}

final class KUDefaultButton: UIButton {

    init(title: String, style: DefaultButtonStyle = .normal) {
        super.init(frame: .zero)
        configureButton(defaultButtonStyle: style, title: title)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureButton(defaultButtonStyle: DefaultButtonStyle, title: String) {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .green
        config.baseForegroundColor = .black
        config.attributedTitle = buttonTitleAttribute(title: title)

        let horizontalInsets = CGFloat(defaultButtonStyle.paddingHorizontal)
        config.contentInsets = NSDirectionalEdgeInsets(top: horizontalInsets, leading: 0, bottom: horizontalInsets, trailing: 0)

        configuration = config
    }

    private func buttonTitleAttribute(title: String) -> AttributedString {
        var titleAttribute = AttributedString(title)
        titleAttribute.font = .body
        return titleAttribute
    }
}

extension KUDefaultButton {
    func updateButtonTitle(text: String) {
        if var config = configuration {
            config.attributedTitle = buttonTitleAttribute(title: text)
            configuration = config
        }
    }

    func updateButtonColor(color: UIColor) {
        if var config = configuration {
            config.baseBackgroundColor = color
            configuration = config
        }
    }

    func updateTitleColor(color: UIColor) {
        if var config = configuration {
            config.baseForegroundColor = color
            configuration = config
        }
    }
}
