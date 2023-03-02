//
//  ARGameViewController.swift
//  kukuku
//
//  Created by youtak on 2023/03/01.
//

import UIKit

final class ARGameViewController: UIViewController {

    private var arGameView: ARGameView {
        guard let view = view as? ARGameView else {
            return ARGameView()
        }
        return view
    }

    // MARK: - Life Cycle
    override func loadView() {
        view = ARGameView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        print("ar Game")
    }
}
