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
    
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var enterYouEmailLabel: UILabel!
    
    @IBOutlet weak var emailTextField: QBValidationTextField!
    
    @IBOutlet weak var backIconButton: UIButton!
    var viewModel: FaceBookEmailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupUI() {
        backIconButton.setImage(UIImage.icon_arrow_left?.withTintColor(UIColor.app_white ?? .white, renderingMode: .alwaysOriginal), for: .normal)
        
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
        
        emailTextField.textFieldPlaceholder = "Enter Email here"
        emailTextField.titlePlaceholder = "Your Email Id"
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if UIDevice.current.userInterfaceIdiom == .pad {
            facebookButton.layer.cornerRadius = 50
        } else {
            facebookButton.layer.cornerRadius = 43

        }
    }
    
    @IBAction func continueButton(_ sender: Any) {
        self.viewModel.trigger.send(AuthRoute.createAccount)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
