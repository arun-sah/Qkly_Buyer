//
//  ForgotPasswordViewModel.swift
//  Qkly
//
//  Created by Arun Sah on 16/03/2022.
//


import Foundation
import Combine
import Alamofire

class ForgotPasswordViewModel: BaseViewModel {
    
    let userManager: UserManager
    
    init(userManager: UserManager) {
        self.userManager = userManager
        super.init()
        observeValidation()
    }
    
    @Published var email: String = ""
    
    var emailValidationState            = CurrentValueSubject<(Bool, String), Never>((false, ""))
    
    private func observeValidation() {
        $email.sink {[weak self] value in
            guard let self else { return }
            self.emailValidationState.value = self.isEmailValid(string: value ?? "")
        }.store(in: &bag)
    }
    
    func isEmailValid(string: String) -> (Bool, String) {
        let valid = string != "" && string.validateEmail()
        let message: String = {
            if string == "" {
                return "Email should not be empty"
            }
            if !string.validateEmail() {
                return "Please enter a valid email"
            }
            return ""
        }()
        return (valid, message)
    }
    
//    func isValid() -> (Bool, String) {
//        let message = invalidCredentialMessage()
//        return (message == nil, message ?? "")
//    }
    
//    func observeLogin(completion: @escaping(_ statusCode: Int, _ message: String)->()) {
//        userManager.networkingResultLogin.sink {result in
//        }.store(in: &bag)
//    }
//
//    private func invalidCredentialMessage() -> String? {
//        if !email.validateEmail(){
//            return "Please enter a valid email."
//        }
//        return nil
//    }
//
//    func sendForgotPasswordRequest() {
//        userManager.requestForgotPassword(params: email)
//    }
    
}
