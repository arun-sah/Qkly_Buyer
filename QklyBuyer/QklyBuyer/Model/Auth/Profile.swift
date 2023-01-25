//
//  Profile.swift
//  QklyBuyer
//
//  Created by arun sah on 24/01/2023.
//



import Foundation

enum SkillLevelEnum: Int, CaseIterable {
    case beginner = 1
    case fundamentals = 2
    case intermediate = 3
    case advanced = 4
    case master = 5
    
    var description: String{
        switch self {
        case .beginner:
            return "Basic: Beginner knowledge of this skill"
        case .fundamentals:
            return "Fundamentals: Working knowledge of this skill"
        case .intermediate:
            return "Intermediate: Proficient knowledge and some advanced skill"
        case .advanced:
            return "Advanced: High level knowledge of this skill"
        case .master:
            return "Master: Master level knowledge of this skill"
        }
    }
    
    func name(from levels: [SkillLevel]) -> String? {
        levels.filter({$0.ratingNumber == self.rawValue}).first?.name
    }
    
    func id(from levels: [SkillLevel]) -> String? {
        levels.filter({$0.ratingNumber == self.rawValue}).first?.id
    }
    
}


struct Skill: Codable, Equatable {
    
    static func == (lhs: Skill, rhs: Skill) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: String
    let name: String
    let isCustom: Bool?
    
    //skillLevel: local variable
    var skillLevel: SkillLevelEnum?
    
    enum CodingKeys: CodingKey{
        case id, name, isCustom
    }
}

struct ProfileSkill: Codable {
    let id: String
    let profileId: String
    let skillId: String
    let skillLevelId: String
    let skill: Skill
}

struct SkillLevel: Codable{
    let id: String
    let name: String
    let ratingNumber: Int
    
    var level: SkillLevelEnum?{
        SkillLevelEnum(rawValue: ratingNumber)
    }
}

struct ProfileStrengthResponse: Codable {
    let profileId: String
    let profileStrengthPercentage: Int
    let profileStrength: [ProfileStrength]
}

struct ProfileStrength: Codable {
    let name: String
    let isSubmitted: Bool
}

struct ProfileExperience: Codable {
    let id: String
    let profileId: String
    let companyName: String
    let city: String
    let state: String
    let title: String
    let startDate: String
    let endDate: String?
    let isCurrentlyWorking: Bool
    let description: String
    let created: String
    let lastModified: String?
    
    var dateString: String {
        guard startDate != "" else {return ""}
        var dateString = ""
        let dateFormatter = DateFormatter()
        let dateFormatterFormatted = DateFormatter()
        dateFormatterFormatted.dateFormat = "MMM YYYY"
        dateFormatter.dateFormat = "YYYY-MM-dd'T'hh:mm:ss"
        if let date = dateFormatter.date(from: startDate) {
           dateString += dateFormatterFormatted.string(from: date)
            if let enddate = endDate, let endDate = dateFormatter.date(from: enddate) {
                let _date = dateFormatterFormatted.string(from: endDate)
                dateString += " - \(_date)"
            }else{
                dateString += " - present"
            }
            return dateString
        }else {
            return ""
        }
    }
}

// MARK: - LanguageListResponse
struct LanguageListResponse: Codable {
    let languageListDto: [LanguageListItem]
}

// MARK: - LanguageListItem
struct LanguageListItem: Codable {
    let id, name: String
}

struct ProfileLanguageResponse: Codable {
    let profileLanguageDtos: [ProfileLanguageItem]
}

struct ProfileLanguageItem: Codable {
    let id: String
    let profileId: String
    let languageId: String
    let languageName: String
    let fluencyName: String
    let fluency: Int
}

struct ProfilePortfolioItem: Codable {
    let id: String
    let fileUrl: String
    let title: String
    let description: String
}

struct ProfileCertificationResponse: Codable {
    let profileCertificationList: [ProfileCertificateItem]
}

struct ProfileCertificateItem: Codable{
    let id: String
    let profileId: String
    let certification: ProfileCertificate
    let licenseNumber: String?
    let year: String
}

struct ProfileCertificate: Codable {
    let id: String
    let name: String
}

struct ProfileEducationResponse: Codable {
    let educationProfileListDtos: [ProfileEducationItem]
}

struct ProfileEducationItem: Codable {
    let id: String
    let profileId: String
    let educationId: String
    let areaOfStudy: String
    let school: String
    let startYear: Int?
    let endYear: Int?
    let isCurrentlyEnrolled: Bool
    let educationLevel: String
    let createdBy: String?
    let lastModifiedBy: String?
    let lastModified: String?
}

struct ProfileEducationListResponse: Codable {
    let educationListDto: [ProfileEducationListItem]
}

struct ProfileEducationListItem: Codable {
    let id: String
    let name: String
}

// MARK: - UploadProfilePictureResponse
struct UploadProfilePictureResponse: Codable {
    let fileID: String?
    let profileName, mimeType: String?
    let image, smallImage: String?

    enum CodingKeys: String, CodingKey {
        case fileID = "fileId"
        case profileName, mimeType, image, smallImage
    }
}

struct UploadDocumentResponse: Codable {
    let success: Bool?
    let result: String?
    let message: String?
}
