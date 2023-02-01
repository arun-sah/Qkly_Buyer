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
        let controller = BioMetricController.initialize(from: .biometric)
        controller.viewModel = viewmodel as? BioMetricViewModel
        return controller
    }
    static func congratulationController(viewmodel:BaseViewModel) -> UIViewController {
        let controller = CongratulationController.initialize(from: .congratulation)
        controller.viewModel = viewmodel as? CongratulationViewModel
        return controller
    }
    static func forgotPasswordController(viewmodel:BaseViewModel) -> UIViewController {
        let controller = ForgotPasswordController.initialize(from: .forgotPassword)
        controller.viewModel = viewmodel as? ForgotPasswordViewModel
        return controller
    }
    static func emailConfirmationController(viewmodel:BaseViewModel) -> UIViewController {
        let controller = EmailConfirmationController.initialize(from: .emailConfirmation)
        controller.viewModel = viewmodel as? EmailConfirmationViewModel
        return controller
    }
}
