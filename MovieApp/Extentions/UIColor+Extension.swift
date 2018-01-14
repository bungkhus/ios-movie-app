//
//  UIColor+Extension.swift
//  Bali United
//
//  Created by Rifat Firdaus on 1/12/17.
//  Copyright © 2017 Suitmedia. All rights reserved.
//

import UIKit

extension UIColor {
    
//    public convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
//        assert(red >= 0 && red <= 255, "Invalid red component")
//        assert(green >= 0 && green <= 255, "Invalid green component")
//        assert(blue >= 0 && blue <= 255, "Invalid blue component")
//        
//        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
//    }
//    
//    public convenience init(hex: Int, alpha: CGFloat = 1.0) {
//        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
//        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
//        let blue = CGFloat((hex & 0x0000FF)) / 255.0
//        self.init(red:red, green:green, blue:blue, alpha:alpha)
//    }
    
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0x0000FF)) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = hexString[..<start]
            if hexColor.characters.count == 6 || hexColor.characters.count == 8 {
                let scanner = Scanner(string: String(hexColor))
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    if hexColor.characters.count == 6 {
                        r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                        g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                        b = CGFloat((hexNumber & 0x0000ff)) / 255
                        a = CGFloat(1.0)
                    } else {
                        r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                        g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                        b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                        a = CGFloat(hexNumber & 0x000000ff) / 255
                    }
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
    
    static func primary(alpha: CGFloat = 1) -> UIColor {
        return UIColor(hex: 0x3ca04b, alpha: alpha)
    }
    
    static func primaryDark(alpha: CGFloat = 1) -> UIColor {
        return UIColor(hex: 0x3da24c, alpha: alpha)
    }
    
    static func accent(alpha: CGFloat = 1) -> UIColor {
        return UIColor(hex: 0xf00101, alpha: alpha) // red
    }
    
    static func white(alpha: CGFloat = 1) -> UIColor {
        return UIColor(hex: 0xFFFFFF, alpha: alpha)
    }
    
    static func background(alpha: CGFloat = 1) -> UIColor {
        return UIColor(hex: 0x9f9f9f, alpha: alpha)
    }
    
    static func textColor(alpha: CGFloat = 1) -> UIColor {
        return UIColor(hex: 0x3c3c3c, alpha: alpha)
    }
    
    static func secondaryTextColor(alpha: CGFloat = 1) -> UIColor {
        return UIColor(hex: 0x999999, alpha: alpha)
    }
}
