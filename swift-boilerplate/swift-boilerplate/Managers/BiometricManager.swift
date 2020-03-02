//
//  BiometricManager.swift
//  swift-boilerplate
//
//  Created by Steve Chan on 28/02/2020.
//  Copyright © 2020 COMPANY_NAME. All rights reserved.
//

import Foundation
import UIKit
import LocalAuthentication

enum BiometricType {
    case FaceID
    case TouchID
    case NONE
}

class BiometricManager {
    static let shared = BiometricManager()
    
    private init() {
        //Initialization methods here
        
    }
    
    /// Check what type of biometric is supported in this device
    func checkSupportedBiometricType() -> BiometricType {
        let authContext = LAContext()
        let _ = authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        switch(authContext.biometryType) {
        case .touchID:
            return .TouchID
        case .faceID:
            return .FaceID
        default :
            return .NONE
        }
    }
    
    /// Perform Biometric Authentication
    /// - Parameters:
    ///   - senderVC: UIViewController that calls this
    ///   - onAuthenticated: Block that returns upon authentication completes with result
    func performAuthentication(senderVC: UIViewController, onAuthenticated: @escaping (_ isAuthenticated: Bool, _ biometricType: LABiometryType, _ errorMessage: String) -> Void) {
        let localAuthenticationContext = LAContext()
        localAuthenticationContext.localizedFallbackTitle = "Authentication failed, please use your passcode".localized()

        var authorizationError: NSError?
        let reason = "Authentication is required to access".localized()

        if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authorizationError) {
            
            localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, evaluateError in
                
                if success {
                    DispatchQueue.main.async() {
                        onAuthenticated(true, localAuthenticationContext.biometryType, "")
                    }
                } else {
                    // Failed to authenticate
                    var errorDesc = ""
                    if let error = evaluateError as? LAError {
                        errorDesc = self.getErrorDescFromLAErrorCode(laErrorCode: error.code)
                    }
                    
                    print(errorDesc)
                    
                    DispatchQueue.main.async {
                        onAuthenticated(false, localAuthenticationContext.biometryType, errorDesc)
                    }
                }
            }
        } else {
            var errorDesc = ""
            if let error = authorizationError {
                errorDesc = error.localizedDescription
            }
            
            print(errorDesc)
            
            DispatchQueue.main.async {
                onAuthenticated(false, localAuthenticationContext.biometryType, errorDesc)
            }
        }
    }
    
    /// Maps LAErrorCode into meaningful error description
    /// - Parameter laErrorCode: LAErrorCode returned upon evaluation
    func getErrorDescFromLAErrorCode(laErrorCode: LAError.Code) -> String {
        switch laErrorCode {
        case .appCancel:
            return "The app canceled authentication.".localized()
        case .authenticationFailed:
            return "The user failed to provide valid credentials.".localized()
        case .invalidContext:
            return "The context was previously invalidated.".localized()
        case .notInteractive:
            return "Displaying the required authentication user interface is forbidden.".localized()
        case .passcodeNotSet:
            return "A passcode isn’t set on the device.".localized()
        case .systemCancel:
            return "The system canceled authentication.".localized()
        case .userCancel:
            return "The user tapped the cancel button in the authentication dialog.".localized()
        case .userFallback:
            return "The user tapped the fallback button in the authentication dialog, but no fallback is available for the authentication policy.".localized()
        case .biometryLockout:
            return "Biometry is locked because there were too many failed attempts.".localized()
        case .biometryNotAvailable:
            return "Biometry is not available on the device.".localized()
        case .biometryNotEnrolled:
            return "The user has no enrolled biometric identities.".localized()
        default:
            return "Authentication failed with unknown reason."
        }
    }
}
