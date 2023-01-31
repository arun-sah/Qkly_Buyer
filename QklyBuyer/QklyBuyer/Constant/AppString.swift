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
    case faceId = "Face ID "
    case fingerPrint = "Fingerprint "
    case login = "Login"
    case signinQklyFaceid = "Sign in quickly using your \n Face ID."
    case signinQklyFingerprint = "Sign in quickly using your \n Fingerprint."
   case enableFaceId = "Enable Face ID"
    case enableFingerprint = "Enable Fingerprint"
    case loginToYourAccount = "Log in to your account"
    case enterUsernamePassword = "Enter Username/Password"
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

