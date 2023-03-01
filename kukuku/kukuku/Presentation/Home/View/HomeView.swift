//
//  HomeView.swift
//  kukuku
//
//  Created by youtak on 2023/03/01.
//

import UIKit

class HomeView: UIView {
    
    private let containerView = UIView()
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHomeView()
        configureSubViews()
        configureFlexLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.pin.all(pin.safeArea)
        containerView.flex.layout(mode: .adjustHeight)
        configureFlexLayout()
    }
    
    private func configureHomeView() {
        backgroundColor = .background
    }
    
    private func configureSubViews() {
        addSubview(containerView)
        configureTitleLabel()
    }
    
    private func configureTitleLabel() {
        titleLabel.text = "지금까지 먹은 햄버거"
        titleLabel.textColor = .dynamicBlack
        titleLabel.font = .bitText
    }
    
    private func configureFlexLayout() {
        containerView.flex.direction(.column).define { flex in
            flex.addItem(titleLabel)
        }
    }
}
