//
//  URL+Extension.swift
//  Utility_Tests
//
//  Created by Gandolfi, Pietro on 14.12.20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

/// This extension adds functionalities to the `URL` class that are widely used through the App.
///
extension URL {

    /// Creates a new instance from the specified URI.
    /// A Uniform Resource Identifier (URI) is a string of characters designed for unambiguous identification of resources and extensibility via the URI scheme.
    /// If the URI scheme is "bundle:", then it returns the file URL for the resource identified by the specified name (`url.host`) in the main bundle.
    /// Returns nil if a URL cannot be formed with the string
    /// (for example, if the string contains characters that are illegal in a URL, or is an empty string) or if the specified file does not exist.
    /// - Parameter uri: The URI string.
    /// - Returns: An initialized instance of the `URL` class (or nil).
    ///
    init?(uri: String) {
        guard uri.isValidURL() else {
            return nil
        }
        guard let url = URL(string: uri) else {
            return nil
        }
        switch url.scheme ?? "" {
        case "bundle":
            let filename = url.host
            guard let url = Bundle.main.url(forResource: filename, withExtension: nil) else {
                return nil
            }
            self = url
        default:
            self = url
        }
    }
}
