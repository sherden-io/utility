//
//  AlertControllerStyle.swift
//  Utility_tests
//
//  Created by Gandolfi, Pietro External on 15.12.20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

/// Constants indicating the type of Alert to display.
///
/// - actionSheet: An action sheet displayed in the context of the view controller that presented it.
/// - alert: An alert displayed modally for the app.
///
enum AlertControllerStyle: Int {
    /// An action sheet displayed in the context of the view controller that presented it.
    case actionSheet
    /// An alert displayed modally for the app.
    case alert
}
