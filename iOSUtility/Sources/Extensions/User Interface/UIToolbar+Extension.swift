//
//  UIToolbar+Extension.swift
//  Utility_Tests
//
//  Created by Gandolfi, Pietro on 14.12.20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

/// This extension adds functionalities to the `UIToolbar` class that are widely used through the App.
///
extension UIToolbar {

    /// Creates a new instance of `UIToolbar` with a "Done" button to the right.
    /// - Parameter selector: The action to send to target when the "Done" button item is tapped.
    /// - Parameter target: The object that receives the action message.
    /// - Returns: An initialized instance of the `UIToolbar` class.
    ///
    static func toolbarPicker(selector: Selector, target: Any) -> UIToolbar {

        let toolBar = UIToolbar()

        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.darkBlueTwo

        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: target, action: selector)
        doneButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "System", size: 16) as Any], for: .normal)

        toolBar.setItems([spaceButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        toolBar.layoutIfNeeded()

        return toolBar
    }

}
