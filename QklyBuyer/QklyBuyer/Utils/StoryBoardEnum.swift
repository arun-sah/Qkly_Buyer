//
//  StoryBoardEnum.swift
//  QklyBuyer
//
//  Created by arun sah on 19/01/2023.
//


import Foundation
import UIKit

protocol StoryboardInitializable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardInitializable where Self: UIViewController {
    
    static var storyboardIdentifier: String {
        return String(describing: Self.self)
    }
    
    static func initialize(from storyboard: Storyboard) -> Self {
        let storyboard = UIStoryboard(name: storyboard.name, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
    }
    
}

extension UIViewController: StoryboardInitializable {}

enum Storyboard {
    case main
    case onboarding
    case auth
    case dashBoard
    case menu
  
    
    var name: String {
        switch self {
        case .main:
            return "Main"
        case .onboarding:
            return "Onboarding"
        case .auth:
            return "Auth"
        case .dashBoard:
            return "DashBoard"
        case .menu:
            return "Menu"
       
       
        }
    }
    var value: UIStoryboard {
        return UIStoryboard(name: self.name, bundle: Bundle.main)
    }
}
