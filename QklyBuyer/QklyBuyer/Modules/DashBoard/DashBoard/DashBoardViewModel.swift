//
//  DashBoardViewModel.swift
//  QklyBuyer
//
//  Created by arun sah on 02/02/2023.
//
import Foundation

class DashboardViewModel: BaseViewModel {
    
    let userManager: UserManager
  
    
    init(userManager: UserManager) {
        self.userManager = userManager
       
    }
}
