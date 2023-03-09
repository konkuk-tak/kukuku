//
//  ARGameViewController.swift
//  kukuku
//
//  Created by youtak on 2023/03/01.
//

import AVFoundation
import Combine
import UIKit

final class ARGameViewController: UIViewController {

    // MARK: - Property

    private var arGameView: ARGameView {
        guard let view = view as? ARGameView else {
            return ARGameView()
        }
        return view
    }

    private var arGameViewModel: ARGameViewModel
    private var cancellable = Set<AnyCancellable>()

    var didDismiss: (() -> Void)?

    // MARK: - Life Cycle
    init(arGameViewModel: ARGameViewModel) {
        self.arGameViewModel = arGameViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = ARGameView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        cameraPermission()
        subscribePublisher()
        bind()
    }

    // MARK: Input & Output

    private func subscribePublisher() {
        arGameView.touchTargetPublisher()
            .sink { [weak self] _ in
                self?.moveToKonkukInfoDetailView()
            }
            .store(in: &cancellable)

        arGameView.exitButtonPublisher()
            .sink { [weak self] _ in
                self?.moveToHomeView()
            }
            .store(in: &cancellable)
    }

    private func bind() {
        let viewDidLoad = Just(Void()).eraseToAnyPublisher()
        let input = ARGameViewModel.Input(viewDidLoad: viewDidLoad)
        let output = arGameViewModel.transform(input: input)

        output.locationAuthorizationStatus
            .sink { [weak self] authorizationStatus in
                self?.handleAuthorizationStatus(authorizationStatus)
            }
            .store(in: &cancellable)

        output.rangeStatus
            .sink { [weak self] locationStatus in
                self?.handleLocation(locationStatus: locationStatus)
            }
            .store(in: &cancellable)
    }

    private func handleLocation(locationStatus: LocationStatus) {
        arGameView.updateStatusBar(locationStatus: locationStatus)
    }

    // MARK: - Permission

    private func cameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { [weak self] isAllowed in
            if !isAllowed {
                self?.showPermissionSettingAlert(title: "Alert Title Camera Permission", message: "Alert Description Camera Permission")
            }
        }
    }

    private func handleAuthorizationStatus(_ authorizationStatus: AuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined, .denied:
            showPermissionSettingAlert(title: "Alert Title Location Permission", message: "Alert Description Location Permission")
        case .allow:
            return
        }
    }

    private func showPermissionSettingAlert(title: String, message: String) {
        showConfirmAlert(
            title: title,
            message: message,
            confirmTitle: "Set Button",
            handler: {
                PermissionManager.moveToiPhoneSetting()
            },
            cancelHandeler: {
                self.dismiss(animated: true)
            }
        )
    }

    // MARK: - Navigation

    private func moveToHomeView() {
        dismiss(animated: true)
    }

    private func moveToKonkukInfoDetailView() {
        dismiss(animated: false) {
            self.didDismiss?()
        }
    }
}
