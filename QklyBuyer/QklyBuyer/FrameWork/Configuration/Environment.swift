//
//  Environment.swift
//  QklyBuyer
//
//  Created by arun sah on 18/01/2023.
//

import Foundation

public protocol Environment {
    
    /// The base URL for api
    var apiBaseURL: URL { get }
    /// The base URL for google
    var googleBaseURL: URL { get }
    
    var profileBaseURL: URL { get }
    
    var jobboardBaseURL: URL { get }
    
    var marketplaceBaseURL: URL { get }
    
    var peopleBaseURL: URL { get }
    
    var authBaseURL: URL { get }
    
}

enum BaseURLFromConfigFile: String {
    case MarketPlace = "MarketPlace_BaseURL"
    case People = "PEOPLEBASEURL"
    case ApiBase = "Api_BaseURL"
    case Profile = "PROFILEBASEURL"
    case JobBoard = "JOBBOARDBASEURL"
    case Auth = "Auth_BaseURL"
}

extension Environment {
    var googleBaseURL: URL {
        fatalError("Please provide the URL from environment, before using")
    }
}
