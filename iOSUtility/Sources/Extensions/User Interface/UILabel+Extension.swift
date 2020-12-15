//
//  UILabel+Extension.swift
//  Utility_Tests
//
//  Created by Gandolfi, Pietro on 14.12.20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

/// This extension adds functionalities to the `UILabel` class that are widely used through the App.
///
extension UILabel {

    /// Prepares the receiver for the font size being reduced in order to fit the title string into the label’s bounding rectangle.
    /// - Parameter scale: The minimum scale factor supported for the label’s text. Defaults to 0.3.
    ///
    @available(iOS 10.0, *)
    func autoscale(_ scale: CGFloat = 0.3) {
        self.adjustsFontSizeToFitWidth = true
        self.adjustsFontForContentSizeCategory = true
        self.lineBreakMode = .byClipping
        self.minimumScaleFactor = scale
    }

    /// Computes the minimum height required to correctly draw the label, given the available `width`.
    /// - Parameter width: The available width for the receiver.
    /// - Returns: The the minimum height required to correctly draw the label.
    ///
    func minimumHeight(forWidth width: CGFloat) -> CGFloat {
        let bounds = CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude)
        let textRect = self.textRect(forBounds: bounds, limitedToNumberOfLines: self.numberOfLines)
        return textRect.size.height
    }

}
