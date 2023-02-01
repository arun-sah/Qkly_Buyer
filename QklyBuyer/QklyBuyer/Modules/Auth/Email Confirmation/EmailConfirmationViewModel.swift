//
//  EmailConfirmationViewModel.swift
//  QklyBuyer
//
//  Created by arun sah on 01/02/2023.
//


import Foundation
import Combine
import Alamofire

class EmailConfirmationViewModel: BaseViewModel {
    
    let userManager: UserManager
    
    init(userManager: UserManager) {
        self.userManager = userManager
        super.init()
    }
    
    
    
}
