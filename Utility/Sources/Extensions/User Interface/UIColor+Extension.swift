//
//  UIColor+Extension.swift
//  Utility_Tests
//
//  Created by Gandolfi, Pietro on 14.12.20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

extension UIColor {

    /// Initializes a new instance of UI color by RGB.
    ///
    /// - Parameters:
    ///   - red: Red component of the color.
    ///   - green: Green component of the color.
    ///   - blue: Blue component of the color.
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    /// Initializes a new instance of UI color by an HEX value.
    ///
    /// - Parameter netHex: An hexadecimal value representing RGB of the color.
    convenience init(netHex: Int) {
        self.init(red: (netHex >> 16) & 0xff, green: (netHex >> 8) & 0xff, blue: netHex & 0xff)
    }

    /// Creates a warm grey color with alpha component set to 0.27.
    @nonobjc class var warmGreyA27: UIColor {
        return UIColor(white: 151.0 / 255.0, alpha: 0.27)
    }

    /// Creates a black color with alpha component set to 0.09.
    @nonobjc class var blackA9: UIColor {
        return UIColor(white: 0.0, alpha: 0.09)
    }

    /// Creates a white color with alpha component set to 1.
    @nonobjc class var whiteA1: UIColor {
        return UIColor(white: 216, alpha: 1.0)
    }

    /// Creates a grey color with alpha component set to 0.3.
    @nonobjc class var greyA30: UIColor {
        return UIColor(white: 216, alpha: 0.3)
    }

    /// Creates a pale grey color with red: 245, green: 245, blue: 248.
    @nonobjc class var paleGrey: UIColor {
        return UIColor(red: 245, green: 245, blue: 248)
    }

    /// Creates a pale grey color with red: 237, green: 237, blue: 242.
    @nonobjc class var paleGreyTwo: UIColor {
        return UIColor(red: 237, green: 237, blue: 242)
    }

    /// Creates a pale grey color with red: 225, green: 226, blue: 240.
    @nonobjc class var paleGreyThree: UIColor {
        return UIColor(red: 225, green: 226, blue: 240)
    }

    /// Creates a pale grey color with red: 248, green: 248, blue: 25.
    @nonobjc class var paleGreyFour: UIColor {
        return UIColor(red: 248, green: 248, blue: 250)
    }

    /// Creates a blue grey color with red: 145, green: 147, blue: 170.
    @nonobjc class var blueGrey: UIColor {
        return UIColor(red: 145, green: 147, blue: 170)
    }

    /// Creates a blue grey color with red: 149, green: 150, blue: 170.
    @nonobjc class var blueGreyTwo: UIColor {
        return UIColor(red: 149, green: 150, blue: 170)
    }

    /// Creates a scarlet color.
    @nonobjc class var scarlet: UIColor {
        return UIColor(red: 208, green: 2, blue: 27)
    }

    /// Creates a purpley grey color.
    @nonobjc class var purpleyGrey: UIColor {
        return UIColor(red: 155, green: 155, blue: 155)
    }

    /// Creates a battleship grey color with red: 110, green: 112, blue: 128.
    @nonobjc class var battleshipGrey: UIColor {
        return UIColor(red: 110, green: 112, blue: 128)
    }

    /// Creates a battleship grey color with red: 116, green: 116, blue: 134.
    @nonobjc class var battleshipGreyThree: UIColor {
        return UIColor(red: 116, green: 116, blue: 134)
    }

    /// Creates a greyish Brown color.
    @nonobjc class var greyishBrown: UIColor {
        return UIColor(red: 77, green: 77, blue: 77)
    }

    /// Creates a slate Grey color.
    @nonobjc class var slateGrey: UIColor {
        return UIColor(red: 93, green: 93, blue: 105)
    }

    /// Creates a steel color.
    @nonobjc class var steel: UIColor {
        return UIColor(red: 132, green: 134, blue: 150)
    }

