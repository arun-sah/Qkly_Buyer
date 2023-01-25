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
        OnboardingSlide(title: "Find Your Dream Career",
                        imageName: "onboarding-1",
                        description: "",
                        actionTitle: "",
                        initial: true),
        OnboardingSlide(title: "60%",
                        imageName: "onboarding-2",
                        description: "of job seekers quit in the middle of filling out online job applications because of their length or complexity. \n\n -talentlyft.com", actionTitle: "",
                        titleColor:  .blue),
        OnboardingSlide(title: "Search Out Your Passion",
                        imageName: "onboarding-3",
                        description: "-Full-time and part-time positions for both remote and onsite work\n\n-Upload your resume or use our online resume builder\n\n-Easily apply to jobs with one click",
                        actionTitle: "", titleColor: .black),
        OnboardingSlide(title: "75%",
                        imageName: "onboarding-4",
                        description: "of candidates will research a company's reputation before applying for a job opening.\n\n -talentlyft.com",
                        actionTitle: ""),
    ]
    
}
