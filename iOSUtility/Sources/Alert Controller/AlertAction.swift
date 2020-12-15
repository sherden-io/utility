//
//  AlertAction.swift
//  Utility_tests
//
//  Created by Gandolfi, Pietro External on 15.12.20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

/// An action that can be taken when the user taps a button in an alert.
///
/// You use this class to configure information about a single action, including the title to display in the button,
/// any styling information, and a handler to execute when the user taps the button. After creating an alert action object,
/// add it to a `AlertController` object before displaying the corresponding alert to the User.
///
final class AlertAction: NSObject {

    /// Create and return an `AlertAction` with the specified title and behavior..
    /// - Parameters:
    ///     - title: A localized string that represents the title of the action’s button.
    ///     - style: The style that is applied to the action’s button.
    ///     - handler: A block to execute when the user selects the action. This block has no return value and takes the selected action object as its only parameter.
    /// - Returns: A newly initialized `AlertAction` object.
    ///
    init(title: String?, style: AlertActionStyle = .default, handler: ((AlertAction) -> Swift.Void)? = nil) {
        self.title = title
        self.style = style
        self.handler = handler
        self.isEnabled = true
    }

    /// A localized string that represents the title of the action’s button.
    ///
    private(set) var title: String?

    /// The style that is applied to the action’s button.
    ///
    private(set) var style: AlertActionStyle

    /// A block to execute when the user selects the action. This block has no return value and takes the selected action object as its only parameter.
    ///
    private(set) var handler: ((AlertAction) -> Swift.Void)?

    /// It indicates whether the action is enabled or not.
    /// If an action is not enabled it will be rendered in a dimmed fashion and no touch events will be detected.
    ///
    var isEnabled: Bool
}
