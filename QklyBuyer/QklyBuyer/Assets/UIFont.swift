//
//  UIFont.swift
//  QklyBuyer
//
//  Created by arun sah on 20/01/2023.
//


import UIKit

enum AppFontWeight: String{
    case bold = "Bold"
    case light = "Light"
    case medium = "Medium"
    case regular = "Regular"
    case semiBold = "SemiBold"
    
    var fontName: String{
        return "Montserrat-\(self.rawValue)"
    }
    
}

extension UIFont {
    static func appFont(ofSize size: CGFloat, weight: AppFontWeight) -> UIFont {
        let font = UIFont(name: weight.fontName, size: size)
        return font!
    }
}
