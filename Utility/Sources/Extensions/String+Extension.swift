//
//  String+Extension.swift
//  Utility_Tests
//
//  Created by Gandolfi, Pietro on 14.12.20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

extension String {

    /// Gets the first character of a string.
    var first: String {
        return String(self.prefix(1))
    }

    /// Gets the last character of a string.
    var last: String {
        return String(self.suffix(1))
    }

    /// Gets a trimmed string with the first character in uppercase.
    var trimAndUppercaseFirstCharacter: String {
        return first.uppercased()
    }

    /// Gets the first character of a string in uppercase.
    var uppercaseFirstCharacter: String {
        return first.uppercased() + String(self.dropFirst())
    }

    /// Remove white spaces from a string.
    var removeSpaces: String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }

    /// Allows to use "STRING_KEY".localized instead of NSLocalizedString("","")
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    /// Gets a date in UTC format starting from a date in string format.
    var toUTCFormat: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.timeZone = TimeZone.init(abbreviation: "UTC")
        formatter.locale = Locale.init(identifier: "en-US")
        return formatter.date(from: self)
    }

    /// Gets a date from a time frame in string format from LPC.
    var formatTimeFrameFromLPC: Date? {
        let timeFrames = self.removeSpaces.split(separator: ":").map({ Int($0) })

        guard timeFrames.count == 2 else {
            return nil
        }

        let hh = (timeFrames[0] ?? 0)
        let mm = (timeFrames[1] ?? 0)
        let timeInterval = TimeInterval(hh.hours + mm.minutes)
        let date = Date(timeIntervalSince1970: timeInterval)
        return date

    }

    /// Converts date of birth in string format into a date.
    var formatDOBToDate: Date? {
        let formatter = DateFormatter()
        let inputFormat = "yyyy-MM-dd"
        formatter.dateFormat = inputFormat

        let gregorian = Calendar(identifier: .gregorian)

        let now = Date(timeIntervalSince1970: 0)

        var component = gregorian.dateComponents([.year, .month, .day, .hour, .minute, .second], from: now)

        let timeFrame = self.split(separator: "-").map({ Int($0) })
        print(timeFrame)

        component.year = timeFrame[0]
        component.month = timeFrame[1]
        component.day = timeFrame[2]

        let date = gregorian.date(from: component)

        return date
    }

    // URL

    /// Gets data encoded in UTF8 from string.
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }

    /// Highlights text
    ///
    /// - Parameters:
    ///   - text: Text to Highlight.
    ///   - color: Foreground color.
    /// - Returns: An Highlighted text.
    func setupAttributed(withHighlightedText text: String, ofColor color: UIColor = .white) -> NSMutableAttributedString {
        let range = (self as NSString).range(of: text)
        let attributedString = NSMutableAttributedString(string: self)

        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)

        return attributedString
    }

    /// Highlights an array of text.
    ///
    /// - Parameters:
    ///   - texts: Array of text to Highlight
    ///   - color: Foreground color.
    /// - Returns: An Highlighted array of text.
    func setupAttributed(withMultipleHighlightedText texts: [String], ofColor color: UIColor = .white) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self)

        for text in texts {
            let range = (self as NSString).range(of: text)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }

        return attributedString
    }

    /// Parses an HTML.
    ///
    /// - Returns: A string that is the result of parsing of HTML.
    func parseHTML() -> NSAttributedString? {
        let data = Data(self.utf8)
        let attrStr = try? NSMutableAttributedString(data: data,
                                                     options: [.documentType: NSAttributedString.DocumentType.html],
                                                     documentAttributes: nil)
        return attrStr
    }

    /// Check whether a string is a valid URL.
    ///
    /// - Returns: A value indicating whether a string is a valid URL.
    func isValidURL() -> Bool {
        guard !self.isEmpty else {
            return false
        }
        let types: NSTextCheckingResult.CheckingType = [.link]
        guard let detector = try? NSDataDetector(types: types.rawValue) else {
            return false
        }
        guard detector.numberOfMatches(in: self,
                                       options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                       range: NSRange(location: 0, length: self.count)) == 1 else {
            return false
        }
        return true
    }

    /// Change font of a string.
    ///
    /// - Parameters:
    ///   - text: Text to apply the new font.
    ///   - font: New font to apply to text.
    /// - Returns: A text with a new font.
    func changeFont(forText text: String, withFont font: UIFont) -> NSMutableAttributedString {
        let range = (self as NSString).range(of: text)
        let attributedString = NSMutableAttributedString(string: self)

        attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: range)

        return attributedString
    }

    /// Replaces the first occurence of a string with another string.
    ///
    /// - Parameters:
    ///   - target: String where replace the occurence.
    ///   - replaceString: String to replace.
    /// - Returns: A new string that is the result of replacment.
    func replacingFirstOccurrence(of target: String, with replaceString: String) -> String {
        if let range = self.range(of: target) {
            return self.replacingCharacters(in: range, with: replaceString)
        }
        return self
    }

    /// Remove trailing zeroes from a string.
    ///
    /// - Returns: A string without trailing zeroes.
    func removingTrailingZeroes() -> String {
        var result = self
        // remove trailing zeroes
        if let index = result.firstIndex(of: ".") ?? result.firstIndex(of: ",") {
            let decimals = result[index...].trimmingCharacters(in: CharacterSet(charactersIn: "0"))
            result = result[..<index] + decimals
            if result.last == "." || result.last == "," {
                result.removeLast()
            }
        }
        return result
    }

}
