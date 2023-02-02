//
//  DashBoardCoordinator.swift
//  QklyBuyer
//
//  Created by arun sah on 02/02/2023.
//


import UIKit
import Combine
import SideMenuSwift

class DashboardCoordinator: BaseCoordinator {
    
    /// the user manager
    let userManager: UserManager
  
    let sideMenuModel: MenuViewModel
    
    /// the app route
    let route: Route
            
    /// bag
    var bag = Set<AnyCancellable>()
    
    /// initializer
    /// - Parameter userManager: user manager
    /// - Parameter route: route
    init(userManager: UserManager, route: Route, sideMenuModel: MenuViewModel) {
        self.userManager = userManager
      
        self.sideMenuModel = sideMenuModel
        self.route = route
        super.init()
    }
    
    override func start(with deepLink: DeepLink?) {
    }
    
    /// show dashboard controller
     func showDashboard()-> UIViewController {
         if Thread.isMainThread {
             let viewmodel = DashboardViewModel(userManager: userManager)
             let controller = ControllerRoute.dashboardController(viewmodel: viewmodel)
             viewmodel.trigger.sink { [weak self] route in
                 guard let self = self else { return }
                 self.handleRouteTriggers(route)
             }.store(in: &viewmodel.bag)
             return controller
         } else {
             return UIViewController()
         }
    }
    

    
    /// handles route triggers
    /// - Parameter route: route
    private func handleRouteTriggers(_ route: AppRoutable) {
            switch route {
        case AuthRoute.finish:
            self.finish()
                return
            default:
                break
            }
            return
        }
        
       
    
}
