//
//  SettingView.swift
//  kukuku
//
//  Created by youtak on 2023/03/02.
//

import UIKit

final class SettingView: UIView {

    private let tableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        print("설정 뷰")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
