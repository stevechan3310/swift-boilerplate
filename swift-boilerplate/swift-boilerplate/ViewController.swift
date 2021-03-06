//
//  ViewController.swift
//  swift-boilerplate
//
//  Created by Steve Chan on 12/19/19.
//  Copyright © 2019 COMPANY_NAME. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnLanguage: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    // MARK: UIButton Action
    @IBAction func inAppLocalizationDemo(_ sender: Any) {
        self.performSegue(withIdentifier: "segue_to_inapplocalizationdemo", sender: self)
    }
    
    @IBAction func getDeviceInfo(_ sender: Any) {
        UIAlertController().showConfirmDialog(title: "DEVICE INFO".localized(), message: String.init(format: "Device ID: %@\nDevice Model: %@\nDevice OS: %@", DeviceInfo.UUID, DeviceInfo.modelName, DeviceInfo.OS), senderVC: self) { (isOkTapped) in
            print("Is OK button tapped - ", isOkTapped ? "Yes" : "No")
        }
    }
    
    @IBAction func checkPermission(_ sender: Any) {
        let optionsArray = ["Camera / Video",
                            "Photo Library",
                            "Location Services"]
        
        UIAlertController().showActionSheet(title: "Check Permission", message: "Choose a permission to check", optionsArray: optionsArray, senderVC: self) { (selectedIndex, isCancel) in
            switch (selectedIndex) {
            case 0:
                PermissionManager.shared.checkCameraAccess(senderVC: self) { (isGranted) in
                    UIAlertController().showAlertDialog(title: "Camera Access", message: String.init(format: "Permission for camera is %@", isGranted ? "granted" : "denied"), senderVC: self, onAlertDismissed: nil)
                }
            case 1:
                PermissionManager.shared.checkPhotoLibraryAccess(senderVC: self) { (isGranted) in
                    UIAlertController().showAlertDialog(title: "Photo Library Access", message: String.init(format: "Permission for photo library is %@", isGranted ? "granted" : "denied"), senderVC: self, onAlertDismissed: nil)
                }
            case 2:
                PermissionManager.shared.checkLocationAccess(accessType: .WhenInUse, senderVC: self) { (isGranted) in
                    UIAlertController().showAlertDialog(title: "Photo Library Access", message: String.init(format: "Permission for photo library is %@", isGranted ? "granted" : "denied"), senderVC: self, onAlertDismissed: nil)
                }
            default:
                print("Cancelled")
            }
        }
    }
    
    @IBAction func biometricAuthentication(_ sender: Any) {
        //Test on biometric authentication
        UIAlertController().showActionSheet(title: "Biometric Authentication", message: "Choose an option", optionsArray: ["Check Biometric Type", "Perform Biometric Authentication"], senderVC: self) { (index, isCancel) in
            switch index {
            case 0:
                var biometricType: String = ""
                
                switch BiometricManager.shared.checkSupportedBiometricType() {
                case .FaceID:
                    biometricType = "Face ID"
                case .TouchID:
                    biometricType = "Touch ID"
                default:
                    biometricType = "None"
                }
                
                UIAlertController().showAlertDialog(title: "Biometric Type", message: biometricType, senderVC: self, onAlertDismissed: nil)
            case 1:
                BiometricManager.shared.performAuthentication(senderVC: self) { (isAuthenticated, biometricType, errorMessage) in
                    NSLog("Authenticated: %@, Biometric Type: %@", isAuthenticated ? "success" : "failed", biometricType == .faceID ? "Face ID" : biometricType == .touchID ? "Touch ID" : "NONE")
                    if (isAuthenticated) {
                        UIAlertController().showAlertDialog(title: "Biometric Authentication".localized(), message: "Successful".localized(), senderVC: self) {

                        }
                    } else {
                        UIAlertController().showAlertDialog(title: "Biometric Authentication".localized(), message: errorMessage, senderVC: self) {

                        }
                    }
                }
            default:
                print("")
            }
        }
    }
}

