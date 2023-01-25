//
//  AppCoordinator.swift
//  QklyBuyer
//
//  Created by arun sah on 19/01/2023.
//

import Foundation
import Combine
import UIKit

final class AppCoordinator: BaseCoordinator {
    
    /// The main route for the app
    private let route: Route
    
    /// The instance of userManager
    private let userManager: UserManager
    
    
    /// user defaults
    let defaults = UserDefaults.standard
    
    /// the deep link
    var deepLink: DeepLink?
    
    /// the dispose bag
    var bag = Set<AnyCancellable>()
    var userDefaultCacheManager = UserDefaultCacheManagerFactory.get()
    /// Initializer
    init(route: Route, userManager: UserManager) {
        self.route = route
        self.userManager = userManager
        super.init()
        self.getUserLocationDetail()
    }
    
    
    private func getUserLocationDetail() {
          let urlString = "http://ip-api.com/json"
        guard  let url = URL(string: urlString) else {return}
        let task = URLSession.shared.dataTask(with: url,completionHandler: {(data,responce,error) in
            var str = ""
            if error == nil{
                if let data = data {
                   str = String(decoding: data, as: UTF8.self)
                    print(str)
                    self.userDefaultCacheManager.set(String.self, value: str, key: FrameworkCacheKey.userLocationDetailFromAPIJson)
                }
            }
            self.userDefaultCacheManager.set(String.self, value: str, key: FrameworkCacheKey.userLocationDetailFromAPIJson)
        })
        task.resume()
      }
    
    
    /// Start the coordinator process
    override func start(with deepLink: DeepLink?) {
        // set deep link
        self.deepLink = deepLink
        performRedirection(with: self.deepLink)
    }
    private func performRedirection(with deeplink: DeepLink? = nil) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            let isonboardingDone = self.userDefaultCacheManager.get(Bool.self, forKey: FrameworkCacheKey.isOnboardingDone) ?? false
            if !isonboardingDone {
                self.runOnboardingCoordinator(with: deeplink)
                return
            }
           
            
            let loginSignUpDone = self.userDefaultCacheManager.get(Bool.self, forKey: FrameworkCacheKey.isLoginSignUpDone) ?? false
            let needsFBEmailUpdate = self.userDefaultCacheManager.get(Bool.self, forKey: FrameworkCacheKey.needsEmailUpdateFB) ?? false
            if loginSignUpDone && !needsFBEmailUpdate{
               // self.runSideMenuCoordinator(with: deeplink)
                return
                
            }
           // self.runAuthCoordinator(with: deeplink)
        }
    }
    /// runs auth coordinator
//    private func runAuthCoordinator(with deepLink: DeepLink?) {
//        // check if coordinator already exists
//        if let coordinator = self.getChild(type: AuthCoordinator.self) {
//
//            // coordinator already exists hence directly start
//            coordinator.start(with: deepLink)
//            return
//        }
//
//        let authCoordinator = AuthCoordinator(route: route, userManager: userManager)
//        authCoordinator.onFinish = { [weak self] in
//            guard let self = self else { return }
//            self.performRedirection()
//        }
//        coordinate(to: authCoordinator)
//    }
    
    /// runs Side menu coordinator
//    private func runSideMenuCoordinator(with deepLink: DeepLink?) {
//        // check if coordinator already exists
//        if let coordinator = self.getChild(type: SideMenuCoordinator.self) {
//
//            // coordinator already exists hence directly start
//            coordinator.start(with: deepLink)
//            return
//        }
//
//        let coordinator = SideMenuCoordinator(route: route, userManager: userManager, jobBoardManager: jobBoardManager, deepLink: deepLink)
//        coordinator.onFinish = { [weak self] in
//            guard let self = self else { return }
//            self.performRedirection()
//        }
//        coordinate(to: coordinator)
//    }
    
   
    private func runOnboardingCoordinator(with deepLink: DeepLink?) {
        if let coordinator = self.getChild(type: OnboardingCoordinator.self) {
            coordinator.start(with: deepLink)
            return
        }

        let onboardingCoordinator = OnboardingCoordinator(route: route)
        onboardingCoordinator.onFinish = { [weak self] in
            guard let self = self else {return}
            self.performRedirection()
        }
        coordinate(to: onboardingCoordinator)
    }

    /// clears deep link
    private func clearDeepLink() {
        self.deepLink = nil
    }
    
}
