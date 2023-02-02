//
//  UIFont.swift
//  QklyBuyer
//
//  Created by arun sah on 20/01/2023.
//


import UIKit

enum AppFontWeight: String{
    case bold = "Bold"
    case extraBold = "ExtraBold"
    case light = "Light"
    case medium = "Medium"
    case regular = "Regular"
    case semiBold = "SemiBold"
    case thin = "Thin"
    
    var fontName: String{
        return "Montserrat-\(self.rawValue)"
    }
}

extension UIFont {
    static func appFont(ofSize size: AppFontSize, weight: AppFontWeight) -> UIFont {
        let font = UIFont(name: weight.fontName, size: size.value)
        return font!
    }
    static func appExtraBoldFont(ofSize size: AppFontSize) -> UIFont {
        let font = UIFont(name: AppFontWeight.extraBold.fontName, size: size.value)
        return font!
    }
    static func appBoldFont(ofSize size: AppFontSize) -> UIFont {
        let font = UIFont(name: AppFontWeight.bold.fontName, size: size.value)
        return font!
    }
    static func appSemiBoldFont(ofSize size: AppFontSize) -> UIFont {
        let font = UIFont(name: AppFontWeight.semiBold.fontName, size: size.value)
        return font!
    }
    static func appLightFont(ofSize size: AppFontSize) -> UIFont {
        let font = UIFont(name: AppFontWeight.light.fontName, size: size.value)
        return font!
    }
    static func appMediumFont(ofSize size: AppFontSize) -> UIFont {
        let font = UIFont(name: AppFontWeight.medium.fontName, size: size.value)
        return font!
    }
    static func appRegularFont(ofSize size: AppFontSize) -> UIFont {
        let font = UIFont(name: AppFontWeight.regular.fontName, size: size.value)
        return font!
    }
    static func appThinFont(ofSize size: AppFontSize) -> UIFont {
        let font = UIFont(name: AppFontWeight.thin.fontName, size: size.value)
        return font!
    }
    
}

enum AppFontSize {
    case size_32
    case size_24
    case size_20
    case size_16
    case size_14
    case size_12
    case size_10
    
    var value: CGFloat {
        let isPad = UIDevice.current.userInterfaceIdiom == .pad
        switch self {
        case .size_32:
            return isPad ? 40.0 : 32.0
        case .size_24:
            return isPad ? 32.0 : 24.0

        case .size_20:
            return isPad ? 28.0 : 20.0

        case .size_16:
            return isPad ? 24.0 : 16.0

        case .size_14:
            return isPad ? 22.0 : 14.0

        case .size_12:
            return isPad ? 20.0 : 12.0

        case .size_10:
            return isPad ? 18.0 : 10.0

        }
    }
}
