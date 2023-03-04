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

    private var cancellable = Set<AnyCancellable>()

    // MARK: - Life Cycle

    override func loadView() {
        view = ARGameView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        subscribePublisher()
    }

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

    private func moveToHomeView() {
        dismiss(animated: true)
    }

    private func moveToKonkukInfoDetailView() {
        let konkukInfo = KonkukInfo(id: "k31", imageURL: nil, title: "시험용", description: String(repeating: "ㅋ", count: 200))
        let konkukInfoDetailViewController = KonkukInfoDetailViewController(konkukInfo: konkukInfo)
        konkukInfoDetailViewController.modalPresentationStyle = .fullScreen
        present(konkukInfoDetailViewController, animated: true)
    }
}
