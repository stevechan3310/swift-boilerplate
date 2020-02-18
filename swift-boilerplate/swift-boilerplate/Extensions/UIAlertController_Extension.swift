//
//  UIAlertController_Extension.swift
//  swift-boilerplate
//
//  Created by Steve Chan on 18/02/2020.
//  Copyright © 2020 COMPANY_NAME. All rights reserved.
//

import UIKit

public extension UIAlertController {
    func showConfirmDialog(title: String, message: String, senderVC: UIViewController, onConfirm: @escaping (_ isOKTapped: Bool) -> Void) {
        let alertVC = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        
        let cancelAlertAction = UIAlertAction.init(title: "Cancel".localized(), style: .cancel) { (action) in
            onConfirm(false)
        }
        let submitAlertAction = UIAlertAction.init(title: "Ok".localized(), style: .default) { (action) in
            onConfirm(true)
        }
        
        alertVC.addAction(cancelAlertAction)
        alertVC.addAction(submitAlertAction)
        
        senderVC.present(alertVC, animated: true, completion: nil)
    }
}
