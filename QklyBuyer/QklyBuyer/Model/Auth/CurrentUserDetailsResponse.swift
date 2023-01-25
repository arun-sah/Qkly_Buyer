//
//  CurrentUserDetailsResponse.swift
//  QklyBuyer
//
//  Created by arun sah on 24/01/2023.
//


import Foundation

// MARK: - CurrentUserDetailsResponse
struct CurrentUserDetailsResponse: Codable {
    let profileID, fullName, email: String?
    let profileURL: String?
    let countryCode, phoneNumber: String?
    let dialCode: String?
    let isVeteran, showVeteran,isEmailVerified: Bool?
    var isMarketplaceEnabled, isPeopleEnabled: Bool?
    let locationDetails: LocationDetails?

    enum CodingKeys: String, CodingKey {
        case profileID = "profileId"
        case fullName, email, dialCode
        case profileURL = "profileUrl"
        case countryCode, phoneNumber, isVeteran, showVeteran, isMarketplaceEnabled, isPeopleEnabled, locationDetails,isEmailVerified
    }
}

// MARK: - LocationDetails
struct LocationDetails: Codable {
    let id, country: String?
    let userCountry, countryAbbreviation: String?
    let state: String?
    let userState, stateAbbreviation: String?
    let city: String?
    let userCity, cityAbbreviation: String?
    let freeFormAddress: String?
    let userFreeFormAddress: String?
    let zipCode, latitude, longitude, locationSourceID: String?
    let userZipCode: String?
    let locations: String?
    let createdBy, created, lastModifiedBy, lastModified: String?

    enum CodingKeys: String, CodingKey {
        case id, country, userCountry, countryAbbreviation, state, userState, stateAbbreviation, city, userCity, cityAbbreviation, freeFormAddress, userFreeFormAddress, zipCode, latitude, longitude
        case locationSourceID = "locationSourceId"
        case userZipCode, locations, createdBy, created, lastModifiedBy, lastModified
    }
}
