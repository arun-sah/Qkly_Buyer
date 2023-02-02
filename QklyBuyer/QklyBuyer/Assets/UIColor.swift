//
//  UIColor.swift
//  QklyBuyer
//
//  Created by arun sah on 20/01/2023.
//


import Foundation
import UIKit
extension UIColor {
    static let app_primary_black_0_1         = UIColor(named: "app_primary_black_0_1")
    static let app_primary_black_0_4         = UIColor(named: "app_primary_black_0_4")
    static let app_primary_black_0_6         = UIColor(named: "app_primary_black_0_6")
    static let app_primary_black_0_8         = UIColor(named: "app_primary_black_0_8")
    static let app_primary_black             = UIColor(named: "app_primary_black")
    static let app_primary_gray_0_1          = UIColor(named: "app_primary_gray_0_1")
    static let app_primary_gray_0_4          = UIColor(named: "app_primary_gray_0_4")
    static let app_primary_gray_0_6          = UIColor(named: "app_primary_gray_0_6")
    static let app_primary_gray_0_8          = UIColor(named: "app_primary_gray_0_8")
    static let app_primary_gray              = UIColor(named: "app_primary_gray")
    static let app_primary_green_0_1         = UIColor(named: "app_primary_green_0_1")
    static let app_primary_green_0_4         = UIColor(named: "app_primary_green_0_4")
    static let app_primary_green_0_6         = UIColor(named: "app_primary_green_0_6")
    static let app_primary_green_0_8         = UIColor(named: "app_primary_green_0_8")
    static let app_primary_green             = UIColor(named: "app_primary_green")
    static let app_primary_purple_0_1        = UIColor(named: "app_primary_purple_0_1")
    static let app_primary_purple_0_4        = UIColor(named: "app_primary_purple_0_4")
    static let app_primary_purple_0_6        = UIColor(named: "app_primary_purple_0_6")
    static let app_primary_purple_0_8        = UIColor(named: "app_primary_purple_0_8")
    static let app_primary_purple            = UIColor(named: "app_primary_purple")
    static let app_primary_red_0_1           = UIColor(named: "app_primary_red_0_1")
    static let app_primary_red_0_4           = UIColor(named: "app_primary_red_0_4")
    static let app_primary_red_0_6           = UIColor(named: "app_primary_red_0_6")
    static let app_primary_red_0_8           = UIColor(named: "app_primary_red_0_8")
    static let app_primary_red               = UIColor(named: "app_primary_red")
    static let app_primary_yellow_0_1        = UIColor(named: "app_primary_yellow_0_1")
    static let app_primary_yellow_0_4        = UIColor(named: "app_primary_yellow_0_4")
    static let app_primary_yellow_0_6        = UIColor(named: "app_primary_yellow_0_6")
    static let app_primary_yellow_0_8        = UIColor(named: "app_primary_yellow_0_8")
    static let app_primary_yellow            = UIColor(named: "app_primary_yellow")
    static let app_white                     = UIColor(named: "app_white")
    static let app_Off_White                 = UIColor(named: "app_Off_White")

    
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
