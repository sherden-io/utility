//
//  Date+Extension.swift
//  Utility_Tests
//
//  Created by Gandolfi, Pietro on 14.12.20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

// MARK: - Date
extension Date {

    /// It represents the rounding type.
    ///
    /// - round: The nearest integral value.
    /// - ceil: The smallest integral value greater than or equal to x.
    /// - floor: The greatest integer less than or equal to x
    enum DateRoundingType {
        /// The nearest integral value.
        case round
        /// The smallest integral value greater than or equal to x.
        case ceil
        /// The greatest integer less than or equal to x
        case floor
    }

    /// Adds minutes to 00:00:00 UTC on 1 January 1970.
    ///
    /// - Parameter minutes: Minutes to add to 00:00:00 UTC on 1 January 1970.
    init(fromMinutes minutes: Int) {
        self = Date(timeIntervalSince1970: 0).addingTimeInterval(minutes.minutes)
    }

    /// Converts a date to string using medium style (e.g.: Sep 13, 2018).
    var formatDateToMediumStyleString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: self)
    }

    /// Converts a date to string using medium style (e.g.: Sep 13, 2018).
    ///
    /// - Parameter timeZone: timeZone: the desired TimeZone.
    /// - Returns: the formatted Date in String.
    func formatDateToMediumStyleString(timeZone: TimeZone) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeZone = timeZone
        return dateFormatter.string(from: self)
    }

    /// Converts a date to string using long style (e.g.: September 21, 2018).
    var formatDateToLongStyleString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: self)
    }

    /// Converts a date to string using long style (e.g.: September 21, 2018).
    ///
    /// - Parameter timeZone: timeZone: the desired TimeZone.
    /// - Returns: the formatted Date in String.
    func formatDateToLongStyleString(timeZone: TimeZone) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeZone = timeZone
        return dateFormatter.string(from: self)
    }

    /// Converts a date to string using custom style (e.g.: 01/15/1950).
    var formatDateToString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.setLocalizedDateFormatFromTemplate("MM/dd/YYYY")
        return dateFormatter.string(from: self)
    }

    /// Converts a date to string using custom style (e.g.: 01/15/1950).
    var formatDateToPrescriptionString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: self)
    }

    /// Converts a date to string using short style (e.g.: 00:05).
    var formatTimeToString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: self).lowercased()
    }

    /// Converts a date to string using short style (e.g.: 00:05).
    ///
    /// - Parameter timeZone: the desired TimeZone.
    /// - Returns: the formatted Date in String.
    func formatTimeToString(timeZone: TimeZone) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.timeZone = timeZone
        return dateFormatter.string(from: self).lowercased()
    }

    /// Converts a GMT date to string using short style (e.g.: 06:00).
    var formatGMTTimeToString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)!
        return dateFormatter.string(from: self).lowercased()
    }

    /// Creates a date starting from rounded minutes.
    ///
    /// - Parameters:
    ///   - minutes: Minutes to round.
    ///   - rounding: A rounding method.
    /// - Returns: A date created starting from rounded minutes.
    func rounded(minutes: Int, rounding: DateRoundingType = .round) -> Date {
        return rounded(seconds: minutes.minutes, rounding: rounding)
    }

    /// Resets hours, minutes and seconds to a date.
    ///
    /// - Returns: A date with hours, minutes and seconds set to zero.
    func dateWithYMD() -> Date {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month, .day], from: self)
        let ymd = calendar.date(from: components)!
        return ymd
    }

    /// Creates a date starting from rounded seconds since 1970.
    ///
    /// - Returns: A date starting from rounded seconds since 1970.
    func dateWithHMS() -> Date {
        let timeInterval = floor(self.timeIntervalSince1970)
        return Date(timeIntervalSince1970: timeInterval)
    }

    /// Resets seconds to a date.
    ///
    /// - Returns: A date with seconds set to zero.
    func dateWithHM() -> Date {
        var timeInterval = floor(self.timeIntervalSince1970)
        timeInterval = floor(timeInterval / 1.minutes)
        timeInterval *= 1.minutes
        return Date(timeIntervalSince1970: timeInterval)
    }

    /// Converts date into GMT minutes.
    ///
    /// - Returns: GMT minutes from a date.
    func toMinutes() -> Int {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        let components = calendar.dateComponents([.hour, .minute], from: self)
        return components.hour! * 60 + components.minute!
    }

    /// Creates a date starting from rounded seconds.
    ///
    /// - Parameters:
    ///   - seconds: Seconds to round.
    ///   - rounding: A rounding method.
    /// - Returns: A date created starting from rounded seconds.
    func rounded(seconds: TimeInterval, rounding: DateRoundingType = .round) -> Date {
        var roundedInterval: TimeInterval = 0
        switch rounding {
        case .round:
            roundedInterval = (timeIntervalSinceReferenceDate / seconds).rounded() * seconds
        case .ceil:
            roundedInterval = ceil(timeIntervalSinceReferenceDate / seconds) * seconds
        case .floor:
            roundedInterval = floor(timeIntervalSinceReferenceDate / seconds) * seconds
        }
        return Date(timeIntervalSinceReferenceDate: roundedInterval)
    }

    /// Converts a date to local date.
    ///
    /// - Parameter localMinutesOffset: Local offset in minutes.
    /// - Returns: A local date.
    func localDate(localMinutesOffset: Int) -> Date {
        let timezoneMinutesOffset = TimeZone.timezoneMinutesOffset()
        let localDate = self.addingTimeInterval(-timezoneMinutesOffset.minutes).addingTimeInterval(localMinutesOffset.minutes)
        return localDate
    }
}
