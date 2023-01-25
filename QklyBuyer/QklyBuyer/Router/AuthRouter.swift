//
//  AuthRouter.swift
//  QklyBuyer
//
//  Created by arun sah on 19/01/2023.
//

import Foundation
import Alamofire

enum AuthRouter: NetworkingRouter {
    case login(Parameters)
    case register(Parameters)
    case forgotPassword(String)
    case changepassword(Parameters)
    case googleLogin(Parameters)
    case facebookLogin(Parameters)
    case linkedInLogin(Parameters)
    case appleLogin(Parameters)
    
    var path: String {
        switch self {
            
        case .login:
            return "auth/tokenv2"
            
        case .register:
            return "profile"
        case .forgotPassword(let email):
            return "profile/forget/password/\(email)"
            
        case .changepassword(_):
            return "user/changepassword"
            
        case .googleLogin:
            return "auth/token/google/socialIdentifier"
        case .facebookLogin:
            return "auth/facebook/mobile/signin"
        case .linkedInLogin:
            return "auth/token/linkedin/mobile/socialIdentifier"
        case .appleLogin:
            return "auth/apple/mobile/signin"
        }
    }
    
    var httpMethod: RequestMethod {
        switch self {
        case  .login, .register, .googleLogin, .facebookLogin, .linkedInLogin, .appleLogin:
            return .post
        case .forgotPassword:
            return .get
            
        case .changepassword:
            return .put
        }
    }
    
    var needTokenValidation: Bool {
        switch self {
        case  .login, .register,.forgotPassword, .googleLogin, .facebookLogin, .linkedInLogin, .appleLogin:
            return false
            
            
        case .changepassword(_):
            return true
        }
    }
    var baseurltype: baseURLType{
        switch self {
        case .login,.changepassword, .googleLogin, .facebookLogin, .linkedInLogin, .appleLogin:
            return .auth
        case .register,.forgotPassword:
            return .profile
        }
    }
    
    
    var encoders: [RequestEncoder] {
        switch self {
        case .login(let parameters),
                .register(let parameters),.changepassword(let parameters), .googleLogin(let parameters), .facebookLogin(let parameters), .linkedInLogin(let parameters), .appleLogin(let parameters):
            return [.json(parameters)]
        case .forgotPassword:
            return [.none]
            
        }
    }
}


