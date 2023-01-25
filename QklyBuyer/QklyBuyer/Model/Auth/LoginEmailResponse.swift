//
//  LoginEmailResponse.swift
//  QklyBuyer
//
//  Created by arun sah on 24/01/2023.
//

import Foundation

struct LoginEmailResponse: Codable {
    let statusCode: Int
    let message: String?
    let data: [LoginAccessToken]
}

// MARK: - Datum
struct LoginAccessToken: Codable {
    let accessToken: String
    let expiresIn: Int
    let refreshToken: String?
}

extension Token {
    init(result: LoginAccessToken){
        self.accessToken = result.accessToken
        self.accountIdentifier = ""
        self.accessTokenExpiresIn = Date.init(timeIntervalSinceNow: TimeInterval(result.expiresIn))
        self.refreshedDate = Date()
        self.expiresIn = Date.init(timeIntervalSinceNow: TimeInterval(result.expiresIn))
        self.refreshToken = result.refreshToken ?? ""
    }
}

extension Token {
    init(result: SocialLoginResponse){
        self.accessToken = result.accessToken
        self.accountIdentifier = ""
        self.accessTokenExpiresIn = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        self.refreshedDate = Date()
        self.expiresIn = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        self.refreshToken = result.refreshToken ?? ""
    }
}
