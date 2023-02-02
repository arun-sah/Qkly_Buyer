//
//  DashBoardController.swift
//  QklyBuyer
//
//  Created by arun sah on 02/02/2023.
//

import Foundation
import UIKit
import SideMenuSwift


class DashboardController: BaseController {
    var viewModel: DashboardViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
   
    @IBAction func sidemenuButtonTapped(_ sender: Any) {
        sideMenuController?.revealMenu()
    }
    
}
