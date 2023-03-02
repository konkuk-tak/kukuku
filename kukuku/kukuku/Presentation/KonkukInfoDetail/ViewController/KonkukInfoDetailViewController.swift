//
//  KonkukInfoDetailViewController.swift
//  kukuku
//
//  Created by youtak on 2023/03/02.
//

import UIKit

final class KonkukInfoDetailViewController: UIViewController {

    // MARK: - Property

    private var konkukInfoDetailView: KonkukInfoDetailView {
        guard let view = view as? KonkukInfoDetailView else {
            return KonkukInfoDetailView()
        }
        return view
    }

    // MARK: - Life Cycle

    override func loadView() {
        view = KonkukInfoDetailView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello")
    }
}
