//
//  ControllerRoute.swift
//  QklyBuyer
//
//  Created by arun sah on 19/01/2023.
//

import Foundation
import Foundation
import UIKit

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
}
