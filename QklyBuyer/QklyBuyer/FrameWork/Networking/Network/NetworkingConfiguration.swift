//
//  NetworkingConfiguration.swift
//  QklyBuyer
//
//  Created by arun sah on 18/01/2023.
//
import Foundation

/// The configuration required for Networking
public struct NetworkingConfiguration {
    
    /// The client to use
    let client: Client
    
    /// The TokenManager
    let tokenManager: TokenManager
    
    /// The CacheManager
    let cacheManager: CacheManager
}
