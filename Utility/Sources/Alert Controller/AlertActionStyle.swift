//
//  AlertActionStyle.swift
//  Utility_tests
//
//  Created by Gandolfi, Pietro External on 15.12.20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

/// Styles to apply to action buttons in an Alert.
///
/// - `default`: Apply the default style to the action’s button.
/// - cancel: Apply a style that indicates the action cancels the operation and leaves things unchanged.
/// - destructive: Apply a style that indicates the action might change or delete data.
///
enum AlertActionStyle: Int {
    /// Apply the default style to the action’s button.
    case `default`
    /// Apply a style that indicates the action cancels the operation and leaves things unchanged.
    case cancel
    /// Apply a style that indicates the action might change or delete data.
    case destructive
}
