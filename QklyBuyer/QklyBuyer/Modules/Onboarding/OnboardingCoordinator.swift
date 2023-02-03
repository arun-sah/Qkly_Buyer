//
//  OnboardingCoordinator.swift
//  Qkly
//
//  Created by Asmin Ghale on 1/21/22.
//

import UIKit
import Combine

class OnboardingCoordinator: BaseCoordinator {
    
    let route: Route
    
    /// The subcription cleanup bag
    public var bag = Set<AnyCancellable>()

    
    init(route: Route) {
        self.route = route
        super.init()
    }
    
    override func start(with deepLink: DeepLink?) {
        showOnboarding()
    }
    
    private func showOnboarding() {
//        let onboardingViewModel  = OnboardingViewModel()
//        let onboardingController = ControllerRoute.onboardingController(viewmodel: onboardingViewModel)
//        onboardingViewModel.trigger.sink { [weak self] route in
//            guard let self = self else { return }
//            self.handleRoutes(route)
//        }.store(in: &bag)
        
        let controller = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginController")

        route.setRoot(controller, hideBar: true)
    }
    
    
       /// handle routes
       /// - Parameter route: app routable
       private func handleRoutes(_ route: AppRoutable) {
           switch route {
           
           case AuthRoute.finish:
               self.finish()
           default:
               return
               
           }
       }
    
}
