//
//  EmailConfirmationController.swift
//  QklyBuyer
//
//  Created by arun sah on 01/02/2023.
//
import Foundation
import UIKit
import SwiftyAttributes

class EmailConfirmationController: BaseController {
    
    @IBOutlet weak var contactUsButton: UIButton!
    var viewModel: EmailConfirmationViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let didntSeeIt = AppString.didntSeeIt.value.withAttributes([
            .textColor(UIColor.app_primary_black_0_6 ?? .black),
            .font(UIFont.appRegularFont(ofSize: .size_14))
        ])
        let contactUs = AppString.contactUs.value.withAttributes([
            .textColor(UIColor.app_primary_purple ?? .purple),
            .font(UIFont.appSemiBoldFont(ofSize: .size_14))
        ])
        let text = didntSeeIt + contactUs
        contactUsButton.setAttributedTitle(text, for: .normal)
    }
    @IBAction func continueButtonAction(_ sender: UIButton) {
        viewModel.trigger.send(AuthRoute.facebookEmail)
    }
    
}
