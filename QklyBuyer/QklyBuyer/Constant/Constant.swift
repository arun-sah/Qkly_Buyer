//
//  Constant.swift
//  QklyBuyer
//
//  Created by arun sah on 18/01/2023.
//

import Foundation
import CoreGraphics

let kSalaryCollectionViewCellHeight: CGFloat = 70.0
let kBenefitsCollectionViewCellHeight: CGFloat = 25.0

enum Constant {
    enum paymentConstant{
        static let urlString = "https://connect.stripe.com/express/oauth/authorize?client_id="
    }
    
    /// enum for UserDefault keys
    enum UserDefaultKey: String {
        case appLaunched
        case filter
        case useYourLocationShown
        case searchResult
        var name: String { return self.rawValue }
    }
    
    enum KeychainKey: String {
        case deviceID = "qklyBuyer-uuid"
    }
    
    /// enum for notification
    enum NotificationName: String {
        case unauthorized
        /// key to transfer data using user info
        var key: String {
            self.rawValue
        }
        /// notification name
        var notificationName: Notification.Name {
            return Notification.Name(self.rawValue)
        }
    }
    
    enum GoogleAPICredential {
        static let baseURL: String = "https://maps.googleapis.com/maps/api/"
        static let APIKey: String = ""
    }
    
    enum LinkedinCredential {
        static let permissions = ["r_liteprofile", "r_emailaddress"]
    }
    enum AppInfo {
        /// the build number of current app
        static let buildNumber: String? = { Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String }()
        /// the version number of current app
        static let versionNumber: String? = { Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String }()
    }
    
    enum RemoteInfoKeys: String {
        case forceUpdateRequired = "ios_force_update_required"
    }
    
    enum QklyMiscURLs: String {
        case invoicepreview = "invoicing/preview/"
    }

    enum ConfigFileVariableName:String{
        case AzureHubName = "AZURE_HUBNAME"
        case AzureMessagingConnectionString = "AZURE_MESSAGING_CONNECTION_SHAREDKEY"
        case GiphyCredentialApiKey = "GiphyCredential"
        case GoogleAPICredential_clientID = "GoogleAPICredential_clientID"
        case GoogleAPICredential_serverClientID = "GoogleAPICredential_serverClientID"
        case Server_Url = "Server_Url"
        case Invoice_CheckUrl = "Invoice_CheckUrl"
        case Payment_clientId = "Payment_clientId"
        case LinkedinCredential_clientID = "LinkedinCredential_clientID"
        case LinkedinCredential_clientSecret = "LinkedinCredential_clientSecret"
        case LinkedinCredential_redirectURL = "LinkedinCredential_redirectURL"
        case LinkedinCredential_state = "LinkedinCredential_state"
        case QklyMiscURLs_baseUrl = "QklyMiscURLs_baseUrl"
        case QklyMiscURLs_termsAndConditions = "QklyMiscURLs_termsAndConditions"
        case QklyMiscURLs_privacyPolicy = "QklyMiscURLs_privacyPolicy"
        case QklyMiscURLs_jobbardId = "QklyMiscURLs_jobbardId"
        
    }
}
