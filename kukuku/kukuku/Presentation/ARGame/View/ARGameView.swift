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

    private var arView: ARView! = ARView()
    private let statusBarContainer = UIView()
    private let statusBar = UILabel()
    private let exitButton = KUDefaultButton(title: "close", style: .heavy)
    private var targetScene: RealityComposerManager.TargetScene?
    private var targetTouchSubject = PassthroughSubject<Void, Never>()

    private var hasHamburger: Bool = false

    private enum Constant {
        static let opacity: Float = 0.5
        static let textOpacity: Float = 0.7
        static let paddingHorizontal: CGFloat = 16
        static let statusContainerHeight = 32 + UIApplication.shared.keyWindow.safeAreaInsets.top
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

    // MARK: - Configure

    private func configureView() {
        backgroundColor = .background
    }

    private func configureSubView() {
        addSubview(arView)
        configureARView()

        addSubview(statusBarContainer)
        configureStatusBarContainer()

        statusBarContainer.addSubview(statusBar)
        configureStatusBar()

        addSubview(exitButton)
        configureExitButton()
    }

    private func configureConstraints() {
        arViewConstraints()
        statusBarContainerConstraints()
        statusBarConstraints()
        exitButtonConstraints()
    }

    // MARK: - Configure

    private func configureARView() {
        targetScene = try? RealityComposerManager.loadTargetScene()

        if let targetScene = targetScene {
            targetScene.hamburgerTouched.onAction = { [weak self] entity in
                guard entity != nil else { return }
                self?.targetTouchSubject.send(Void())
            }
        }
    }

    private func configureStatusBarContainer() {
        statusBarContainer.backgroundColor = .blue.withAlphaComponent(CGFloat(Constant.opacity))
    }

    private func configureStatusBar() {
        statusBar.backgroundColor = .clear
        statusBar.font = .body
        statusBar.textAlignment = .center
        statusBar.textColor = .white
        statusBar.text = LocationStatus.notDetermined.message.localized
        statusBar.layer.opacity = Constant.textOpacity
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

    private func statusBarContainerConstraints() {
        statusBarContainer.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            statusBarContainer.topAnchor.constraint(equalTo: topAnchor),
            statusBarContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            statusBarContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            statusBarContainer.heightAnchor.constraint(equalToConstant: Constant.statusContainerHeight)
        ])
    }

    private func statusBarConstraints() {
        statusBar.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            statusBar.bottomAnchor.constraint(equalTo: statusBarContainer.bottomAnchor),
            statusBar.leadingAnchor.constraint(equalTo: statusBarContainer.leadingAnchor),
            statusBar.trailingAnchor.constraint(equalTo: statusBarContainer.trailingAnchor),
            statusBar.heightAnchor.constraint(equalToConstant: Constant.statusBarHeight)
        ])
    }

    private func exitButtonConstraints() {
        exitButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            exitButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Constant.bottomMargin),
            exitButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.paddingHorizontal),
            exitButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.paddingHorizontal)
        ])
    }

    private func updateStatusBarNotDetermined(text: String) {
        statusBarContainer.backgroundColor = .blue.withAlphaComponent(CGFloat(Constant.opacity))
        statusBar.text = text
    }

    private func updateStatusBarSuccess(text: String) {
        statusBarContainer.backgroundColor = .green.withAlphaComponent(CGFloat(Constant.opacity))
        statusBar.text = text
        if !hasHamburger, let targetScene = targetScene {
            arView.scene.anchors.append(targetScene)
            hasHamburger = true
        }
    }

    private func updateStatusBarFail(text: String) {
        statusBarContainer.backgroundColor = .red.withAlphaComponent(CGFloat(Constant.opacity))
        statusBar.text = text
        if hasHamburger {
            arView.scene.anchors.removeAll()
            hasHamburger = false
        }
    }
}

extension ARGameView {
    func updateStatusBar(locationStatus: LocationStatus) {
        switch locationStatus {
        case .notDetermined:
            updateStatusBarNotDetermined(text: locationStatus.message.localized)
        case .success:
            updateStatusBarSuccess(text: locationStatus.message.localized)
        case .fail:
            updateStatusBarFail(text: locationStatus.message.localized)
        }
    }
}

extension ARGameView {
    func touchTargetPublisher() -> AnyPublisher<Void, Never> {
        return targetTouchSubject.eraseToAnyPublisher()
    }

    func exitButtonPublisher() -> AnyPublisher<Void, Never> {
        return exitButton.tapPublisher
            .eraseToAnyPublisher()
    }
}
