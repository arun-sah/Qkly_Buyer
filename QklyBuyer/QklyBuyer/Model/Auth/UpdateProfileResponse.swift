//
//  UpdateProfileResponse.swift
//  QklyBuyer
//
//  Created by arun sah on 24/01/2023.
//
import Foundation

typealias UpdateProfileRequest = UpdateProfileResponse

struct UpdateProfileResponse: Codable {
    let profileID, firstName, lastName, country: String?
    let countryAbbreviation, state, city, zipCode: String?
    let countryCode, phoneNumber: String?
    let websiteURL: String?

    enum CodingKeys: String, CodingKey {
        case profileID = "profileId"
        case firstName, lastName, country, countryAbbreviation, state, city, zipCode, countryCode, phoneNumber
        case websiteURL = "websiteUrl"
    }
}
