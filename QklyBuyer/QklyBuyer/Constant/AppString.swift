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
    case signinQklyFaceid = "Sign in quickly using your Face ID."
    case signinQklyFingerprint = "Sign in quickly using your Fingerprint."
   case enableFaceId = "Enable Face ID"
    case enableFingerprint = "Enable Fingerprint"
    case loginToYourAccount = "Log in to your account"
    case enterUsernamePassword = "Enter Username/Password"
    case ranInto = "Ran into"
    case trouble = " trouble?"
    case forgotDesc = "Don’t worry we got you covered\nEnter your email and we’ll send you the \ninstructions."
    case didntSeeIt = "Didn't see it?"
    case contactUs = " Contact Us"
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

