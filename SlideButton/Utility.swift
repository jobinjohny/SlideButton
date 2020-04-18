//
//  Utility.swift
//  Swipe Button
//
//  Created by Jobin on 18/04/20.
//  Copyright © 2020 Jobin_Johny. All rights reserved.
//

import UIKit
///Colour used in the project
struct ApplicationColour {
    static func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
