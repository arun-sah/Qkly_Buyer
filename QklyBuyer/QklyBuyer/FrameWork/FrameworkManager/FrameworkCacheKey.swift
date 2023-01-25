//
//  FrameworkCacheKey.swift
//  QklyBuyer
//
//  Created by arun sah on 18/01/2023.
//

import Foundation

/// These are the cache keys used with the framework
public enum FrameworkCacheKey: String, CacheKeyable {
    case user
    case token
    case deviceId
    case appleUser
    case profileViewData
    case profilePicture
    case isOnboardingDone
    case isLoginSignUpDone
    case isGuestLogin
    case loginID
    case password
    case isFaceid
    case isFirstloginComplete
    case userLocationDetailFromAPIJson
    case needsEmailUpdateFB
    public var name: String { return self.rawValue }
    public var entityName: String { return "" }
}

