//
//  ForgotPasswordModel.swift
//  QklyBuyer
//
//  Created by arun sah on 24/01/2023.
//

import Foundation
struct ForgotPasswordModel: Codable {
    let success: Bool?
    let response: String?
    
}

struct ChangePhoneNumberModel: Codable {
    let success: Bool?
    let error: String?
    
}
