//
//  AppColors.swift
//  DentalYear
//
//  Created by Globizserve on 08/08/2020.
//  Copyright © 2020 Globizserve. All rights reserved.
//

import Foundation
import UIKit
extension UIColor {

    static let themeGreen = hexStringToUIColor(hex: "#06ad54")
    static let textBlack = hexStringToUIColor(hex: "#232333")
    static let textGrey = hexStringToUIColor(hex: "#40495a")
    static let themeYellow = hexStringToUIColor(hex: "#FAC92E")
    static let textLightGrey = hexStringToUIColor(hex: "#616161")
    static let borderLineGrey = hexStringToUIColor(hex: "#aeaeae")
    static let textRed = hexStringToUIColor(hex: "#FF4936")
    static let textPurple = hexStringToUIColor(hex: "#323574")

    class func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }


}
