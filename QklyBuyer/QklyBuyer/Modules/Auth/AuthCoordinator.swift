//
//  AuthCoordinator.swift
//  QklyBuyer
//
//  Created by arun sah on 31/01/2023.
//

import Foundation
import Combine
import UIKit

class AuthCoordinator: BaseCoordinator {
    
    ///the main route
    let route: Route
    
    /// the user manager
    let userManager: UserManager
    
    /// The subcription cleanup bag
    public var bag = Set<AnyCancellable>()
    
    /// user defaults
    let defaults = UserDefaults.standard
    

    
    init(route: Route, userManager: UserManager) {
        self.route = route
  
        self.userManager = userManager
        super.init()
    }
    
    override func start(with deepLink: DeepLink?) {
        showBioMetricController()
        
    }
    private func showBioMetricController() {
        let viewModel = BioMetricViewModel(userManager: userManager)
        let controller = ControllerRoute.bioMetricController(viewmodel: viewModel)

        viewModel.trigger.sink { [weak self] route in
            guard let self = self else { return }
            self.handleRoutes(route)
        }.store(in: &bag)

        route.setRoot(controller, hideBar: true)
    }
   
     /// handle routes
    /// - Parameter route: app routable
    private func handleRoutes(_ route: AppRoutable) {
        switch route {
      
        default:
            return
            
        }
    }
}
