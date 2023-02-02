//
//  BioMetricViewModel.swift
//  Qkly
//
//  Created by Arun Sah on 26/07/2022.
//

import Foundation
import UIKit
import LocalAuthentication
import KeychainSwift
import SwiftyAttributes

class BioMetricViewModel: BaseViewModel {
  
    let userManager: UserManager?

    var context = LAContext()
    let keychain = KeychainSwift()
    var isBiometrictrue = false
    
    
    /// initializer
    /// - Parameters:
    ///   - userManager: usermanager
    init(userManager: UserManager) {
        self.userManager = userManager
        super.init()
    }
   
}
