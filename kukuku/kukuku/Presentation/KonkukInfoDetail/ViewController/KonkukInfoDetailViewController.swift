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

    // MARK: - Life Cycle

    override func loadView() {
        view = KonkukInfoDetailView()
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
        dismiss(animated: true)
    }
}
