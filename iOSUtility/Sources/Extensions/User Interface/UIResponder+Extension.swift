//
//  UIResponder+Extension.swift
//  Utility_Tests
//
//  Created by Gandolfi, Pietro on 14.12.20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

extension UIResponder {

    static private weak var __firstResponder: UIResponder?

    /// Find the first responder.
    ///
    /// - Returns: The first responder if found.
    static func firstResponder() -> UIResponder? {
        UIResponder.__firstResponder = nil
        UIApplication.shared.sendAction(#selector(queryFirstResponder(sender:)), to: nil, from: nil, for: nil)
        return UIResponder.__firstResponder
    }

    @objc private func queryFirstResponder(sender: Any?) {
        UIResponder.__firstResponder = self
    }

    /// Recurvise function that traverse the responder chain and finds the firs responder of type *T*.
    ///
    /// - Parameter type: The type to find.
    /// - Returns: An instance of type *T*
    func next<T: UIResponder>(_ type: T.Type) -> T? {
        return next as? T ?? next?.next(type)
    }

}
