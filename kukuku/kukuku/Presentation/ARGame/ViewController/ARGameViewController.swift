//
//  ARGameViewController.swift
//  kukuku
//
//  Created by youtak on 2023/03/01.
//

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

        output.rangeStatus
            .sink { [weak self] locationStatus in
                self?.handleLocation(locationStatus: locationStatus)
            }
            .store(in: &cancellable)
    }

    private func handleLocation(locationStatus: LocationStatus) {
        arGameView.updateStatusBar(locationStatus: locationStatus)
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
