//
//  PermissionManager.swift
//  swift-boilerplate
//
//  Created by Steve Chan on 19/02/2020.
//  Copyright © 2020 COMPANY_NAME. All rights reserved.
//

import Foundation
import AVFoundation
import Photos
import UIKit

class PermissionManager
{
    static let shared = PermissionManager()

    private init()
    {
        // Set up API instance
    }
    
    /// Checks for camera access permission
    /// - Parameters:
    ///   - senderVC: UIViewController that calls this checking
    ///   - handler: Block handler that returns after permission checking
    func checkCameraAccess(senderVC: UIViewController, handler: @escaping (_ isGranted:Bool) -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .denied:
            print("Denied, request permission from settings")
            UIAlertController().showCustomConfirmDialog(title: "ERROR".localized(), message: "This app requires your permission to access camera".localized(), submitButtonTitle: "Settings", senderVC: senderVC) { (isGoSettings) in
                if (isGoSettings) {
                    //Navigate to app's privacy settings to grant access to camera
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url, options: [:], completionHandler: { _ in
                            
                        })
                    }
                } else {
                    handler(false)
                }
            }
        case .restricted:
            print("Restricted, device owner must approve")
            handler(false)
        case .authorized:
            print("Authorized, proceed")
            handler(true)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { success in
                DispatchQueue.main.async {
                    if success {
                        print("Permission granted, proceed")
                        handler(true)
                    } else {
                        print("Permission denied")
                        handler(false)
                    }
                }
            }
        default :
            print("Unable to determine permission. Unknown error")
            handler(false)
        }
    }

    /// Checks for Photo Library access permission
    /// - Parameters:
    ///   - senderVC: UIViewController which call this checking
    ///   - handler: Block handler that returns after perform checking
    func checkPhotoLibraryAccess(senderVC: UIViewController, handler: @escaping (_ isGranted:Bool) -> Void) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            print("Authorized, proceed")
            handler(true)
        case .restricted :
            print("Restricted, device owner must approve")
            handler(false)
        case .denied :
           UIAlertController().showCustomConfirmDialog(title: "ERROR".localized(), message: "This app requires your permission to access photo library".localized(), submitButtonTitle: "Settings", senderVC: senderVC) { (isGoSettings) in
                if (isGoSettings) {
                    //Navigate to app's privacy settings to grant access to photo library
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url, options: [:], completionHandler: { _ in
                            
                        })
                    }
                } else {
                    handler(false)
                }
            }
        case .notDetermined:
            // ask for permissions
            PHPhotoLibrary.requestAuthorization { status in
                DispatchQueue.main.async {
                    switch status {
                    case .authorized:
                        handler(true)
                    default :
                        handler(false)
                    }
                }
            }
        default :
            print("Unable to determine permission. Unknown error")
            handler(false)
        }
    }
}
