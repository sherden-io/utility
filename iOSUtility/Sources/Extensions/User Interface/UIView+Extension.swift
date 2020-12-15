//
//  UIView+Extension.swift
//  Utility_Tests
//
//  Created by Gandolfi, Pietro on 14.12.20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

extension UIView {

    // MARK: - Custom UIStackView bordered elements

    /// It represents a stack view element.
    ///
    /// - midTop: A mid top element.
    enum StackViewElement {
        /// A mid top element.
        case midTop
    }

    /// Lays out the border for a `StackViewElement`
    ///
    /// - Parameters:
    ///   - element: The element on which to layout a border.
    ///   - thickness: The thickness of the border.
    ///   - color: The color of the border.
    func layoutBorderForElement(_ element: StackViewElement, withThickness thickness: CGFloat, andColor color: UIColor) {
        switch element {
        case .midTop:
            addViewBackedBottomBorderWithHeight(thickness, andColor: color)

        }
    }

    /// Add a view representing a border at the top border.
    ///
    /// - Parameters:
    ///   - height: The height of the view
    ///   - color: The color of the border.
    func addViewBackedTopBorderWithHeight(_ height: CGFloat, andColor color: UIColor) {
        self.addViewBackedTopBorderWithHeight(height, color: color, leftOffset: 0, rightOffset: 0, topOffset: 0)
    }
    
    /// Finds the first receiver's superview of the given type.
    /// - Parameter conformance: The class to match with. A superview is said to match if it is an instance of the given class or of any of its subclasses.
    /// - Returns: The first found superview of the receiver that matches the given `conformance` (or nil).
    ///
    func superviewOfKind<T>(_ conformance: T.Type) -> T? {
        guard let superview = self.superview else {
            return nil
        }
        if let conformant = superview as? T {
            return conformant
        } else {
            return superview.superviewOfKind(conformance)
        }
    }

    /// Finds all the receiver's subviews of the given type.
    /// - Parameter conformance: The class to match with. A subview is said to match if it is an instance of the given class or of any of its subclasses.
    /// - Returns: An array (eventually empty) with all the receiver's subviews of the receiver that matches the given `conformance`.
    ///
    func subviewsOfKind<T>(_ conformance: T.Type) -> [T] {
        var results: [T] = []
        for subview in self.subviews {
            if let conformant = subview as? T {
                results.append(conformant)
            }
            results.append(contentsOf: subview.subviewsOfKind(conformance))
        }
        return results
    }

    /// Finds the next "sibling" of the receiver in the view hierarchy,
    /// i.e. that view that lays in `.superview.subviews[n+1]` where `n` is the position of the receiver.
    /// - Returns: The next sibling (or nil).
    ///
    func nextSibling() -> UIView? {
        guard let superview = self.superview else {
            return nil
        }
        let index = superview.subviews.firstIndex(of: self)! + 1
        guard index < superview.subviews.count else {
            return nil
        }
        return superview.subviews[index]
    }

    /// Adds "vibration" behaviour to the receiver, i.e. makes it rapidly swinging left/right for a small amount of time.
    /// - Parameter completion: a code block to be executed when animation terminates.
    ///
    func vibrate(completion: (() -> Swift.Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        let amplitude: CGFloat = 10
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - amplitude, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + amplitude, y: self.center.y))
        self.layer.add(animation, forKey: "position")
        CATransaction.commit()
    }

    /// Set border UIView with the following settings.
    ///
    func paleGreyThreeBorder() {
        self.layer.borderColor = UIColor.paleGreyThree.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 6.0
    }
    
    /// Add a view representing a border at the bottom border.
    ///
    /// - Parameters:
    ///   - height: The height of the view
    ///   - color: The color of the border.
    func addViewBackedBottomBorderWithHeight(_ height: CGFloat, andColor color: UIColor) {
        self.addViewBackedBottomBorderWithHeight(height, color: color, leftOffset: 0, rightOffset: 0, bottomOffset: 0)
    }
    
    // MARK: - Private

    private func createViewBackedTopBorderWithHeight(_ height: CGFloat,
                                                     color: UIColor,
                                                     leftOffset: CGFloat,
                                                     rightOffset: CGFloat,
                                                     topOffset: CGFloat) -> UIView {

        let border = self.getViewBackedOneSidedBorderWithFrame(
            CGRect(x: 0 + leftOffset,
                   y: 0 + topOffset,
                   width: self.frame.size.width - leftOffset - rightOffset,
                   height: height),
            andColor: color)
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]

        return border

    }

    private func addViewBackedTopBorderWithHeight(_ height: CGFloat,
                                                  color: UIColor,
                                                  leftOffset: CGFloat,
                                                  rightOffset: CGFloat,
                                                  topOffset: CGFloat) {

        let border = self.createViewBackedTopBorderWithHeight(height,
                                                              color: color,
                                                              leftOffset: leftOffset,
                                                              rightOffset: rightOffset,
                                                              topOffset: topOffset)
        self.addSubview(border)
    }
    
    /// Create a UIView bottom + offset.
    /// - Parameters:
    ///   - height: desired height for the view.
    ///   - color: desired color for the view.
    ///   - leftOffset: desired left off-set for the view.
    ///   - rightOffset: desired right off-set for the view.
    ///   - bottomOffset: desired bottom off-set for the view.
    /// - Returns: a customized UIView with specified parameters.
    private func createViewBackedBottomBorderWithHeight(_ height: CGFloat,
                                                        color: UIColor,
                                                        leftOffset: CGFloat,
                                                        rightOffset: CGFloat,
                                                        bottomOffset: CGFloat) -> UIView {

        let border = self.getViewBackedOneSidedBorderWithFrame(CGRect(x: 0 + leftOffset,
                                                                      y: self.frame.size.height-height-bottomOffset,
                                                                      width: self.frame.size.width - leftOffset - rightOffset,
                                                                      height: height),
                                                               andColor: color)
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]

        return border
    }
    
    /// Add a UIView bottom + offset.
    /// - Parameters:
    ///   - height: <#height description#>
    ///   - color: <#color description#>
    ///   - leftOffset: <#leftOffset description#>
    ///   - rightOffset: <#rightOffset description#>
    ///   - bottomOffset: <#bottomOffset description#>
    private func addViewBackedBottomBorderWithHeight(_ height: CGFloat,
                                                     color: UIColor,
                                                     leftOffset: CGFloat,
                                                     rightOffset: CGFloat,
                                                     bottomOffset: CGFloat) {

        let border = self.createViewBackedBottomBorderWithHeight(height,
                                                                 color: color,
                                                                 leftOffset: leftOffset,
                                                                 rightOffset: rightOffset,
                                                                 bottomOffset: bottomOffset)
        self.addSubview(border)
    }
    
    /// Get a `UIView` border frame.
    /// - Parameters:
    ///   - frame: <#frame description#>
    ///   - color: <#color description#>
    /// - Returns: <#description#>
    private func getViewBackedOneSidedBorderWithFrame(_ frame: CGRect, andColor color: UIColor) -> UIView {
        let border = UIView(frame: frame)
        border.translatesAutoresizingMaskIntoConstraints = false
        border.layer.backgroundColor = color.cgColor

        return border
    }
}
