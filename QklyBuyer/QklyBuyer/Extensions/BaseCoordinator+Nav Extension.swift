//
//  BaseCoordinator+Nav Extension.swift
//  Qkly
//
//  Created by Asmin Ghale on 7/27/22.
//

import Foundation


//extension BaseCoordinator {
//
//    func handleNavigationRoutes(navRoute: NavigationItemRoute, route: Route, deeplink: DeepLink?, sidemenuModel: MenuViewModel?) {
//        switch navRoute {
//        case .profile:
//            sidemenuModel?.trigger.send(menuControllerRoute.index(MenuProfileData.myProfile))
//            break
//        case .sideMenu:
//            break
//        case .chat:
//            showChat(route: route, deeplink: deeplink, sidemenuModel: sidemenuModel!)
//            break
//        case .notificationList:
//            showNotificationList(route: route, deeplink: deeplink, sidemenuModel: sidemenuModel!)
//        case .profileStripeSettings:
//            sidemenuModel?.trigger.send(menuControllerRoute.index(MenuProfileData.myProfilePayoutSettings))
//        }
//    }
//
//    private func showNotificationList(route: Route, deeplink: DeepLink?, sidemenuModel: MenuViewModel){
//        let userManager = UserManagerFactory.get()
//        if userManager.hasTokken() {
//        let notificationCoordinator = NotificationsCoordinator(userManager:userManager , route: route, sidemenuModel: sidemenuModel)
//        notificationCoordinator.onFinish = {[weak self] in
//            guard let self = self else {return}
//            self.finish()
//        }
//        self.coordinate(to: notificationCoordinator, deepLink: deeplink)
//        route.push(notificationCoordinator.notificationsListController())
//    }
//    }
//    private func showChat(route: Route, deeplink: DeepLink?, sidemenuModel: MenuViewModel){
//        let userManager = UserManagerFactory.get()
//        if userManager.hasTokken() {
//        let chatCoordinator = ChatCooridinator(userManager:userManager , route: route, sidemenuModel: sidemenuModel)
//            chatCoordinator.onFinish = {[weak self] in
//            guard let self = self else {return}
//            self.finish()
//        }
//        self.coordinate(to: chatCoordinator, deepLink: deeplink)
//        route.push(chatCoordinator.chatListController())
//    }
//    }
//}
