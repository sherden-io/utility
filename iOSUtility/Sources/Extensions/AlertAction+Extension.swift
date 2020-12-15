//
//  AlertAction+Extension.swift
//  Utility_Tests
//
//  Created by Gandolfi, Pietro on 14.12.20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

extension AlertAction {

    /// Configures the primary action of an alert.
    ///
    /// - Parameters:
    ///   - title: The title of the action.
    ///   - handler: An handler for primary action.
    static func primaryAction(title: String, handler: ((AlertAction) -> Void)? = nil) -> AlertAction {
        return AlertAction(title: title, style: .default, handler: handler)
    }

    /// Configures the secondary action of an alert.
    ///
    /// - Parameters:
    ///   - title: The title of the action.
    ///   - handler: An handler for secondary action.
    static func secondaryAction(title: String, handler: ((AlertAction) -> Void)? = nil) -> AlertAction {
        return AlertAction(title: title, style: .cancel, handler: handler)
    }
}
