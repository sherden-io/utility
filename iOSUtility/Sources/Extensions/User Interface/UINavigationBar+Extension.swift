//
//  UINavigationBar+Extension.swift
//  Utility_Tests
//
//  Created by Gandolfi, Pietro on 14.12.20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

/// This extension adds functionalities to the `UINavigationBar` class that are widely used through the App.
///
extension UINavigationBar {

    /// Applies a gradient background with the given colors.
    /// - Parameter colors: A non-empty array of `UIColor` objects for the gradient.
    ///
    func apply(gradient colors: [UIColor]) {
        var frameAndStatusBar: CGRect = self.bounds
        frameAndStatusBar.size.height += 20 // add 20px to account for the status bar

        setBackgroundImage(UINavigationBar.gradient(size: frameAndStatusBar.size, colors: colors), for: .default)
    }

    /// Creates a gradient image with the given settings.
    /// - Parameter size: The `size` of the resulting image.
    /// - Parameter colors: A non-empty array of `UIColor` objects for the gradient.
    /// - Returns: an `UIImage` drawn with the defined gradient colors.
    ///
    static func gradient(size: CGSize, colors: [UIColor]) -> UIImage? {
        // Turn the colors into CGColors
        let cgColors = colors.map { $0.cgColor }

        // Begin the graphics context
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)

        // If no context was retrieved, then it failed
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }

        // From now on, the context gets ended if any return happens
        defer {
            UIGraphicsEndImageContext()
        }

        // Create the Coregraphics gradient
        var locations: [CGFloat] = [0.0, 1.0]
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                        colors: cgColors as CFArray,
                                        locations: &locations) else {
            return nil
        }

        // Draw the gradient
        context.drawLinearGradient(gradient, start: CGPoint(x: 0.0, y: 0.0), end: CGPoint(x: size.width, y: 0.0), options: [])

        // Generate the image (the defer takes care of closing the context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
