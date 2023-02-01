//
//  FaceBookEmailController.swift
//  QklyBuyer
//
//  Created by arun sah on 01/02/2023.
//
import Foundation
import UIKit
import SwiftyAttributes

class FaceBookEmailController: BaseController {
    
    @IBOutlet weak var enterYouEmailLabel: UILabel!
    var viewModel: FaceBookEmailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let didntSeeIt = AppString.enterYour.value.withAttributes([
            .textColor(UIColor.app_primary_black ?? .black),
            .font(UIFont.appBoldFont(ofSize: .size_32))
        ])
        let contactUs = AppString.email.value.withAttributes([
            .textColor(UIColor.app_primary_purple ?? .purple),
            .font(UIFont.appBoldFont(ofSize: .size_32))
        ])
        let text = didntSeeIt + contactUs
        enterYouEmailLabel.attributedText = text
    }
    
}
