//
//  UIViewController.swift
//  kukuku
//
//  Created by youtak on 2023/03/03.
//

import UIKit

extension UIViewController {

    fileprivate func showAlert(title: String, message: String, alertActions: [UIAlertAction] = []) {
        let sheet = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )

        if alertActions.isEmpty {
            let confirmAction = UIAlertAction(title: "확인", style: .default)
            sheet.addAction(confirmAction)
        } else {
            alertActions.forEach { alertAction in
                sheet.addAction(alertAction)
            }
        }

        DispatchQueue.main.async {
            self.present(sheet, animated: true)
        }
    }

    func showOkayAlert(title: String, message: String) {
        showAlert(title: title, message: message)
    }

    func showConfirmAlert(title: String, message: String, handler: @escaping () -> Void) {
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        let alertAction = UIAlertAction(title: "확인", style: .default) { _ in
            handler()
        }

        showAlert(title: title, message: message, alertActions: [cancelAction, alertAction])
    }
}
