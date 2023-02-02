//
//  SideMenuModel.swift
//  Qkly
//
//  Created by Arun Sah on 21/01/2022.
//

import Foundation
import UIKit


class MenuViewModel: BaseViewModel {
    let userManager: UserManager?
    var selectedSidemenuType: MenuData?
    init(userManager: UserManager, selectedSidemenuType:MenuData?) {
        self.selectedSidemenuType = selectedSidemenuType
        self.userManager = userManager
        
    }
    
    var freelanceMenuItemsEnabled: [FreeLanceData] = FreeLanceData.allCases
    
    var freelanceMenuItemsForDisabled: [FreeLanceData] = [.searchForWork, .myWork, .favoriteWork]

    
}