    /// Creates a dark Blue color with red: 49, green: 63, blue: 162.
    @nonobjc class var darkBlue: UIColor {
        return UIColor(red: 49, green: 63, blue: 162)
    }

    /// Creates a dark Blue color with red: 50, green: 66, blue: 159.
    @nonobjc class var darkBlueTwo: UIColor {
        return UIColor(red: 50, green: 66, blue: 159)
    }

    /// Creates a dark Blue color with red: 50, green: 64, blue: 163.
    @nonobjc class var darkBlueThree: UIColor {
        return UIColor(red: 50, green: 64, blue: 163)
    }

    /// Creates a dark Blue color with red: 50, green: 65, blue: 164.
    @nonobjc class var darkBlueFour: UIColor {
        return UIColor(red: 50, green: 65, blue: 164)
    }

    /// Creates a soft Blue color.
    @nonobjc class var softBlue: UIColor {
        return UIColor(red: 97, green: 156, blue: 232)
    }

    /// Creates a windows Blue color.
    @nonobjc class var windowsBlue: UIColor {
        return UIColor(red: 70, green: 96, blue: 200)
    }

    /// Creates a black color with alpha component set to 0.5.
    @nonobjc class var blackA50: UIColor {
        return UIColor(white: 0.0, alpha: 0.5)
    }

    /// Creates a pumpkin Orange color with red: 255, green: 131, blue: 0.
    @nonobjc class var pumpkinOrange: UIColor {
        return UIColor(red: 255, green: 131, blue: 0)
    }

    /// Creates a pumpkin Orange color with red: 253, green: 123, blue: 35.
    @nonobjc class var pumpkinOrangeTwo: UIColor {
        return UIColor(red: 253, green: 123, blue: 35)
    }

    /// Creates a orangey Red color.
    @nonobjc class var orangeyRed: UIColor {
        return UIColor(red: 253, green: 85, blue: 45)
    }

    /// Creates a light Blue Grey color.
    @nonobjc class var lightBlueGrey: UIColor {
        return UIColor(red: 219, green: 222, blue: 240)
    }

    /// Creates a bluey Grey with alpha component set to 0.2.
    @nonobjc class var blueyGreyTwoA20: UIColor {
        return UIColor(red: 145.0 / 255.0, green: 147.0 / 255.0, blue: 170.0 / 255.0, alpha: 0.2)
    }

    /// Creates a pale Grey color with red: 244, green: 245, blue: 251.
    @nonobjc class var paleGreyFive: UIColor {
        return UIColor(red: 244, green: 245, blue: 251)
    }

    /// Creates a pale Grey color with red: 236, green: 236, blue: 240.
    @nonobjc class var paleGreySix: UIColor {
        return UIColor(red: 236, green: 236, blue: 240)
    }

    /// Creates a pale Grey color with red: 151, green: 151, blue: 151.
    @nonobjc class var paleGreySeven: UIColor {
        return UIColor(red: 151, green: 151, blue: 151)
    }

    /// Creates a dark Blue color with alpha component set to 1.
    @nonobjc class var darkBlueA1: UIColor {
        return UIColor(red: 0.09, green: 0.13, blue: 0.43, alpha: 1.0)
    }

    /// Creates a light Blue color with alpha component set to 0.2.
    @nonobjc class var lightBlueGreyTwoA20: UIColor {
        return UIColor(red: 197.0 / 255.0, green: 202.0 / 255.0, blue: 233.0 / 255.0, alpha: 0.2)
    }

    /// Creates a french Blue color with alpha component set to 0.2.
    @nonobjc class var frenchBlueA20: UIColor {
        return UIColor(red: 65.0 / 255.0, green: 82.0 / 255.0, blue: 185.0 / 255.0, alpha: 0.2)
    }

   /// Creates a light Navy Blue color.
    @nonobjc class var lightNavyBlue: UIColor {
        return UIColor(red: 50, green: 66, blue: 156)
    }
}
