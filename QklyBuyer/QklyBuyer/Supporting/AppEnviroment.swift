//
//  AppEnviroment.swift
//  QklyBuyer
//
//  Created by arun sah on 19/01/2023.
//

import Foundation

/// The staging environment
struct AppEnviroment: Environment {
    
    var marketplaceBaseURL: URL {
        let configFileValue = Configuration.getvalue(for: BaseURLFromConfigFile.MarketPlace.rawValue)
        if configFileValue.isEmpty { fatalError(CustomAppString.CofigFileEmptyString(BaseURLFromConfigFile.MarketPlace.rawValue).key)}
        return URL(string: "https://\(configFileValue)/")!
    }
    
    var peopleBaseURL: URL {
        let configFileValue = Configuration.getvalue(for: BaseURLFromConfigFile.People.rawValue)
        if configFileValue.isEmpty { fatalError(CustomAppString.CofigFileEmptyString(BaseURLFromConfigFile.People.rawValue).key)}
        return URL(string: "https://\(configFileValue)/")!
    }
    
    var apiBaseURL: URL {
        let configFileValue = Configuration.getvalue(for: BaseURLFromConfigFile.ApiBase.rawValue)
        if configFileValue.isEmpty { fatalError(CustomAppString.CofigFileEmptyString(BaseURLFromConfigFile.ApiBase.rawValue).key)}
        return URL(string: "https://\(configFileValue)/")!
    }
    var profileBaseURL: URL {
        let configFileValue = Configuration.getvalue(for: BaseURLFromConfigFile.Profile.rawValue)
//        let value = Util.readPlistValue(key: "PROFILEBASEURL")
        if configFileValue.isEmpty { fatalError(CustomAppString.CofigFileEmptyString(BaseURLFromConfigFile.Profile.rawValue).key)}
        return URL(string: "https://\(configFileValue)/")!
    }
    var jobboardBaseURL: URL {
        let configFileValue = Configuration.getvalue(for: BaseURLFromConfigFile.JobBoard.rawValue)
        if configFileValue.isEmpty { fatalError(CustomAppString.CofigFileEmptyString(BaseURLFromConfigFile.JobBoard.rawValue).key)}
        return URL(string: "https://\(configFileValue)/")!
    }
    var authBaseURL: URL {
        let configFileValue = Configuration.getvalue(for: BaseURLFromConfigFile.Auth.rawValue)
        if configFileValue.isEmpty { fatalError(CustomAppString.CofigFileEmptyString(BaseURLFromConfigFile.Auth.rawValue).key)}
        return URL(string: "https://\(configFileValue)/")!
    }
}
