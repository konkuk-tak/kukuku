//
//  ARGameView.swift
//  kukuku
//
//  Created by youtak on 2023/03/02.
//

import Combine
import RealityKit
import UIKit

final class ARGameView: UIView {

    // MARK: - Property

    private let arView = ARView()
    private let statusBar = UILabel()
    private let exitButton = KUDefaultButton(title: "종료", style: .heavy)

    private enum Constant {
        static let opacity: Float = 0.7
        static let statusBarHeight: CGFloat = 32
        static let bottomMargin: CGFloat = 24
    }

    // MARK: - Life Cycle

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
        backgroundColor = .background
    }

    private func configureSubView() {
        addSubview(arView)

        addSubview(statusBar)
        configureStatusBar()

        addSubview(exitButton)
        configureExitButton()
    }

    private func configureConstraints() {
        arViewConstraints()
        statusBarConstraints()
        exitButtonConstraints()
    }

    // MARK: - Configure

    private func configureStatusBar() {
        statusBar.backgroundColor = .blue
        statusBar.font = .body
        statusBar.textAlignment = .center
        statusBar.textColor = .white
        statusBar.text = "위치 검색 중"
        statusBar.layer.opacity = Constant.opacity
    }

    private func configureExitButton() {
        exitButton.updateButtonColor(color: .red)
        exitButton.updateTitleColor(color: .white)
        exitButton.layer.opacity = Constant.opacity
    }

    // MARK: - Constraints

    private func arViewConstraints() {
        arView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            arView.topAnchor.constraint(equalTo: topAnchor),
            arView.bottomAnchor.constraint(equalTo: bottomAnchor),
            arView.leadingAnchor.constraint(equalTo: leadingAnchor),
            arView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func statusBarConstraints() {
        statusBar.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            statusBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            statusBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            statusBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            statusBar.heightAnchor.constraint(equalToConstant: Constant.statusBarHeight)
        ])
    }

    private func exitButtonConstraints() {
        exitButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            exitButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Constant.bottomMargin),
            exitButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            exitButton.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

extension ARGameView {
    func exitButtonPublisher() -> AnyPublisher<Void, Never> {
        return exitButton.tapPublisher
    }
}
