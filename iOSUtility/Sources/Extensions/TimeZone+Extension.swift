//
//  TimeZone+Extension.swift
//  Utility_Tests
//
//  Created by Gandolfi, Pietro on 14.12.20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

extension TimeZone {

    public static func timezoneMinutesOffset() -> Int {
        return Int(TimeZone.current.secondsFromGMT() / 60)
    }

}
