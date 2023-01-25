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
    let actionButtonTitle: String
    let initial: Bool
    let titleColor: UIColor
    
    var onboardingView: OnboardingSlideView!
    
    init(title: String, imageName: String, description: String, actionTitle: String, initial: Bool = false, titleColor: UIColor = UIColor.purple) {
        self.title = title
        self.imageName = imageName
        self.description = description
        self.actionButtonTitle = actionTitle
        self.initial = initial
        self.titleColor = titleColor
        setupOnboardingView()
    }
    
    private mutating func setupOnboardingView(){
        let onboardingView = Bundle.main.loadNibNamed("OnboardingSlideView", owner: self, options: nil)?.first as! OnboardingSlideView
        onboardingView.imageView.image = UIImage(named: imageName)
        onboardingView.labelTitle.text = title
        onboardingView.labelDesc.text = description
        onboardingView.callToAction1.isHidden = !initial
        onboardingView.labelTitle.textColor = titleColor
        self.onboardingView = onboardingView
    }

    
}
