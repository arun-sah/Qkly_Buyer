//
//  Framework.swift
//  QklyBuyer
//
//  Created by arun sah on 18/01/2023.
//
import UIKit
public struct Framework {
    
    /// The configuartion
    private let config: ClientConfig
    
    /// The current application
    private let application: UIApplication
    
    /// The launch options
    private let launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    
    /// public initilaizer
    public init(config: ClientConfig) {
        self.application = config.application
        self.launchOptions = config.launchOptions
        self.config = config
    }
    
    /// Method that will instantiate the farmework intial classes to work with
    @discardableResult
    public func initialize() -> Bool {
        // start the connection observer
        Connection.shared.observe()
        
        return true
    }
}
