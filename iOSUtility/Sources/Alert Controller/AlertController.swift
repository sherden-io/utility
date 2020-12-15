//
//  AlertController.swift
//  Utility_Tests
//
//  Created by Gandolfi, Pietro on 14.12.20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

/// An object that displays an alert message to the user.
/// Use this class to configure a custom alert and an optional action with the message that you want to display.
/// After configuring the toast controller with the action you want, present it using the `present(_:animated:completion:)`method.
/// UIKit displays alerts and action sheets modally over your app's content.
///
/// In addition to displaying a message to a user, you can associate a set of actions with your alert controller to give the user a way
/// to respond. When the user taps an action, the alert controller executes the block you provided when creating the action object.
///
final class AlertController: UIViewController {

    /// :nodoc:
    @IBOutlet weak var contentView: UIView!
    /// :nodoc:
    @IBOutlet weak var imageView: UIImageView!
    /// :nodoc:
    @IBOutlet weak var titleLabel: UILabel!
    /// :nodoc:
    @IBOutlet weak var subtitleLabel: UILabel!
    /// :nodoc:
    @IBOutlet weak var messageLabel: UILabel!
    /// :nodoc:
    @IBOutlet weak var stackView: UIStackView!
    /// :nodoc:
    @IBOutlet weak var imageViewContainerHeightConstraint: NSLayoutConstraint!
    /// :nodoc:
    @IBOutlet weak var titleLabelWidthConstraint: NSLayoutConstraint!
    /// :nodoc:
    @IBOutlet weak var stackViewBottomConstraint: NSLayoutConstraint!

    /// The image to be displayed in the title area.
    ///
    var icon: UIImage?

    /// Descriptive text that provides the explanation for the alert.
    ///
    var message: String? {
        didSet {
            guard self.isViewLoaded else {
                return
            }
            self.messageLabel.text = self.message
        }
    }

    /// Descriptive text that provides more details about the reason for the alert.
    ///
    var subtitle: String? {
        didSet {
            guard self.isViewLoaded else {
                return
            }
            self.subtitleLabel.text = self.title
        }
    }

    private var preferredStyle: AlertControllerStyle
    private var actions = [AlertAction]()
    private var firstResponder: UIResponder?

    // MARK: - Initialization

