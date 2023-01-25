//
//  Config.swift
//  QklyBuyer
//
//  Created by arun sah on 18/01/2023.
//

import Foundation
import Alamofire

/// This config class will hold the configurations for the framework
class Config {
    
    /// The clientConfig
    var clientConfig: ClientConfig!
    
    /// The default networking headers

    private var defaultHeaders: [HTTPHeader] { [ HTTPHeader.contentType("application/json, text/plain, application/pdf, */*"), HTTPHeader.accept("application/json, text/plain, application/pdf, */*")] }
    
   
    
    /// Shared instance of the config
    static let `default` = Config()
    private init() {}
    
    /// Server URL for the API base
    lazy var serverURL: URL = {
       
        return clientConfig!.environment.authBaseURL.appendingPathComponent("api/v1/")
    }()

    /// google base URL
    lazy var googleAPIURL: URL = {
        return clientConfig!.environment.googleBaseURL
    }()
    
    func httpHeaders(addingHeader header: [HTTPHeader?]? = nil) -> HTTPHeaders {
        var allHeaders = HTTPHeaders(defaultHeaders)
        guard let header = header else { return allHeaders }
        let acceptableHeaders = header.compactMap { $0 }
        acceptableHeaders.forEach {
            allHeaders.add($0)
        }
        return allHeaders
    }
    func getbaseurlType(apitype: baseURLType) -> URL {
       
        switch apitype {
        case .marketplace:
            return clientConfig!.environment.marketplaceBaseURL.appendingPathComponent("api/v1/")
        case.jobBoard:
            return clientConfig!.environment.jobboardBaseURL.appendingPathComponent("api/v1/")
        case .people:
           return clientConfig!.environment.peopleBaseURL.appendingPathComponent("api/v1/")
        case .profile:
           return clientConfig!.environment.profileBaseURL.appendingPathComponent("api/v1/")
        case .auth:
            return clientConfig!.environment.authBaseURL.appendingPathComponent("api/v1/")
        }
        
    }
  
}
