//
//  AlertPriority.swift
//  Utility_tests
//
//  Created by Gandolfi, Pietro External on 15.12.20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

/// Alert Priority of the Alert.
struct AlertPriority {

    /// Image associated to alert priority.
    var image: PriorityImage

    /// Initializes a new instance of AlertPriority struct.
    ///
    /// - Parameter image: Image related to AlertPriority.
    private init(image: PriorityImage) {
        self.image = image
    }

    /// Low priority.
    static let low = AlertPriority(image: .alertLow)

    /// Medium priority.
    static let medium = AlertPriority(image: .alertMedium)

    /// High priority.
    static let high = AlertPriority(image: .alertHigh)
}
