//
//  ForgotPasswordController.swift
//  Qkly
//
//  Created by Arun Sah on 16/03/2022.
//

import Foundation
import UIKit
import SwiftyAttributes

class ForgotPasswordController: BaseController {
    
    @IBOutlet weak var ranIntoTrouble: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    
    
    var viewModel: ForgotPasswordViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        uiSetUp()
       
    }
    
    func uiSetUp(){
        
        let ranInto = AppString.ranInto.value.withAttributes([
            .textColor(UIColor.app_primary_black ?? .black),
            .font(UIFont.appBoldFont(ofSize: .size_32))
        ])
        let trouble = AppString.trouble.value.withAttributes([
            .textColor(UIColor.app_primary_purple ?? .purple),
            .font(UIFont.appBoldFont(ofSize: .size_32))
        ])
        let text = ranInto + trouble
        ranIntoTrouble.attributedText = text
        
        descLabel.text = AppString.forgotDesc.value
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func observeEvents() {}
    
    func validateAndRequest() {
//        let validation = viewModel.isValid()
//        if validation.0{
//            showHUD()
//            viewModel.sendForgotPasswordRequest()
//        }else{
//            showAlert(msg: validation.1)
//        }
    }
    
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
        //validateAndRequest()
        viewModel.trigger.send(AuthRoute.emailConfirmation)
    }
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension ForgotPasswordController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
            view.endEditing(true)
            validateAndRequest()
    
        return true
    }
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        if textField == emailTextField {
//            viewModel.email = emailTextField.text ?? ""
//        }
//    }
    
}
