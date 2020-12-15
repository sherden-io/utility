//
//  ToastController.swift
//  Utility_Tests
//
//  Created by Gandolfi, Pietro on 14.12.20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

/// An object that displays an alert message to the user.
/// You may configure the controller to auto-dismiss after a given `duration`.
/// The view appears sliding bottomwards and disappears sliding upwards.
/// Use this class to configure a custom alert and an optional action with the message that you want to display.
/// After configuring the toast controller with the action you want, present it using the `present(_:animated:completion:)`method.
/// UIKit displays alerts and action sheets modally over your app's content.
///
final class ToastController: UIViewController {

    /// :nodoc:
    @IBOutlet weak var mainView: UIView!
    /// :nodoc:
    @IBOutlet weak var contentView: UIView!
    /// :nodoc:
    @IBOutlet weak var leftView: UIView!
    /// :nodoc:
    @IBOutlet weak var borderView: UIView!
    /// :nodoc:
    @IBOutlet weak var imageView: UIImageView!
    /// :nodoc:
    @IBOutlet weak var titleLabel: UILabel!
    /// :nodoc:
    @IBOutlet weak var messageLabel: UILabel!
    /// :nodoc:
    @IBOutlet weak var actionButtonContainerView: UIView!
    /// :nodoc:
    @IBOutlet weak var actionButton: UIButton!
    /// :nodoc:
    @IBOutlet weak var dismissButton: UIButton!

    /// :nodoc:
    @IBOutlet weak var mainViewTopConstraint: NSLayoutConstraint!

    /// If a duration is specified, the view controller will auto-dismiss after the given `TimeInterval` has elapsed.
    ///
    var duration: TimeInterval?

    /// The message to be displayed to the user.
    ///
    var message: String? { didSet { self.refreshAllViews() } }

    /// The icon to be shown to the user.
    ///
    var icon: UIImage? { didSet { self.refreshAllViews() } }

    /// The `AlertAction` associated with this toast.
    ///
    var action: AlertAction? { didSet { self.refreshAllViews() } }

    /// The code block to be executed whenever the view controller is dismissed.
    ///
    var completion: (() -> Swift.Void)?

    // MARK: - Initialization