    /// Returns a newly initialized view controller with the nib file in the specified bundle.
    /// - Parameters:
    ///     - nibNameOrNil: The name of the nib file to associate with the view controller. The nib file name should not
    ///                     contain any leading path information. If you specify nil, the nibName property is set to nil.
    ///     - nibBundleOrNil: The bundle in which to search for the nib file. This method looks for the nib file in the
    ///                       bundle's language-specific project directories first, followed by the Resources directory. If this
    ///                       parameter is nil, the method uses the heuristics described below to locate the nib file.
    /// - Returns: A newly initialized `AlertController` object.
    ///
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.preferredStyle = .alert
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
    }

    /// Creates a new instance from specified `NSCoder`.
    /// - Parameter aDecoder: A decoder that restores data from an archive.
    /// - Returns: A newly initialized `AlertController` object.
    ///
    public required init?(coder aDecoder: NSCoder) {
        self.preferredStyle = .alert
        super.init(coder: aDecoder)
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
    }

    /// Convenience initializer.
    /// - Parameters:
    ///     - icon: The image to be displayed in the title area.
    ///     - title: A localized string that represents the reason for the alert.
    ///     - subtitle: A localized string that represents more details about the reason for the alert.
    ///     - message: A localized string that represents the explanation for the alert.
    ///     - preferredStyle: The style of the alert controller.
    /// - Returns: A newly initialized `AlertController` object.
    ///
    public convenience init(icon: UIImage?,
                            title: String?,
                            subtitle: String?,
                            message: String?,
                            preferredStyle: AlertControllerStyle = .alert) {
        
        self.init(nibName: "AlertController", bundle: nil)
        self.icon = icon
        self.title = title ?? ""
        self.subtitle = subtitle ?? ""
        self.message = message ?? ""
        self.preferredStyle = preferredStyle
        switch self.preferredStyle {
        case .alert:
            self.modalTransitionStyle = .crossDissolve
        case .actionSheet:
            self.modalTransitionStyle = .coverVertical
        }
    }

    // MARK: - Public methods

    /// Attaches an action object to the alert or action sheet.
    ///
    public func addAction(_ action: AlertAction) {
        self.actions.append(action)
    }

    // MARK: - View Lifecycle

    /// :nodoc:
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupLayout()
        self.setupIcon()
        self.setupTitle()
        self.setupButtons()
    }

    /// :nodoc:
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.firstResponder = UIResponder.firstResponder()
        self.firstResponder?.resignFirstResponder()
    }

    /// :nodoc:
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.firstResponder?.becomeFirstResponder()
    }

    // MARK: - Notifications & Events

    @objc private func onButtonDidTap(sender: UIButton) {
        guard let presentingController = presentingViewController else {
            _ = navigationController?.popToRootViewController(animated: true)
            return
        }
        let action = self.actions[sender.tag]
        presentingController.dismiss(animated: true) {
            action.handler?(action)
        }
    }

    // MARK: - Private methods

    private func setupLayout() {
        self.view.backgroundColor = .clear

        self.contentView.layer.cornerRadius = 5
        self.contentView.layer.masksToBounds = true

        self.titleLabel.text = self.title
        self.subtitleLabel.text = self.subtitle
        self.messageLabel.text = self.message
    }

    private func setupIcon() {
        self.imageView.image = self.icon
        self.imageViewContainerHeightConstraint.constant = (self.icon != nil ? 30 + 72 + 10 : 30)
    }

    private func setupTitle() {
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            let wxh = CGFloat.minimum(self.view.frame.size.width, self.view.frame.size.height)
            self.titleLabelWidthConstraint.constant = -wxh * 2.0 / 3.0
        default:
            self.titleLabelWidthConstraint.constant = -40
        }
    }

    private func setupButtons() {
        var dismissAction: AlertAction?
        var numberOfButtons = 0
        var heightForDismissButton: CGFloat = 0
        for action in self.actions {
            if action.style == .cancel {
                dismissAction = action
                heightForDismissButton = 60
            }
            numberOfButtons += 1
        }
        let bottomMargin: CGFloat = (dismissAction != nil ? 0 : 30)
        self.stackViewBottomConstraint.constant = bottomMargin
        self.view.layoutIfNeeded()
        var heightForActionButton: CGFloat = 0
        if numberOfButtons > 0 {
            var numberOfActionButtons = numberOfButtons
            // self.stackView.bounds.size.height will be 0 until buttons are added.
            // Moreover the view size will be incorrect until viewDidAppear.
            // So we have to manually compute the available height
            var height = UIScreen.main.bounds.height
            height -= bottomMargin + self.contentView.frame.origin.y + self.stackView.frame.origin.y
            if dismissAction != nil {
                height -= (self.stackView.spacing + heightForDismissButton)
                numberOfActionButtons -= 1
            }
            let spacing: CGFloat = self.stackView.spacing * CGFloat(numberOfActionButtons - 1)
            heightForActionButton = ceil((height - spacing) / CGFloat(numberOfActionButtons))
        }
        let font = UIFont(name: "System", size: 19)
        heightForActionButton = max(heightForActionButton, ceil(2 * (font?.lineHeight ?? 19.0)))
        heightForActionButton = min(heightForActionButton, 48.0)
        for action in self.actions where action.style != .cancel {
            let actionButton = UIButton(type: .custom)
            actionButton.translatesAutoresizingMaskIntoConstraints = false
            actionButton.isEnabled = action.isEnabled
            actionButton.alpha = actionButton.isEnabled ? 1.0 : 0.4
            actionButton.tag = self.actions.firstIndex(of: action)!
            actionButton.addTarget(self, action: #selector(onButtonDidTap(sender:)), for: .touchUpInside)
            actionButton.showsTouchWhenHighlighted = true
            actionButton.backgroundColor = .darkBlue
            actionButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 16, bottom: 2, right: 16)
            actionButton.titleLabel?.font = font
            actionButton.titleLabel?.adjustsFontSizeToFitWidth = true
            actionButton.titleLabel?.minimumScaleFactor = 0.5
            actionButton.setTitle(action.title, for: .normal)
            actionButton.setTitleColor(UIColor.white, for: .normal)
            actionButton.layer.cornerRadius = heightForActionButton / 2
            actionButton.layer.shadowColor = UIColor.blueGreyTwo.cgColor
            actionButton.layer.shadowOffset = CGSize(width: 0, height: 2)
            actionButton.layer.shadowOpacity = 0.2
            actionButton.layer.shadowRadius = 5
            
            self.stackView.addArrangedSubview(actionButton)
            
            actionButton.leftAnchor.constraint(equalTo: self.stackView.leftAnchor, constant: 30).isActive = true
            actionButton.rightAnchor.constraint(equalTo: self.stackView.rightAnchor, constant: -30).isActive = true
            actionButton.heightAnchor.constraint(equalToConstant: heightForActionButton).isActive = true
        }
        
        if let dismissAction = dismissAction {
            let dismissButton = UIButton(type: .custom)
            dismissButton.translatesAutoresizingMaskIntoConstraints = false
            dismissButton.isEnabled = dismissAction.isEnabled
            dismissButton.alpha = dismissButton.isEnabled ? 1.0 : 0.4
            dismissButton.tag = self.actions.firstIndex(of: dismissAction)!
            dismissButton.addTarget(self, action: #selector(onButtonDidTap(sender:)), for: .touchUpInside)
            dismissButton.showsTouchWhenHighlighted = true
            dismissButton.backgroundColor = .paleGrey
            dismissButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 16, bottom: 2, right: 16)
            dismissButton.titleLabel?.font = UIFont(name: "System", size: 16)
            dismissButton.setTitle(dismissAction.title, for: .normal)
            dismissButton.setTitleColor(UIColor.darkBlueTwo, for: .normal)
            self.stackView.addArrangedSubview(dismissButton)
            dismissButton.leftAnchor.constraint(equalTo: self.stackView.leftAnchor, constant: 0).isActive = true
            dismissButton.rightAnchor.constraint(equalTo: self.stackView.rightAnchor, constant: 0).isActive = true
            dismissButton.heightAnchor.constraint(equalToConstant: heightForDismissButton).isActive = true

            let border = UIView()
            border.translatesAutoresizingMaskIntoConstraints = false
            border.backgroundColor = .paleGreyThree
            dismissButton.addSubview(border)
            border.topAnchor.constraint(equalTo: dismissButton.topAnchor).isActive = true
            border.leftAnchor.constraint(equalTo: dismissButton.leftAnchor).isActive = true
            border.rightAnchor.constraint(equalTo: dismissButton.rightAnchor).isActive = true
            border.heightAnchor.constraint(equalToConstant: 1).isActive = true
        }
    }

}
