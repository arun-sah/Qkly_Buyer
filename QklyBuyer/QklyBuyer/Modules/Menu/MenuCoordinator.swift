//
//  SideMenuCoordinator.swift
//  Qkly
//
//  Created by Arun Sah on 21/01/2022.
//


import Foundation
import Combine
import UIKit
import SideMenuSwift

class MenuCoordinator: BaseCoordinator {
    
    ///the main route
    let route: Route
    
    /// the user manager
    let userManager: UserManager
    
    /// The subcription cleanup bag
    public var bag = Set<AnyCancellable>()
    
    /// deeplink
    var deeplink: DeepLink?
    /// the tab bar controller
    
    
    var sideMenuViewModel: MenuViewModel!
    
    init(route: Route, userManager: UserManager,deepLink:DeepLink?) {
        self.route = route
        self.userManager = userManager
       
        self.sideMenuViewModel = MenuViewModel(userManager: userManager, selectedSidemenuType: MenuSectionData.postAjob)
        super.init()
        sideMenuViewModel.trigger.sink { [weak self] route in
            guard let self = self else { return }
            self.handleRoutes(route)
        }.store(in: &bag)
    }
    
    override func start(with deepLink: DeepLink?) {
      
                let controller = SideMenuController(contentViewController: runDashboard(),menuViewController: showSideMenu(sideMenuType: nil))
                route.setRoot(controller)
        
    }
    private func showSideMenu(sideMenuType:MenuData?) -> UIViewController {
        self.sideMenuViewModel = MenuViewModel(userManager: userManager, selectedSidemenuType: sideMenuType)
        let controller = ControllerRoute.menuController(viewmodel: self.sideMenuViewModel)
            self.sideMenuViewModel.trigger.sink { [weak self] route in
            guard let self = self else { return }
            self.handleRoutes(route)
        }.store(in: &bag)

        return  controller
    }
  
    private func runDashboard() -> UIViewController {
        let coordinator = DashboardCoordinator(userManager: self.userManager, route: route, sideMenuModel: self.sideMenuViewModel)
        coordinator.onFinish = {[weak self] in
            guard let self = self else {return}
            self.finish()
        }
        self.coordinate(to: coordinator, deepLink: self.deeplink)
        return coordinator.showDashboard()
    }
  
   
    /// handle routes
    /// - Parameter route: app routable
    private func handleRoutes(_ route: AppRoutable) {
        switch route {
        case AuthRoute.finish:
            self.finish()
      
        default:
            break
        }
        
    }
    /// clears deep link
    private func clearDeepLink() {
        self.deeplink = nil
    }
}