    /// Returns a newly initialized view controller with the nib file in the specified bundle.
    /// - Returns: A newly initialized `ToastController` object.
    ///
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
    }

    /// Creates a new instance from specified `NSCoder`.
    /// - Parameter aDecoder: A decoder that restores data from an archive.
    /// - Returns: A newly initialized `ToastController` object.
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
    }

    /// Convenience initializer.
    /// - Parameters:
    ///     - icon: The icon to be shown to the user.
    ///     - title: A localized string that represents the view this controller manages.
    ///     - message: A localized string that represents the message to be displayed to the user.
    ///     - duration: If a duration is specified, the view controller will auto-dismiss after the given `TimeInterval` has elapsed (default 5.0 seconds).
    ///     - completion: The code block to be executed whenever the view controller is dismissed.
    /// - Returns: A newly initialized `ToastController` object.
    ///
    public convenience init(icon: UIImage?, title: String?, message: String?, duration: TimeInterval? = 5.0, completion: (() -> Swift.Void)? = nil) {
        self.init(nibName: "ToastController", bundle: nil)
        self.icon = icon
        self.title = title ?? ""
        self.message = message ?? ""
        self.duration = duration
        self.completion = completion
    }

    // MARK: - View Lifecycle

    /// :nodoc:
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupLayout()
        self.setupIcon()
    }

    /// :nodoc:
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        var top: CGFloat = 0.0
        
        if #available(iOS 11.0, *) {
            top = self.view.safeAreaLayoutGuide.layoutFrame.origin.y // normally 20px but 44 on iPhoneX
        } else {

        }
        
        self.slide(top: top, animated: true)

        if let duration = self.duration {
            if duration > TimeInterval(0.0) {
                weak var weakSelf = self
                DispatchQueue.main.asyncAfter(
                    deadline: DispatchTime.now() + Double(Int64(duration * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC),
                    execute: {
                        weakSelf?.slideOutAndDismiss(animated: true, completion: self.completion)
                })
            }
        }
    }

    /// :nodoc:
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    /// Dismisses the view controller that was presented modally by the presenting view controller.
    ///
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        self.slideOutAndDismiss(animated: flag) {
            self.completion?()
            completion?()
        }
    }

    //MARK: - Actions 

    /// When the "action" button is tapped, the controller is dismissed and then the handler of the action (if any) is called.
    /// In this case, the `ToastController.completion` is not called.
    ///
    @IBAction private func onActionButtonDidTap(sender: UIButton) {
        self.slideOutAndDismiss(animated: true) {
            self.action!.handler?(self.action!)
        }
    }

    /// When the "dismiss" button is tapped, the controller is dismissed and then the `ToastController.completion` (if any) is called.
    ///
    @IBAction private func onDismissButtonDidTap(sender: UIButton) {
        self.slideOutAndDismiss(animated: true, completion: self.completion)
    }

    /// When the user taps anywhere out of the content view, the controller is dismissed and then the `ToastController.completion` (if any) is called.
    ///
    @objc private func onDidTapAround(_ recognizer: UITapGestureRecognizer) {
        self.slideOutAndDismiss(animated: true, completion: self.completion)
    }

    /// When the user taps anywhere inside the content view -if an "action" has been defined- the controller is dismissed and then the handler of the action is called.
    ///
    @objc private func onDidTapToast(_ recognizer: UITapGestureRecognizer) {
        if let action = self.action {
            self.slideOutAndDismiss(animated: true) {
                action.handler?(self.action!)
            }
        }
    }

    /// When a "swipe-up" gesture is recognized, the controller is dismissed and then the `ToastController.completion` (if any) is called.
    ///
    @objc private func onDidSwipeUp(_ recognizer: UISwipeGestureRecognizer) {
        self.slideOutAndDismiss(animated: true, completion: self.completion)
    }

    // MARK: - Private methods

    private func setupLayout() {
        self.view.backgroundColor = .clear

        self.contentView.layer.cornerRadius = 5
        self.contentView.layer.masksToBounds = true

        self.mainView.layer.masksToBounds = false
        self.mainView.layer.shadowColor = UIColor.black.cgColor
        self.mainView.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.mainView.layer.shadowOpacity = 0.5
        self.mainView.layer.shadowRadius = 7

        let aroundRecognizer = UITapGestureRecognizer(target: self, action: #selector(onDidTapAround(_:)))
        self.view.addGestureRecognizer(aroundRecognizer)

        let toastRecognizer = UITapGestureRecognizer(target: self, action: #selector(onDidTapToast(_:)))
        self.contentView.addGestureRecognizer(toastRecognizer)

        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(onDidSwipeUp(_:)))
        swipeRecognizer.direction = .up
        self.contentView.addGestureRecognizer(swipeRecognizer)

        self.refreshAllViews()

        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()

        let top = -self.view.frame.size.height
        self.slide(top: top, animated: false)
    }

    private func setupIcon() {
        self.imageView.image = self.icon
    }

    private func slide(top: CGFloat, animated: Bool, completion: ((Bool) -> Swift.Void)? = nil) {
        self.mainViewTopConstraint.constant = top
        self.view.setNeedsUpdateConstraints()
        if animated {
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            }, completion: completion)
        } else if let completion = completion {
            completion(true)
        }
    }

    private func refreshAllViews() {
        if self.isViewLoaded {
            titleLabel.text = self.title
            messageLabel.text = self.message
            actionButton.setTitle(self.action?.title, for: .normal)
            actionButton.setTitle(self.action?.title, for: .highlighted)
            actionButton.isHidden = self.action == nil
            actionButtonContainerView.isHidden = actionButton.isHidden
        }
    }

    private func slideOutAndDismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        let top = -self.view.frame.size.height
        self.slide(top: top, animated: flag) { (_) in
            super.dismiss(animated: false, completion: completion)
        }
    }
}
