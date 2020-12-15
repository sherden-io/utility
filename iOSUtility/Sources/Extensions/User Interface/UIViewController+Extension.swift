//
//  UIViewController+Extension.swift
//  Utility_Tests
//
//  Created by Gandolfi, Pietro on 14.12.20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

/// This extension adds functionalities to the `UIViewController` class that are widely used.
///
extension UIViewController {

    private static var presentingControllers: [UIViewController] = []

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
    func safePresent(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Swift.Void)? = nil) {
        weak var weakSelf = self
        guard self.presentedViewController == nil else {
            // retry immediately in the next run cycle.
            DispatchQueue.main.async {
                weakSelf?.safePresent(viewControllerToPresent, animated: flag, completion: completion)
            }
            return
        }
        guard self.isViewLoaded else {
            // transient condition: avoid the following well known warning:
            // Attempt to present <...> on <...> whose view is not in the window hierarchy!
            // retry immediately in the next run cycle.
            DispatchQueue.main.async {
                weakSelf?.safePresent(viewControllerToPresent, animated: flag, completion: completion)
            }
            return
        }
        guard !UIViewController.presentingControllers.contains(self) else {
            // transient condition: presentation started but not yet completed. retry immediately in the next run cycle.
            DispatchQueue.main.async {
                weakSelf?.safePresent(viewControllerToPresent, animated: flag, completion: completion)
            }
            return
        }
        // not presenting anything: mark presentation "in-fieri", call present() and unmark when done.
        UIViewController.presentingControllers.append(self)
        self.present(viewControllerToPresent, animated: flag) {
            if let index = UIViewController.presentingControllers.firstIndex(of: self) {
                UIViewController.presentingControllers.remove(at: index)
            }
            completion?()
        }
    }

    /// Dismisses an entire view controllers hierarchy that was presented modally by the view controller.
    /// This call dismisses recursively each `presentedViewController` down in the presentation hierarchy before dismissing the receiver.
    /// - Parameter animated: Pass true to animate the transition.
    /// - Parameter completion: The block to execute after the view controller is dismissed. This block has no return value and takes no parameters. You may specify nil for this parameter.
    ///
    func dismissAll(animated: Bool, completion: (() -> Void)? = nil) {
        if self.isBeingPresented {
            DispatchQueue.main.async {
                self.dismissAll(animated: animated, completion: completion)
            }
        }
        if let presentedViewController = self.presentedViewController, presentedViewController.isBeingDismissed == false {
            presentedViewController.view.isUserInteractionEnabled = false
            presentedViewController.dismissAll(animated: animated) {
                presentedViewController.dismiss(animated: animated) {
                    completion?()
                }
            }
        } else {
            completion?()
        }
    }

    /// Dismisses the view controller (if it was presented modally)
    /// or pops all the view controllers on the `navigationController` stack except the root view controller and updates the display
    /// (if it was presented in a `UINavigationController`).
    ///
    func dismiss() {
        guard let presentingController = presentingViewController else {
            _ = navigationController?.popToRootViewController(animated: true)
            return
        }

        presentingController.dismiss(animated: true, completion: nil)
    }

    /// A `Boolean` value indicating if the receiver is the first view controller on the `navigationController` stack or
    /// if it being presented modally.
    ///
    var isModal: Bool {
        if let navigationController = navigationController {
            if navigationController.viewControllers.first == self {
                if presentingViewController != nil {
                    return true
                }
            }
        } else if presentingViewController != nil {
            return true
        }

        return false
    }

    /// Presents a "toast" view controller. See `ToastController`.
    ///
    /// - Parameters:
    ///     - icon: The icon to be shown to the user.
    ///     - title: A localized string that represents the view this controller manages.
    ///     - message: A localized string that represents the message to be displayed to the user.
    ///     - duration: If a duration is specified, the view controller will auto-dismiss after the given `TimeInterval` has elapsed (default 5.0 seconds).
    ///     - action: The `AlertAction` associated with this toast
    ///     - dismissed: The code block to be executed whenever the view controller is dismissed.
    ///
    func showToast(icon: UIImage?,
                   title: String,
                   message: String,
                   duration: TimeInterval? = nil,
                   action: AlertAction? = nil,
                   dismissed: (() -> Void)? = nil) {
        
        let toast = ToastController(icon: icon, title: title, message: message)
        
        if let duration = duration {
            toast.duration = duration
        }
        
        toast.completion = dismissed
        toast.action = action
        
        self.safePresent(toast, animated: true, completion: nil)
    }

    /// A Boolean value indicating if the receiver is the first view controller onto the stack of its `UINaviogationController`.
    ///
    var isRootController: Bool {
        return self.navigationController?.viewControllers.first == self
    }

    /// Shortcut for DispatchQueue.main.asyncAfter(deadline:,execute:)
    ///
    func delay(_ delay: Double, closure: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(
            deadline: .now() + delay, execute: closure)
    }

    /// Adds to the controller's view a `UITapGestureRecognizer` to detect when the user taps anywhere around.
    ///
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false // prevent it to steal touches to other recognizers!
        view.addGestureRecognizer(tap)
    }

    /// Causes the controller's view (or one of its embedded text fields) to resign the first responder status.
    ///
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    /// Defines the appearance of the background gradient.
    ///
    /// - clear: Transparent background.
    /// - lightGrey: Light grey background.
    /// - blue: Blue background.
    enum Layout {
        /// Transparent background.
        case clear
        /// Light grey background.
        case lightGrey
        /// Blue background.
        case blue
    }

    /// Adds to the controller's view a `CAGradientLayer` sublayer with the colors defined by the given `layout`.
    /// - Parameter layout: See `Layout`. Defaults to Layout.lightGrey.
    /// - Returns: a reference to the added `CAGradientLayer`.
    ///
    @discardableResult func setupGradientBackground(_ layout: Layout = .lightGrey) -> CAGradientLayer? {
        switch layout {
        case .blue:
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = view.bounds
            gradientLayer.colors = [UIColor.darkBlueThree.cgColor, UIColor.darkBlueTwo.cgColor]
            gradientLayer.locations = [0.0, 1.0]
            view.layer.insertSublayer(gradientLayer, at: 0)
            return gradientLayer
        case .lightGrey:
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = view.bounds
            gradientLayer.colors = [UIColor.white.cgColor, UIColor.lightBlueGrey.cgColor]
            gradientLayer.locations = [0.0, 1.0]
            view.layer.insertSublayer(gradientLayer, at: 0)
            return gradientLayer
        default:
            return nil
        }
    }
}
