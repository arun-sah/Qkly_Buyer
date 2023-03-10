//
//  ControllerRoute.swift
//  QklyBuyer
//
//  Created by arun sah on 19/01/2023.
//

import Foundation
import Foundation
import UIKit
import SideMenuSwift

struct ControllerRoute {
    
    static func onboardingController(viewmodel: BaseViewModel) -> UIViewController {
        let onController = OnboardingController.initialize(from: .onboarding)
        onController.viewModel = viewmodel as? OnboardingViewModel
        return onController
    }
    static func bioMetricController(viewmodel:BaseViewModel) -> UIViewController {
        let controller = BioMetricController.initialize(from: .auth)
        controller.viewModel = viewmodel as? BioMetricViewModel
        return controller
    }
    static func congratulationController(viewmodel:BaseViewModel) -> UIViewController {
        let controller = CongratulationController.initialize(from: .auth)
        controller.viewModel = viewmodel as? CongratulationViewModel
        return controller
    }
    static func forgotPasswordController(viewmodel:BaseViewModel) -> UIViewController {
        let controller = ForgotPasswordController.initialize(from: .auth)
        controller.viewModel = viewmodel as? ForgotPasswordViewModel
        return controller
    }
    static func emailConfirmationController(viewmodel:BaseViewModel) -> UIViewController {
        let controller = EmailConfirmationController.initialize(from: .auth)
        controller.viewModel = viewmodel as? EmailConfirmationViewModel
        return controller
    }
    static func faceBookEmailController(viewmodel:BaseViewModel) -> UIViewController {
        let controller = FaceBookEmailController.initialize(from: .auth)
        controller.viewModel = viewmodel as? FaceBookEmailViewModel
        return controller
    }
    
    static func dashboardController(viewmodel:BaseViewModel) -> UIViewController {
        let controller = DashboardController.initialize(from: .dashBoard)
        controller.viewModel = viewmodel as? DashboardViewModel
        return controller
    }
    
    static func menuController(viewmodel:BaseViewModel) -> UIViewController {
        let controller = MenuController.initialize(from: .menu)
        controller.viewModel = viewmodel as? MenuViewModel
        return controller
    }
    
    static func createAccountController(viewmodel:BaseViewModel) -> UIViewController {
        let controller = CreateAccountController.initialize(from: .createAccount)
        controller.viewModel = viewmodel as? CreateAccountViewModel
        return controller
    }
}
