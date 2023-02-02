//
//  Menu+Data.swift
//  QklyBuyer
//
//  Created by arun sah on 02/02/2023.
//

import Foundation
import UIKit


public protocol MenuData {
    var title: String{get}
}
enum MenuSectionData: String, CaseIterable,MenuData {
    var title: String{return self.rawValue}
    
    case Profile = "Profile"
    case jobBoard = "Job Board"
    case freelance = "Freelance"
    case other   = "Others"
}

enum MenuProfileData: String, MenuData {
    case myProfile = "My Profile"
    case myAccount = "My Account"
    case myProfilePayoutSettings = "PayoutSettings"
    var title: String{return self.rawValue}
    
    var image:UIImage{
        switch self {
        case .myProfile, .myAccount:
            return UIImage.icon_Web!
        case .myProfilePayoutSettings:
            return UIImage()
        }
    }
    
    var isLoginRequired:Bool {
        return true
    }
    
    static let allCases: [MenuProfileData] = [.myProfile ,.myAccount]
    
}



enum MenuJobBoardData: String,MenuData {
    
    static let allCases: [MenuJobBoardData] = [.searchJobs, .exploreCompanies, .compareCompanies,  .writeAReview, .myApplication, .myFavorites]
    
    case searchJobs = "Search Jobs"
    case exploreCompanies = "Explore Companies"
    case myApplication = "My Applications"
    case myFavorites = "My Favorites"
    case myFavoriteCompany = "My Favorite Company"
    case compareCompanies = "Compare Companies"
    case writeAReview = "Write a review"
    
    var title: String{return self.rawValue}
    
    
    }
    
   
    


enum FreeLanceData: MenuData {
  
    case searchForWork
    case myWork
    case favoriteWork
    case myTimecard
    case myProjects
    
    case invoiceAndEarnings
    
    static let allCases: [FreeLanceData] = [.searchForWork, .myWork, .favoriteWork, .myTimecard, .invoiceAndEarnings]
  
    var title: String{
        switch self {
        case .searchForWork:
            return "Search For Work"
        case .myWork:
            return "My Work"
        case .favoriteWork:
            return "Favorite Work"
        case .myTimecard:
            return "Timecard"
        case .myProjects:
            return "My Projects"
       
        case .invoiceAndEarnings:
            return "Invoice & Earning"
        }
    }
}

enum othersData: String, CaseIterable,MenuData {
  
    case bioMetricId = "Biometric Login"
    case signOut = "Sign Out"
    
    var title: String{return self.rawValue}
    
    var showForGuest: Bool {
        switch self {
        case .signOut,.bioMetricId:
            return false
        }
    }
    
}


enum BiometricType {
    case none
    case touchID
    case faceID
}
