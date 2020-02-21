# swift-boilerplate

A boilerplate code template to kick start and accelerate Swift development in Xcode.

## Requirement
Items below are required before you can use this boilerplate.
1. Xcode 11 and above (This boilerplate is created using Xcode 11)
2. Cocoapods (Refer [here](https://cocoapods.org/) on how to install)
3. Supports iOS 11 and above (Does not support SwiftUI or iPadOS Multi-window, here's the [reason](https://fluffy.es/allow-app-created-in-xcode-11-to-run-on-ios-12-and-lower/) why)

## Installation
1. Clone the project
2. Open terminal and navigate to the directory where you clone this project
3. Enter as below to install pod dependencies (Assuming you already have cocoapods installed)

```bash
pod install
```
4. Launch Xcode and open the project via workspace
```
swift-boilerplate.xcworkspace
```
5. And you're good to go.

## Architecture

## App Language
In-App localization is included in this boilerplate using Localize-Swift library. To add more language, just go to PROJECT > INFO > LOCALIZATION and click on + to add language. Then proceed to Localizable.strings and add your localize strings for each language you want to translate.

You can also use the genstrings.swift to auto-generate strings that needs to be translated throughout your app. Just run below code on your project root folder in your terminal and any strings that have .localized will be generated on the terminal where you can just copy and paste into your Localizable.strings and add translation.

```
./genstrings.swift
```
## Constants
In this boilerplate, case-less enum is used to create constants for such as colors, configs for your app or even keys for your values in UserDefault or Keychain. Enum for Colors as below.

```
enum Colors {
    static let primaryColor:UIColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
    static let secondaryColor:UIColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
    
    static let headerBarColor:UIColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
    
    static let backgroundColor:UIColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
}
```

Usage is as below example

```
Colors.primaryColor
```

## Extensions
Extensions add new functionality to an existing class, structure, enumeration, or protocol type. This includes the ability to extend types for which you do not have access to the original source code (known as retroactive modeling).

In this boilerplate, few extensions has been added in below classes

1. UIDevice (UIDevice_Extension.swift) 
	- Get device model code mapped to it's model name. Eg. "iPhone12,3" mapped to as "iPhone 11 Pro".
	- Get device ID with persistent from keychain.
	- Get device OS with "iOS" prefix. Eg. "iOS 13.3"

2. UIAlertController (UIAlertController_Extension.swift)
	- showAlertDialog, shows an alert dialog with title, message and a closure when alert is dismissed.
	- showConfirmDialog, shows a confirmation dialog with title, message and a completion block for handling convenience.
	- showCustomConfirmDialog, shows a confirmation dialog with modifiable submit button title.

Adding more extension soon...

## Permissions
In iOS, apps require user's permission to grant access to certain device's feature such as camera, photo library, location services and etc. In this boilerplate, PermissionManager is added and can handle all permission checking in one singleton. Below are few sample of how to call for permission checking.

Camera / Video

```
PermissionManager.shared.checkCameraAccess(senderVC: self) { (isGranted) in
	//Do something after permission checking
}
```

Photo Library Access

```
PermissionManager.shared.checkPhotoLibraryAccess(senderVC: self) { (isGranted) in
	//Do something after permission checking
}
```

More samples of permission checking can be found in the project.

## Libraries
Common used third party libraries are included in this boilerplate

1. [DateTools](https://github.com/MatthewYork/DateTools) - Convenient way to format or modify your dates
2. [SVProgressHUD](https://github.com/SVProgressHUD/SVProgressHUD) - Clean and easy-to-use HUD meant to display the progress of an ongoing task
3. [Localize-Swift](https://github.com/marmelroy/Localize-Swift) - Localization made easy with this library, able to generate list of strings found in your project which need to be localized

## Analytics
One of the commonly used to collect app's analytics and crash reports is Firebase. It is free and provides detailed information about crashes or memory leaks with insights on common issues with solutions on how to solve them.
Follow the instructions [here](https://firebase.google.com/docs/ios/setup?authuser=0) to add firebase into your iOS app.

## Contributing
Feel free to contribute to this boilerplate if you have better approach or practices. Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License
[MIT](https://choosealicense.com/licenses/mit/)