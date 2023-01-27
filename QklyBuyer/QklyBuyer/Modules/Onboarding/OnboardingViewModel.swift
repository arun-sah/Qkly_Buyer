//
//  OnboardingViewModel.swift
//  Qkly
//
//  Created by Asmin Ghale on 1/21/22.
//

import UIKit

class OnboardingViewModel: BaseViewModel {
    /// The cacheManager
     let cacheManager: CacheManager
    
    override init() {
        self.cacheManager = UserDefaultCacheManagerFactory.get()
        super.init()
        
    }

    var slides: [OnboardingSlide] = [
        OnboardingSlide(title: "Get Discovered",
                        imageName: "onboarding_1",
                        description: "Get Discovered & Find world class\ntalent Top talent to provide the services\nyou need"
                       ),
        OnboardingSlide(title: "Perfect Freelancer",
                        imageName: "onboarding_2",
                        description: "Find the perfect freelancer for\nyour business & projects."),
        OnboardingSlide(title: "Track Job Openings",
                        imageName: "onboarding_3",
                        description: "Track all your job applications\nand don’t get\nlost in the process "),
        OnboardingSlide(title: "Invoice & Payment Record",
                        imageName: "onboarding_4",
                        description: "Keep track of all your invoices and\npayments to increase your earnings and\nbusiness quickly."),
    ]
    
}
