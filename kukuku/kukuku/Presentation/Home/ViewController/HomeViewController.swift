//
//  ViewController.swift
//  kukuku
//
//  Created by youtak on 2023/03/01.
//

import UIKit
import FlexLayout
import PinLayout

class HomeViewController: UIViewController {

    private var homeView: HomeView {
        guard let view = view as? HomeView else {
            return HomeView()
        }
        return view
    }
    
    override func loadView() {
        view = HomeView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello")
    }
}
