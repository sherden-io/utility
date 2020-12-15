//
//  UIDevice+Extension.swift
//  Utility_Tests
//
//  Created by Gandolfi, Pietro on 14.12.20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

/// This extension adds functionalities to the `UIDevice` class that are widely used through the App.
///
extension UIDevice {

    /// Defines the possibile size categories.
    /// You may use this enum when you need to customize some graphics or behaviour based on the "kind" of the device, not its detailed model.
    ///
    /// - unkown: ?...
    /// - small: (320x568) iPhone 5, SE, ...
    /// - normal: (375x667) iPhone 6, 7, 8, ...
    /// - tall: (375x812) iPhone X, ...
    /// - wide: (414x736) iPhone 6+, 7+, 8+, ...
    /// - huge: (768x1024) iPad
    public enum ScreenSize {
        /// ...?
        case unkown
        
        /// (320x568) iPhone 5, SE, ...
        case small
        
        /// (375x667) iPhone 6, 7, 8, ...
        case normal
        
        /// (375x812) iPhone X, ...
        case tall
        
        /// (414x736) iPhone 6+, 7+, 8+, ...
        case wide
        
        /// (768x1024) iPad
        case huge
    }

    /// Computes the screen size category.
    /// - Parameter window: The size (WxH) of the given `UIWindow` will determine the result. Defaults to `UIApplication.shared.keyWindow`.
    /// - Returns: The `ScreenSize` computed based on the `window` frame.
    ///
    public func screenSize(window: UIWindow? = UIApplication.shared.windows.first) -> ScreenSize {
        guard let window = window else {
            return .unkown
        }
        let width = min(window.frame.size.width, window.frame.size.height)
        let height = max(window.frame.size.width, window.frame.size.height)
        switch width {
        case 0 ... 320:
            return .small
        case 321 ... 400:
            switch height {
            case 0 ... 800:
                return .normal
            default:
                return .tall
            }
        case 401 ... 700:
            return .wide
        default:
            return .huge
        }
    }

}
