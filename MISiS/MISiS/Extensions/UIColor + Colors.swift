//
//  Colors.swift
//  MISiS
//
//  Created by Vova SKR on 06.01.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import UIKit

extension UIColor {
    
    static var lightBlue: UIColor {
        return UIColor(red: 58 / 255, green: 150 / 255, blue: 214 / 255, alpha: 1)
    }
    
    static var mainRed: UIColor {
           return UIColor(red: 255 / 255, green: 85 / 255, blue: 77 / 255, alpha: 1)
       }
}


// delete \/

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: alpha
        )
    }
    
    convenience init(rgb: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF,
            alpha: alpha
        )
    }
}

class UserColor {

    static let gray5 = UIColor(rgb: 0xF7F7F7)
    static let gray20 = UIColor(rgb: 0xEAEAEA)
    static let gray40 = UIColor(rgb: 0xC7C7CC)
    static let gray60 = UIColor(rgb: 0x8E8E93)
    static let gray70 = UIColor(rgb: 0x61616A)
    static let gray80 = UIColor(rgb: 0x35353F)
    static let gray90 = UIColor(rgb: 0x16161F)
    static let gray10 = UIColor()
}
