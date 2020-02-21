//
//  UIAlertController_Extension.swift
//  swift-boilerplate
//
//  Created by Steve Chan on 18/02/2020.
//  Copyright © 2020 COMPANY_NAME. All rights reserved.
//

import UIKit

var onAlertDismissedHandler: (() -> ())?

public extension UIAlertController {
    
    /// Shows an alert dialog with title and message and returns a block upon alert dismissed
    /// - Parameters:
    ///   - title: Title of the alert
    ///   - message: Message content of the alert
    ///   - senderVC: UIViewController which calls this dialog
    ///   - onAlertDismissed: Block that returns after alert is dismissed
    func showAlertDialog(title: String, message: String, senderVC: UIViewController, onAlertDismissed: (() -> Void)?) {
        onAlertDismissedHandler = onAlertDismissed
        
        let alertVC = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        
        let dismissAlertAction = UIAlertAction.init(title: "Dismiss".localized(), style: .cancel) { (action) in
            onAlertDismissedHandler?()
        }
        
        alertVC.addAction(dismissAlertAction)
        
        senderVC.present(alertVC, animated: true, completion: nil)
    }
    
    /// Shows a confirmation dialog with preset Cancel and Ok button and returns block upon user selection
    /// - Parameters:
    ///   - title: Title of the dialog
    ///   - message: Message of the dialog
    ///   - senderVC: UIViewController which calls this dialog
    ///   - onConfirm: Block that returns after user selection
    func showConfirmDialog(title: String, message: String, senderVC: UIViewController, onConfirm: @escaping (_ isOKTapped: Bool) -> Void) {
        self.showCustomConfirmDialog(title: title, message: message, submitButtonTitle: "Ok".localized(), senderVC: senderVC, onConfirm: onConfirm)
    }
    
    /// Shows a confirmation dialog with preset Cancel but with custom submit button title and returns block upon user selection
    /// - Parameters:
    ///   - title: Title of the dialog
    ///   - message: Message of the dialog
    ///   - submitButtonTitle: Title of the submit button
    ///   - senderVC: UIViewController which calls this dialog
    ///   - onConfirm: Block that returns after user selection
    func showCustomConfirmDialog(title: String, message: String, submitButtonTitle: String, senderVC: UIViewController, onConfirm: @escaping (_ isOKTrapped:Bool) -> Void) {
        let alertVC = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        
        let cancelAlertAction = UIAlertAction.init(title: "Cancel".localized(), style: .cancel) { (action) in
            onConfirm(false)
        }
        let submitAlertAction = UIAlertAction.init(title: submitButtonTitle, style: .default) { (action) in
            onConfirm(true)
        }
        
        alertVC.addAction(cancelAlertAction)
        alertVC.addAction(submitAlertAction)
        
        senderVC.present(alertVC, animated: true, completion: nil)
    }
    
    /// Shows an action sheet with options and returns a block with selected index upon option selected
    /// - Parameters:
    ///   - title: Title of this action sheet
    ///   - message: Message of this action sheet
    ///   - optionsArray: Options which you want to be displayed
    ///   - senderVC: UIViewController which calls this action sheet
    ///   - onOptionTapped: Blockthat returns after action selected with index
    func showActionSheet(title: String, message: String, optionsArray: [String], senderVC: UIViewController, onOptionTapped: @escaping (_ tappedIndex: Int, _ isCancel: Bool) -> Void) {
        
        let alertVC = UIAlertController.init(title: title, message: message, preferredStyle: .actionSheet)
        
        for str in optionsArray {
            alertVC.addAction(UIAlertAction(title: str, style: .default, handler: { (_) in
                onOptionTapped(optionsArray.firstIndex(of: str) ?? 0, false)
            }))
        }
        
        alertVC.addAction(UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: { (_) in
            onOptionTapped(-1, true)
        }))
        
        senderVC.present(alertVC, animated: true, completion: nil)
    }
}
