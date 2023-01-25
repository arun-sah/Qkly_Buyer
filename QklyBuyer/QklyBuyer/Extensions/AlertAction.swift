//
//  AlertAction.swift
//  Qkly
//
//  Created by Arun Sah on 12/11/2021.
//


import Foundation
import UIKit

/// alert actions
enum AlertAction: AlertActionable {
    case okay
   
    
    var title: String {
        switch self {
        case .okay: return AppString.ok.value
       
            
        }
    }
    
    var style: UIAlertAction.Style {
        switch self {
        case .okay:
            return .destructive
        default:
            return .default
        }
    }
}
