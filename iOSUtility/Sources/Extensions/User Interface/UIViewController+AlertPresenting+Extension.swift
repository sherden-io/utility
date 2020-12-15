//
//  UIViewController+AlertPresenting+Extension.swift
//  Utility_tests
//
//  Created by Gandolfi, Pietro External on 15.12.20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

/// This extension adds `AlertPresenting` protocol functionalities to the `UIViewController` class.
///
extension UIViewController: AlertPresenting {
    
    private static var associatedObjectHandle: UInt8 = 0

    /// Gets or sets alert presenting protocol.
    var alertPresenter: AlertPresenting {
        get {
            let associated = objc_getAssociatedObject(self, &UIViewController.associatedObjectHandle) as? AlertPresenting
            
            if associated != nil {
                return associated!
            } else {
                return self
            }
        }
        
        set {
            objc_setAssociatedObject(self, &UIViewController.associatedObjectHandle, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    /// Shows no network connection alert.
    ///
    /// - Parameters:
    ///   - continued: A callback function called when User decides to choose primary option.
    ///   - dismissed: A callback function called when User decides to choose secondary option.
    func showNoNetworkConnectionAlert(continued: @escaping () -> Void, dismissed: (() -> Void)? = nil) {
        self.alertPresenter.showPrimaryAndSecondaryOptionAlert(
            priority: .low,
            title: "",
            subtitle: nil,
            message: "",
            primaryText: "",
            secondaryText: "",
            continued: continued,
            dismissed: dismissed
        )
    }

    /// Shows notifications off alert.
    ///
    /// - Parameters:
    ///   - continued: A callback function called when User decides to choose primary option.
    ///   - dismissed: A callback function called when User decides to choose secondary option.
    func showNotificationsOffAlert(continued: @escaping () -> Void, dismissed: (() -> Void)? = nil) {
        self.alertPresenter.showPrimaryAndSecondaryOptionAlert(
            priority: .low,
            title: "".localized,
            subtitle: nil,
            message: "".localized,
            primaryText: "".localized,
            secondaryText: "".localized,
            continued: continued,
            dismissed: dismissed
        )
    }

    /// Shows unsupported device or operating system alert.
    ///
    /// - Parameter dismissed: A callback function called when User acknowledge alert.
    func showUnsupportedDeviceAlert(dismissed: (() -> Void)? = nil) {
        self.alertPresenter.showAcknowledgeAlert(priority: .low,
                                 title: "".localized,
                                 message: "".localized,
                                 buttonText: "".localized,
                                 dismissed: dismissed)
    }

    /// Show an alert when User try to change primary device.
    ///
    /// - Parameters:
    ///   - continued: A callback function called when User decides to choose primary option.
    ///   - dismissed: A callback function called when User decides to choose secondary option.
    func showNotPrimaryDeviceAlert(continued: @escaping () -> Void, dismissed: (() -> Void)? = nil) {
        alertPresenter.showPrimaryAndSecondaryOptionAlert(priority: .low,
                                                          title: "".localized,
                                                          subtitle: nil,
                                                          message: "".localized,
                                                          primaryText: "".localized,
                                                          secondaryText: "".localized,
                                                          continued: continued,
                                                          dismissed: dismissed)
    }

    /// Shows unrecoverable error message and logout user from the app
    ///
    /// - Parameter allowed: A number of allowed selectable health factors.
    func showUnrecoverableAlert(error: Error, dismissed: (() -> Void)? = nil) {
        alertPresenter.showAcknowledgeAlert(priority: .low,
                             title: "".localized,
                             message: "".localized,
                             buttonText: "".localized,
                             dismissed: {
                                dismissed?()
                             }
        )
    }

    /// Shows time zone changed alert.
    func showTimezoneChangedAlert() {
        self.alertPresenter.showAcknowledgeAlert(priority: .medium,
                                                 title: "".localized,
                                                 message: "".localized,
                                                 buttonText: "".localized,
                                                 dismissed: nil)
    }

    /// Show an alert when User try to change his email.
    ///
    /// - Parameters:
    ///   - continued: A callback function called when User decides to choose primary option.
    ///   - dismissed: A callback function called when User decides to choose secondary option.
    func showConfirmChangeEmailAlert(continued: @escaping () -> Void, dismissed: (() -> Void)? = nil) {
        let primaryAction = AlertAction.primaryAction(title: "".localized) { _ in
            continued()
        }
        let secondaryAction = AlertAction.primaryAction(title: "".localized) { _ in
            dismissed?()
        }

        alertPresenter.showDualPrimaryOptionAlert(priority: .low,
                                                  title: "".localized,
                                                  subtitle: nil,
                                                  message: "".localized,
                                                  actions: [primaryAction, secondaryAction],
                                                  dismissed: nil)
    }

    /// Shows an alert when a new refresh token is required.
    ///
    /// - Parameters:
    ///   - continued: A callback function called when User decides to choose primary option.
    ///   - dismissed: A callback function called when User decides to choose secondary option.
    func showNewRefreshTokenIsRequiredAlert(continued: @escaping () -> Void, dismissed: (() -> Void)? = nil) {

        alertPresenter.showPrimaryAndSecondaryOptionAlert(priority: .low,
                                                          title: "".localized,
                                                          subtitle: nil,
                                                          message: "".localized,
                                                          primaryText: "".localized,
                                                          secondaryText: "".localized,
                                                          continued: continued,
                                                          dismissed: dismissed)
    }

    /// Shows an acknowledge alert for when an invalid deeplink has been used.
    ///
    /// - Parameters:
    ///   - title: The alert title
    ///   - message: The alert message
    ///   - buttonText: The text of the button.
    ///   - dismissed: A callback function called when User decides to choose secondary option.
    func showDeepLinkErrorAlert(title: String, message: String, buttonText: String, dismissed: (() -> Void)? = nil) {
        var priority = AlertPriority.low
        priority.image = .alertLow
        showAcknowledgeAlert(priority: priority, title: title, message: message, buttonText: buttonText, dismissed: dismissed)
    }

    /// Shows an acknowledge alert for when the User attemps to login with an email not yet verified.
    ///
    /// - Parameter dismissed: A callback function called after the User acknowledgment.
    func showEmailNotValidAlert(dismissed: (() -> Void)? = nil) {
        var priority = AlertPriority.low
        priority.image = .alertLow
        let title = "".localized
        let message = "".localized
        let buttonText = "".localized

        showAcknowledgeAlert(priority: priority, title: title, message: message, buttonText: buttonText, dismissed: dismissed)
    }

    /// Shows an acknowledge alert with a single option.
    ///
    /// - Parameters:
    ///   - priority: The alert priority.
    ///   - title: The title of the alert.
    ///   - message: The message of the alert.
    ///   - buttonText: The text of the button.
    ///   - dismissed: A callback function called after the User acknowledgment.
    func showAcknowledgeAlert(priority: AlertPriority, title: String = "Warning", message: String, buttonText: String = "Continue",
                              dismissed: (() -> Void)? = nil) {

        guard self.alertPresenter as? UIViewController === self else {
            self.alertPresenter.showAcknowledgeAlert(priority: priority,
                                                     title: title,
                                                     message: message,
                                                     buttonText: buttonText,
                                                     dismissed: dismissed)
            return
        }

        let continued = AlertAction.primaryAction(title: buttonText) { _ in
            dismissed?()
        }

        let alert = createAlert(icon: UIImage(named: priority.image.rawValue),
                                      title: title,
                                      message: message,
                                      actions: [continued])

        self.safePresent(alert, animated: true, completion: nil)
    }

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
    func showPrimaryAndSecondaryOptionAlert(priority: AlertPriority,
                                            title: String,
                                            subtitle: String? = "",
                                            message: String,
                                            primaryText: String = "Continue",
                                            secondaryText: String = "Cancel",
                                            continued: @escaping () -> Void,
                                            dismissed: (() -> Void)? = nil) {

        guard self.alertPresenter as? UIViewController === self else {
            self.alertPresenter.showPrimaryAndSecondaryOptionAlert(priority: priority,
                                                                   title: title,
                                                                   subtitle: subtitle,
                                                                   message: message,
                                                                   primaryText: primaryText,
                                                                   secondaryText: secondaryText,
                                                                   continued: continued,
                                                                   dismissed: dismissed)
            return
        }

        let continued = AlertAction.primaryAction(title: primaryText) { _ in
            continued()
        }
        let cancel = AlertAction.secondaryAction(title: secondaryText) { _ in
            dismissed?()
        }

        let alert = createAlert(icon: UIImage(named: priority.image.rawValue),
                                      title: title,
                                      subtitle: subtitle,
                                      message: message,
                                      actions: [cancel, continued],
                                      dismissed: nil)

        self.safePresent(alert, animated: true, completion: nil)
    }

    /// Shows an alert with two primary options.
    ///
    /// - Parameters:
    ///   - priority: The alert priority.
    ///   - title: The alert title.
    ///   - subtitle: The alert subtitle.
    ///   - message: The message of the alert.
    ///   - actions:  An optional list of primary actions to choose, if provided the dismissed block will never be executed.
    ///   - dismissed: A callback function called when User decides to choose secondary option.
    func showDualPrimaryOptionAlert(priority: AlertPriority,
                                    title: String,
                                    subtitle: String? = nil,
                                    message: String,
                                    actions: [AlertAction]? = nil,
                                    dismissed: (() -> Void)? = nil) {

        guard self.alertPresenter as? UIViewController === self else {
            self.alertPresenter.showDualPrimaryOptionAlert(priority: priority,
                                                           title: title, subtitle: subtitle,
                                                           message: message,
                                                           actions: actions,
                                                           dismissed: dismissed)
            return
        }

        let alertController = AlertController(icon: UIImage(named: priority.image.rawValue),
                                                 title: title,
                                                 subtitle: subtitle,
                                                 message: message,
                                                 preferredStyle: .actionSheet)
        if let actions = actions {
            for action in actions {
                alertController.addAction(action)
            }
        } else {
            let action = AlertAction.primaryAction(title: "Continue") { _ in
                dismissed?()
            }
            alertController.addAction(action)
        }

        self.safePresent(alertController, animated: true, completion: nil)
    }

    /// Creates an Alert alert.
    ///
    /// - Parameters:
    ///   - icon: Alert icon.
    ///   - title: Alert title.
    ///   - subtitle: Alert subtitle.
    ///   - message: Alert message.
    ///   - actions: An optional list of primary actions to choose, if provided the dismissed block will never be executed.
    ///   - dismissed: A callback function called when User decides to choose secondary option.
    /// - Returns: A reference to AlertController.
    private func createAlert(icon: UIImage?,
                                title: String,
                                subtitle: String? = nil,
                                message: String,
                                actions: [AlertAction]? = nil,
                                dismissed: (() -> Void)? = nil) -> AlertController {

        let alertController = AlertController(icon: icon,
                                                 title: title,
                                                 subtitle: subtitle,
                                                 message: message,
                                                 preferredStyle: .alert)

        if let actions = actions {
            for action in actions {
                alertController.addAction(action)
            }
        } else {
            let action = AlertAction.primaryAction(title: "Continue") { _ in
                dismissed?()
            }
            alertController.addAction(action)
        }

        return alertController
    }
}
