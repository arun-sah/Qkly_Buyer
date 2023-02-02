//
//  CongratulationViewModel.swift
//  Qkly
//
//  Created by Arun Sah on 05/05/2022.
//

import Foundation



class CongratulationViewModel: BaseViewModel {
  
    let userManager: UserManager?

    /// initializer
    /// - Parameters:
    ///   - userManager: usermanager
    init(userManager: UserManager) {
        self.userManager = userManager
        super.init()
    }
   
}


