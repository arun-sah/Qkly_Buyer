//
//  DiFactory.swift
//  QklyBuyer
//
//  Created by arun sah on 18/01/2023.
//

import Foundation

/// User manager factory
struct UserManagerFactory: Factory {
    typealias Instance = UserManager
    
    static func get() -> UserManager {
        return UserManager(networking: NetworkingFactory.get())
    }
}
