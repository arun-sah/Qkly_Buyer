//
//  AppString.swift
//  QklyBuyer
//
//  Created by arun sah on 19/01/2023.
//


import Foundation

enum AppString: String {
    case qkly = "Qkly"
    case buyer = "Buyer"
    case ok = "OK"
   
    var value: String {
        return self.rawValue
    }
}



enum CustomAppString {
    case CofigFileEmptyString(String)
    var key:String {
        switch self {
        case .CofigFileEmptyString(let str) :
            return "Please check config filevariable\(str)"
       
        }
    }
}

