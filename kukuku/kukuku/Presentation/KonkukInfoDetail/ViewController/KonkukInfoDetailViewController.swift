//
//  KonkukInfoDetailViewController.swift
//  kukuku
//
//  Created by youtak on 2023/03/02.
//

import Combine
import UIKit

final class KonkukInfoDetailViewController: UIViewController {

    // MARK: - Property

    private var konkukInfoDetailView: KonkukInfoDetailView {
        guard let view = view as? KonkukInfoDetailView else {
            return KonkukInfoDetailView()
        }
        return view
    }

    private var cancellable = Set<AnyCancellable>()
    private let konkukInfo: KonkukInfo

    var willDismiss: (() -> Void)?

    // MARK: - Life Cycle
    init(konkukInfo: KonkukInfo) {
        self.konkukInfo = konkukInfo
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = KonkukInfoDetailView(konkukInfo: konkukInfo)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        subscribePublisher()
    }

    private func subscribePublisher() {
        konkukInfoDetailView.completeButtonPublisher()
            .sink { [weak self] _ in
                self?.moveToBackScreen()
            }
            .store(in: &cancellable)
    }

    private func moveToBackScreen() {
        willDismiss?()
        dismiss(animated: true)
    }
}
