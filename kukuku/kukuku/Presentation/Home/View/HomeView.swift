//
//  HomeView.swift
//  kukuku
//
//  Created by youtak on 2023/03/01.
//

import Combine
import UIKit

class HomeView: UIView {

    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let scoreLabel = UILabel()
    private let konkukInfoListButton = KUDefaultButton(title: "알쓸건잡")
    private let guideButton = KUDefaultButton(title: "이용법")
    private let settingButton = KUDefaultButton(title: "설정")
    private let arButton = UIButton()

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
        containerView.flex.layout()
    }

    private func configureHomeView() {
        backgroundColor = .background
    }

    private func configureSubViews() {
        addSubview(containerView)
        configureTitleLabel()
        configureScoreLabel()
        configureArButton()
    }

    private func configureTitleLabel() {
        titleLabel.text = "Hamburger Score".localized
        titleLabel.textColor = .dynamicBlack
        titleLabel.font = .largeTitle
        titleLabel.numberOfLines = 2
    }

    private func configureScoreLabel() {
        scoreLabel.text = "0"
        scoreLabel.textColor = .dynamicBlack
        scoreLabel.font = .bitText
    }

    private func configureArButton() {
        var config = UIButton.Configuration.plain()
        let cameraIcon = UIImage.cameraFillIcon.withConfiguration(UIImage.SymbolConfiguration(pointSize: 30))
        config.image = cameraIcon.withTintColor(.white, renderingMode: .alwaysOriginal)
        arButton.configuration = config
        arButton.backgroundColor = .green
        arButton.addTarget(self, action: #selector(arButtonTouchDown), for: .touchDown)
        arButton.addTarget(self, action: #selector(arButtonTouchUpInside), for: .touchUpInside)
    }

    @objc private func arButtonTouchDown() {
        arButton.layer.opacity = 0.7
    }

    @objc private func arButtonTouchUpInside() {
        arButton.layer.opacity = 1.0
    }

    private func configureFlexLayout() {
        containerView.flex.direction(.column).paddingHorizontal(16).define { flex in

            flex.addItem().direction(.column).alignItems(.center).define { flex in
                flex.addItem(titleLabel).marginTop(40)
                flex.addItem(scoreLabel)
            }

            flex.addItem().justifyContent(.center).define { flex in
                flex.addItem(konkukInfoListButton)
                flex.addItem(guideButton).marginTop(10)
                flex.addItem(settingButton).marginTop(10)
            }
            .marginTop(16)

            flex.addItem().grow(1)

            flex.addItem().alignItems(.center).justifyContent(.end).define { flex in
                flex.addItem(arButton).width(80).height(80).cornerRadius(40)
            }
            .marginBottom(20)
        }
    }
}

extension HomeView {
    func konkukInfoListButtonPublisher() -> AnyPublisher<Void, Never> {
        return konkukInfoListButton.tapPublisher
    }

    func guideButtonPublisher() -> AnyPublisher<Void, Never> {
        return guideButton.tapPublisher
    }

    func settingButtonPublisher() -> AnyPublisher<Void, Never> {
        return settingButton.tapPublisher
    }

    func arButtonPublisher() -> AnyPublisher<Void, Never> {
        return arButton.tapPublisher
    }
}

extension HomeView {
    func update(score: Int) {
        scoreLabel.text = String(score)
        scoreLabel.flex.markDirty()
        containerView.flex.layout()
    }
}
