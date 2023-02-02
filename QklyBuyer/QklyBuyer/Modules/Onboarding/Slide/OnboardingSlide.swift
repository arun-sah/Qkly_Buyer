//
//  OnboardingSlide.swift
//  Qkly
//
//  Created by Asmin Ghale on 1/21/22.
//

import UIKit

struct OnboardingSlide {
    
    let title: String
    let imageName: String
    let description: String
    
    var onboardingView: OnboardingSlideView!
    
    init(title: String, imageName: String, description: String) {
        self.title = title
        self.imageName = imageName
        self.description = description
        setupOnboardingView()
    }
    
    private mutating func setupOnboardingView(){
        let onboardingView = Bundle.main.loadNibNamed("OnboardingSlideView", owner: self, options: nil)?.first as! OnboardingSlideView
        onboardingView.imageView.image = UIImage(named: imageName)
        onboardingView.titleLabel.text = title
        onboardingView.descLabel.text = description
        self.onboardingView = onboardingView
    }

    
}
