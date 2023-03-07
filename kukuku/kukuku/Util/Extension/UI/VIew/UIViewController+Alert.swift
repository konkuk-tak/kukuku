//
//  UIViewController.swift
//  kukuku
//
//  Created by youtak on 2023/03/03.
//

import UIKit

extension UIViewController {

    fileprivate func createAlert(title: String, message: String, alertActions: [UIAlertAction] = []) -> UIAlertController {
        let sheet = UIAlertController(title: title.localized, message: message.localized, preferredStyle: .alert)

        if alertActions.isEmpty {
            let confirmAction = UIAlertAction(title: "okay".localized, style: .default)
            sheet.addAction(confirmAction)
        } else {
            alertActions.forEach { alertAction in
                sheet.addAction(alertAction)
            }
        }

        return sheet
    }

    fileprivate func createConfirmAlert(
        title: String,
        message: String,
        confirmTitle: String,
        handler: (() -> Void)?,
        cancelHandler: (() -> Void)?
    ) -> UIAlertController {
        let cancelAction = UIAlertAction(title: "cancel".localized, style: .cancel) { _ in
            cancelHandler?()
        }
        let alertAction = UIAlertAction(title: confirmTitle.localized, style: .default) { _ in
            handler?()
        }

        return createAlert(title: title, message: message, alertActions: [cancelAction, alertAction])
    }

    fileprivate func createTextFieldAlert(
        title: String,
        message: String,
        handler: @escaping (String?) -> Void
    ) -> UIAlertController {

        let alert = UIAlertController(title: title.localized, message: message.localized, preferredStyle: .alert)
        alert.addTextField()
        let cancelAction = UIAlertAction(title: "cancel".localized, style: .cancel)

        let alertAction = UIAlertAction(title: "okay".localized, style: .default) { _ in
            handler(alert.textFields?[0].text)
        }
        alert.addAction(cancelAction)
        alert.addAction(alertAction)

        return alert
    }

    fileprivate func showAlert(_ alertController: UIAlertController) {
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }

    func showOkayAlert(title: String, message: String) {
        let alertController = createAlert(title: title, message: message)
        showAlert(alertController)
    }

    func showConfirmAlert(
        title: String,
        message: String,
        confirmTitle: String = "okay",
        handler: (() -> Void)? = nil
    ) {
        let alertController = createConfirmAlert(
            title: title,
            message: message,
            confirmTitle: confirmTitle,
            handler: handler,
            cancelHandler: nil
        )
        showAlert(alertController)
    }

    func showConfirmAlert(
        title: String,
        message: String,
        confirmTitle: String = "okay",
        handler: (() -> Void)? = nil,
        cancelHandeler: (() -> Void)? = nil
    ) {
        let alertController = createConfirmAlert(
            title: title,
            message: message,
            confirmTitle: confirmTitle,
            handler: handler,
            cancelHandler: cancelHandeler
        )
        showAlert(alertController)
    }

    func showTextFieldAlert(title: String, message: String, handler: @escaping (String?) -> Void) {
        let alert = createTextFieldAlert(title: title, message: message, handler: handler)
        showAlert(alert)
    }
}
