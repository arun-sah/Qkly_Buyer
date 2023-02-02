//
//  CongratulationController.swift
//  Qkly
//
//  Created by Arun Sah on 05/05/2022.
//

import Foundation
import UIKit

class CongratulationController: BaseController {
    
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    var viewModel : CongratulationViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        continueButton.qklyButtonround()
        descLabel.text = "Welcome to the Qkly Family.\nWe wish you have a good time and your\nbusiness goes sky rocket."
    }
    @IBAction func continueButtonTapped(_ sender: Any) {
        self.viewModel.trigger.send(AuthRoute.forgotPassword)

    }
}

    
