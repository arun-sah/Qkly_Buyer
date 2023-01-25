//
//  ProfileDetailResponse.swift
//  QklyBuyer
//
//  Created by arun sah on 24/01/2023.
//

import Foundation

// MARK: - ProfileDetailResponse
struct ProfileDetailResponse: Codable {
    let id, fullName, firstName, lastName: String?
    let freeFormAddress, country: String?
    let isBackgroundChecked, isTopProvider: Bool?
    let headline, professionalBio: String?
    let ratingValue: Int?
    let websiteURL: String?
    let profileLink, availability: String?
    let isFavorite: Bool?
    let email, phoneNumber: String?
    let profileURL, latestExperienceTitle: String?
    let latitude, longitude: String?
    let paymentFrom, paymentTo: Int?
    let userName: String?
    let marketplaceEnabled: Bool?
   // let socialMediaList: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case id, fullName, firstName, lastName, freeFormAddress, country, isBackgroundChecked, isTopProvider, headline, professionalBio, ratingValue
        case websiteURL = "websiteUrl"
        case profileLink, availability, isFavorite, email, phoneNumber
        case profileURL = "profileUrl"
        case latestExperienceTitle, latitude, longitude, paymentFrom, paymentTo, userName, marketplaceEnabled
    }
}

