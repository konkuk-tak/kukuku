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
    private let scoreLabel = UILabel()
    private let konkukInfoListButton = UIButton()
    private let guideButton = UIButton()
    private let settingButton = UIButton()
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
        configureKonkukInfoListButton()
        configureGuideButton()
        configureSettingButton()
        configureArButton()
    }
    
    private func configureTitleLabel() {
        titleLabel.text = "지금까지 먹은 햄버거"
        titleLabel.textColor = .dynamicBlack
        titleLabel.font = .largeTitle
        titleLabel.numberOfLines = 2
    }
    
    private func configureScoreLabel() {
        scoreLabel.text = "0"
        scoreLabel.textColor = .dynamicBlack
        scoreLabel.font = .bitText
    }
    
    private func configureKonkukInfoListButton() {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .green
        config.baseForegroundColor = .dynamicBlack
        var titleAttribute = AttributedString("알쓸건잡")
        titleAttribute.font = .body
        config.attributedTitle = titleAttribute
        konkukInfoListButton.configuration = config
    }
    
    private func configureGuideButton() {
        guideButton.backgroundColor = .green
        guideButton.setTitle("사용법", for: .normal)
        guideButton.setTitleColor(.dynamicBlack, for: .normal)
    }
    
    private func configureSettingButton() {
        settingButton.backgroundColor = .green
        settingButton.setTitle("설정", for: .normal)
        settingButton.setTitleColor(.dynamicBlack, for: .normal)
    }
    
    private func configureArButton() {
        var config = UIButton.Configuration.plain()
        let cameraIcon = UIImage.cameraFillIcon.withConfiguration(UIImage.SymbolConfiguration(pointSize: 30))
        config.image = cameraIcon.withTintColor(.white, renderingMode: .alwaysOriginal)
        arButton.configuration = config
        arButton.backgroundColor = .green
        arButton.addTarget(self, action: #selector(touch), for: .touchUpInside)
    }
    
    @objc func touch() {
        print("hh")
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
