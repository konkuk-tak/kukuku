//
//  HomeView.swift
//  kukuku
//
//  Created by youtak on 2023/03/01.
//

import UIKit

class HomeView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHomeView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHomeView() {
        backgroundColor = .green
    }
    
}
