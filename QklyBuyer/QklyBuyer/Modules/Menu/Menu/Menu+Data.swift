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
enum MenuCellData: String, CaseIterable,MenuData {
    var title: String{return self.rawValue}
    
    case findFreelancer = "Find Freelancer"
    case myFreelancer = "My Freelancer"
    case favouriteFreelancer = "Favourite Freelancer"
    var image:UIImage{
            switch self {
            case .findFreelancer:
              return  UIImage.icon_search!
            case .myFreelancer:
                return UIImage.icon_freelancer!
            case .favouriteFreelancer:
                return UIImage.icon_fav!
            }
        }
}

enum MenuSectionData: String,CaseIterable, MenuData {
    case buyer = "Buyer"
    case postWork = "Post Work"
    case myWorkPost = "My Work Post"
    case freelancer = "Freelancer"
    case employer = "Employer"
    case postAjob = "Post a Job"
    case myJobPost = "My Job Post"
    case myCandidates = "My Candidates"
    case myCompanyProfile = "My Company Profile"
    case singleLine = ""
    case myInvoices = "My Invoices"
    case settings = "Settings"
    case logout = "Logout"
    
    var title: String{return self.rawValue}

    var image:UIImage{
        switch self {
      
        case .buyer:
            return UIImage()
        case .postWork:
            return UIImage.icon_post_work!
        case .myWorkPost:
            return UIImage.icon_post_work!
        case .freelancer:
            return UIImage.icon_freelancer!
        case .employer:
            return UIImage()
        case .postAjob:
            return UIImage.icon_post_work!
        case .myJobPost:
            return UIImage.icon_Add_job!
        case .myCandidates:
            return UIImage.icon_candidates!
        case .myCompanyProfile:
            return UIImage.icon_Company!
        case .myInvoices:
            return UIImage.icon_Invoice!
        case .settings:
           return UIImage.icon_Setting!
        case .logout:
           return UIImage.icon_Logout!
        case .singleLine:
            return UIImage()
        }
    }
    

   
    
}
//
//
//
//enum MenuJobBoardData: String,MenuData {
//
//    static let allCases: [MenuJobBoardData] = [.searchJobs, .exploreCompanies, .compareCompanies,  .writeAReview, .myApplication, .myFavorites]
//
//    case searchJobs = "Search Jobs"
//    case exploreCompanies = "Explore Companies"
//    case myApplication = "My Applications"
//    case myFavorites = "My Favorites"
//    case myFavoriteCompany = "My Favorite Company"
//    case compareCompanies = "Compare Companies"
//    case writeAReview = "Write a review"
//
//    var title: String{return self.rawValue}
//
//
//    }
//
//
//
//
//
//enum FreeLanceData: MenuData {
//
//    case searchForWork
//    case myWork
//    case favoriteWork
//    case myTimecard
//    case myProjects
//
//    case invoiceAndEarnings
//
//    static let allCases: [FreeLanceData] = [.searchForWork, .myWork, .favoriteWork, .myTimecard, .invoiceAndEarnings]
//
//    var title: String{
//        switch self {
//        case .searchForWork:
//            return "Search For Work"
//        case .myWork:
//            return "My Work"
//        case .favoriteWork:
//            return "Favorite Work"
//        case .myTimecard:
//            return "Timecard"
//        case .myProjects:
//            return "My Projects"
//
//        case .invoiceAndEarnings:
//            return "Invoice & Earning"
//        }
//    }
//}
//
//enum othersData: String, CaseIterable,MenuData {
//
//    case bioMetricId = "Biometric Login"
//    case signOut = "Sign Out"
//
//    var title: String{return self.rawValue}
//
//    var showForGuest: Bool {
//        switch self {
//        case .signOut,.bioMetricId:
//            return false
//        }
//    }
//
//}
//

enum BiometricType {
    case none
    case touchID
    case faceID
}
