//
//  UITextField+Extension.swift
//  Utility_Tests
//
//  Created by Gandolfi, Pietro on 14.12.20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

extension UITextField {

    /// Adds a left padding to the receiver.
    /// - Parameter padding: The value of the left padding.
    ///
    func setup(padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
