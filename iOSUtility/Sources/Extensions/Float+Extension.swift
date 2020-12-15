//
//  Float+Extension.swift
//  Utility_tests
//
//  Created by Gandolfi, Pietro External on 15.12.20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

extension Float {

    /// Converts minutes into seconds.
    var minutes: TimeInterval {
        return TimeInterval(self * 60)
    }

    /// Converts hours into seconds.
    var hours: TimeInterval {
        return TimeInterval(self.minutes * 60)
    }

    /// Converts days into seconds.
    var days: TimeInterval {
        return TimeInterval(self.hours * 24)
    }

    /// Converts weeks into seconds.
    var weeks: TimeInterval {
        return TimeInterval(self.days * 7)
    }
}
