//
//  AlertPresenting.swift
//  Utility_Tests
//
//  Created by Gandolfi, Pietro on 14.12.20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

/// It defines methods to presenting alert and toast views into the App.
protocol AlertPresenting {
    
    /// Gets or sets alert presenting protocol.
    var alertPresenter: AlertPresenting { get set }

    /// Shows a toast message.
    ///
    /// - Parameters:
    ///   - icon: The icon of the toast.
    ///   - title: The title of the toast.
    ///   - message: The message of the toast.
    ///   - duration: The duration of the toast.
    ///   - action: A callback function called when action is tapped.
    ///   - dismissed: A callback function called when dismiss is tapped.
    func showToast(
        icon: UIImage?,
        title: String,
        message: String,
        duration: TimeInterval?,
        action: AlertAction?,
        dismissed: (() -> Void)?
    )

    /// Shows an acknowledge alert with a single option.
    ///
    /// - Parameters:
    ///   - priority: The alert priority.
    ///   - title: The title of the alert.
    ///   - message: The message of the alert.
    ///   - buttonText: The text of the button.
    ///   - dismissed: A callback function called after the User acknowledgment.
    func showAcknowledgeAlert(
        priority: AlertPriority,
        title: String,
        message: String,
        buttonText: String,
        dismissed: (() -> Void)?
    )

    /// Shows an alert with two options, one primary and one secondary.
    ///
    /// - Parameters:
    ///   - priority: The priority of the alert.
    ///   - title: The title of the alert.
    ///   - subtitle: The subtitle of the alert.
    ///   - message: The message of the alert.
    ///   - primaryText: The text of the primary button.
    ///   - secondaryText: The text of the secondary button.
    ///   - continued: A callback function called when User decides to choose primary option.
    ///   - dismissed: A callback function called when User decides to choose secondary option.
    func showPrimaryAndSecondaryOptionAlert(
        priority: AlertPriority,
        title: String,
        subtitle: String?,
        message: String,
        primaryText: String,
        secondaryText: String,
        continued: @escaping () -> Void,
        dismissed: (() -> Void)?
    )

    /// Shows an alert with two primary options.
    ///
    /// - Parameters:
    ///   - priority: The alert priority.
    ///   - title: The alert title.
    ///   - subtitle: The alert subtitle.
    ///   - message: The message of the alert.
    ///   - actions:  An optional list of primary actions to choose, if provided the dismissed block will never be executed.
    ///   - dismissed: A callback function called when User decides to choose secondary option.
    func showDualPrimaryOptionAlert(
        priority: AlertPriority,
        title: String,
        subtitle: String?,
        message: String,
        actions: [AlertAction]?,
        dismissed: (() -> Void)?
    )

    /// Presents a view controller modally.
    /// This function behaves very much like `present(viewControllerToPresent:,animated:,completion:)`
    /// but it manages the following common situations:
    /// - if the receveiver is already presenting another view controller,
    ///   the operation is automatically retried in the next run cycle.
    /// - if the receveiver view has not yet been loaded, the operation is automatically retried in the next run cycle.
    /// - if the receiver is currently animating the presentation of another view controller,
    ///   the operation is automatically retried in the next run cycle.
    /// - Parameters:
    ///     - viewControllerToPresent: The view controller to display over the current view controller’s content.
    ///     - animated: Pass true to animate the presentation; otherwise, pass false.
    ///     - completion: The block to execute after the presentation finishes.
    ///       This block has no return value and takes no parameters. You may specify nil for this parameter.
    func safePresent(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Swift.Void)?)
}
