//
//  ClientConfig.swift
//  QklyBuyer
//
//  Created by arun sah on 18/01/2023.
//

import Foundation
import UIKit
import Alamofire

/// We will take the configuration form client side
public class ClientConfig {
    
    /// The current application
    public var application: UIApplication!
    
    /// The launch options of the application
    public var launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    
    /// The running environment of the app
    public var environment: Environment!
    
    /// The coreData model file name
    public var modelFileName: String?
    
    /// The coreData helper object
    
    /// Empty initailizer
    private init() {
        application = nil
        launchOptions = [:]
    }
    
    /// Initializer with closure initializer
    /// - Parameter config: the Self instance
    public convenience init(_ config: (ClientConfig) -> Void) {
        self.init()
        Config.default.clientConfig = self
        config(self)
        
        assert(application != nil, "UIApplication should be passed and cannot be ignored")
        assert(environment != nil, "Environement should be passed and cannot be nil")
    }
    
}
