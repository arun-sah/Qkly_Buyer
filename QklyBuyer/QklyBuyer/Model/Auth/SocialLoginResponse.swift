//
//  SocialLoginResponse.swift
//  QklyBuyer
//
//  Created by arun sah on 24/01/2023.
//

import Foundation

// MARK: - SocialLoginResponse
struct SocialLoginResponse: Codable {
    let id, accessToken: String
    let expiresIn: Int
    let refreshToken: String?
    private let _hasEmail: String?
    
    var hasEmail: Bool {
        guard let _hasEmail else {return true}
        return _hasEmail == "true"
    }

    enum CodingKeys: String, CodingKey {
        case id
        case accessToken = "auth_token"
        case expiresIn = "expires_in"
        case refreshToken = "refreshToken"
        case _hasEmail = "has_email"
    }
}
