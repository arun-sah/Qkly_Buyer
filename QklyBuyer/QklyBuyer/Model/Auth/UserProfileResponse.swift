//
//  UserProfileResponse.swift
//  QklyBuyer
//
//  Created by arun sah on 24/01/2023.
//


import Foundation

// MARK: - UserProfileResponse
struct UserProfileResponse: Codable {
    let id, name, firstName, lastName: String?
    let city, country, state, freeFormAddress: String?
    let zipCode: String?
    let userCity, userCountry, userState, userFreeFormAddress: String?
    let userZipCode: String?
    let ratingValue: Int?
    let countryCode, phoneNumber, profileURL, email, dialCode: String?
    let websiteURL: String?
    let isBackgroundChecked, hasCurrentSubscription: Bool?
    let subscriptionID, planName: String?
    let marketplaceEnabled, peopleEnabled: Bool?
    let subscription: String?
    let userName:String?

    enum CodingKeys: String, CodingKey {
        case id, name, firstName, lastName, city, country, state, freeFormAddress, zipCode, userCity, userCountry, userState, userFreeFormAddress, userZipCode, ratingValue, countryCode, phoneNumber, dialCode
        case profileURL = "profileUrl"
        case email
        case websiteURL = "websiteUrl"
        case isBackgroundChecked, hasCurrentSubscription, userName
        case subscriptionID = "subscriptionId"
        case planName, marketplaceEnabled, peopleEnabled, subscription
    }
}

