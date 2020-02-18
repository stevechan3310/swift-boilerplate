//
//  Constants.swift
//  swift-boilerplate
//
//  Created by Steve Chan on 2/13/20.
//  Copyright © 2020 COMPANY_NAME. All rights reserved.
//

import Foundation
import UIKit

/// App configuration
enum Config {
    static let backendVersion:NSString = "8"
    
    /// Environment
    enum env {
        static let PROD:NSString = "https://production.com/"
        static let UAT:NSString = "https://uat.com/"
        static let SIT:NSString = "https://sit.com/"
    }
}

/// Enum for color used in the app
enum Colors {
    static let primaryColor:UIColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
    static let secondaryColor:UIColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
    
    static let headerBarColor:UIColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
    
    static let backgroundColor:UIColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
}

/// Information related to the device using this app
enum DeviceInfo {
    static let modelName:String = UIDevice.modelName
    static let OS:String = UIDevice.OS
    static let UUID:String = UIDevice.UUID
}

/// Constants of keys for values
enum Keys {
    enum keychain {
        static let deviceUUID:String = "KEY_KEYCHAIN_DEVICEUUID"
    }
    
    enum userDefault {
        
    }
}
