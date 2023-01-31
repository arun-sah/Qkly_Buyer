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
}
